Received: from mailout-002.p.bluenet.ch (mailout-002.p.bluenet.ch [138.188.174.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F78186347
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.188.174.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774629016; cv=none; b=CWOjUVN4FzVTK2LJPyvWmihbvSoqC7ntdgZlZFm4T2INGaT0+jQX9upmFyTK81SNBQRdSS13wGDchF77pBFmRPQ+a57k14BgYld2pPDyHokSdd4M0lCkkesAUlnGvpkJtmS1X2nSnye3O07ADkcT4pS2LponUyUtbcv7SAdRgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774629016; c=relaxed/simple;
	bh=fGfQ4QBKd+N0sW6BqC1RT1f/91p2zVM8763IWL4Pmik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSci17DvBSHkF9pkydETGE6nt7tsC4mYEyUFFc9zuDgQkdPGBdoqiCmDhJWLrxZqftpQtJzpSowmtnhGS+NmR16ajdLYl7USI9gQeZeD8NVKezGJcLPvUrHxDQsWT/3ZcyJFVHz/AztMPXLdcXy9Sb7/9yW3sYrCdi2ctRn7iQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluewin.ch; spf=pass smtp.mailfrom=bluewin.ch; dkim=pass (2048-bit key) header.d=bluewin.ch header.i=@bluewin.ch header.b=X+5JWeCA; arc=none smtp.client-ip=138.188.174.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluewin.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluewin.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluewin.ch header.i=@bluewin.ch header.b="X+5JWeCA"
Received: from [192.168.21.108] ([79.154.91.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by mailout-002.p.bluenet.ch Swisscom AG with ESMTPSA
	id 6A2XwOkQhXDiX6A2XwB0s0; Fri, 27 Mar 2026 16:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluewin.ch;
	s=fxzs-2048-20230414; t=1774628886;
	bh=PyUlgyN5xrDfI1HryoJWqtxr6LWXaS1looiO7fMsclk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From;
	b=X+5JWeCAHboDzCGTrNFrUxlQ0BYeZ6hxoqph+jUeU/SM53IyzXlqwAuAPdPzFjYKN
	 wCZrzMnYtu8PKI2fE/0AjEuIyMLyPfkcuckdJinzL2Tr2FxsRxZkFFfz2Q5a26pYoq
	 GFH3rgDbb9/8Dc6zfuS8pl2jTTtOeqjnRKkwr1LPxKO5NPAvR0JvGXtc+2+imWH4yx
	 WpUyYcKEpc3Zp8f8Cu/1eUhnrqoy8U3OpOX7ZqbkXP1LvhjGM6lIvhPblNtR/Y53O/
	 BoYI4OYTjLY8r4yrjZXGrPYSB1Zm80AHz0L/9L2T7dHzGGHVw/8mzBbalvrDUwM0OU
	 Gl1jfI8c8oFUA==
X-Bluewin-Spam-Analysis: v=2.4 cv=IPIyzAvG c=1 sm=1 tr=0 ts=69c6b016
 a=WY6/0jjk7zsOyTa5/3SlqA==:117 a=WY6/0jjk7zsOyTa5/3SlqA==:17
 a=IkcTkHD0fZMA:10 a=8aoxcsf_4YlTAHqYW78A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Bluewin-Spam-Score: 0.00
Message-ID: <fbe531eb-b742-4cd1-ab6a-2eaaf8d236c5@bluewin.ch>
Date: Fri, 27 Mar 2026 17:28:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix git stash grammar
To: Junio C Hamano <gitster@pobox.com>, Mirko Faina <mroik@delayed.space>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Quentin Bernet via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
 <CALnO6CD-5NBUoooMD+pQAxeyXCjkZ3Za6LJrLrJN57Nrz03xBw@mail.gmail.com>
 <acXIl2cuBv0ifiK6@exploit> <xmqqqzp5mfh5.fsf@gitster.g>
Content-Language: en-US
From: Quentin Bernet <quentin.bernet@bluewin.ch>
In-Reply-To: <xmqqqzp5mfh5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCgowfq4xuBlzj7Nvkkoq7lt/ofmbjtlvtTkb4XVkADvTGrecnof2H65usxR3xZACoNAlxPR06Cuk+tcefkgo0rpY6s/nExUFs+RA8pb2Abh0tnIh2ws
 qc9He2x71xZnb65+NR1Zc9qgPS3F7Hyvf+dQxYv+wraXjffNlCWIYsze8CN23THlMmDHA2/cQlhbTbClUao+yiSXBsaunbHlV90igbq9af76OLaeVVviGPA4
 I9Favw7kjABZ1WBNGJ7DWh+aDrZ85oB3EdP0TGd/uyqGbAGyB/bOe8W0KLvX0BYhuy5CsrUMAqElimGfD5OfN/SgxY9o3fT4iNibhSPzLf0=

Please keep in mind this is my first contribution to git, and learning 
the ways things are done here, so things might take more time than usual

I believe to be fully correct, this should be the grammar:
(or some other ordering)


  [synopsis]
+git stash [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | 
--quiet]
+            [-u | --include-untracked] [-a | --all] [(-m | --message) 
<message>]
+            [--pathspec-from-file=<file> [--pathspec-file-nul]]
+            [-- <pathspec>...]
  git stash list [<log-options>]
  git stash show [-u | --include-untracked | --only-untracked] 
[<diff-options>] [<stash>]
  git stash drop [-q | --quiet] [<stash>]
  git stash pop [--index] [-q | --quiet] [<stash>]
  git stash apply [--index] [-q | --quiet] [<stash>]
  git stash branch <branchname> [<stash>]
-git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] 
[-q | --quiet]
+git stash push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] 
[-q | --quiet]
              [-u | --include-untracked] [-a | --all] [(-m | --message) 
<message>]
              [--pathspec-from-file=<file> [--pathspec-file-nul]]
-            [--] [<pathspec>...]]
+            [--] [<pathspec>...]
  git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] 
[-q | --quiet]
             [-u | --include-untracked] [-a | --all] [<message>]
  git stash clear

You'll note the difference between the "stash" and "stash push" options 
is "[-- <pathspec>...]" vs "[--] [<pathspec>...]", which corresponds to

            For quickly making a snapshot, you can omit "push". In this 
mode,
            non-option arguments are not allowed to prevent a misspelled
            subcommand from making an unwanted stash entry. The two 
exceptions
            to this are stash -p which acts as alias for stash push -p and
            pathspec elements, which are allowed after a double hyphen 
-- for
            disambiguation.

The wording seems a bit weird, since the only non-option arguments are 
"<pathspec>...", which it later explains are allowed (but require double 
hypen)


This grammar is better at highlighting `git stash` on its own is valid, 
but worse at showing that the flags are almost the same
I don't think we can do better grammar-wise, since "push" is at the very 
start, and "--" at the end, and grammars don't have memory

My previous, simpler, grammar included "git stash <pathspec>" even 
though it is not valid.
Maybe that is an acceptable trade-off for clarity (although I assume not)

On 3/27/26 16:58, Junio C Hamano wrote:
> Mirko Faina <mroik@delayed.space> writes:
>
>> On Thu, Mar 26, 2026 at 12:17:46PM -0400, D. Ben Knoble wrote:
>>> Now, _is_ the grammar bracketed wrong? "git help stash" says
>>>
>>>             For quickly making a snapshot, you can omit "push". In this mode,
>>>             non-option arguments are not allowed to prevent a misspelled
>>>             subcommand from making an unwanted stash entry. The two exceptions
>>>             to this are stash -p which acts as alias for stash push -p and
>>>             pathspec elements, which are allowed after a double hyphen -- for
>>>             disambiguation.
>>>
>>> So _if_ you want to provide options (other than "-p"), the "push" is
>>> required. I think the existing brackets indicate that.
>> When it says "In this mode, non-option arguments are not allowed"
>> wouldn't -m be allowed as it is an option and not a non-option? In fact
>> if we do try to run "git stash -m something" it does correctly stash
>> while if we do something like "git stash pathspec" it does give back
>> "fatal: subcommand wasn't specified; 'push' can't be assumed due to
>> unexpected token 'pathspec'".
>>
>> If that is the case then there is an issue with the way the usage
>> tooltip shows the optionality of "push".
> Yup, you're right.  The current SYNOPSIS suggests that you can omit
> and say "git stash" and it does the "push" thing, but when you want
> to give any "push" related options, the command name "push" becomes
> mandatory before them.
>
> If the log message said something like
>
>      The "[optionality]" bracket is misplaced on the command line for
>      "git stash push" in the synopsis section.  It is not like you
>      can omit "push" only when you do not give any options and
>      arguments.
>
> we wouldn't be having this long thread, I suspect.
