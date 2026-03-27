Received: from mailout-006.p.bluenet.ch (mailout-006.p.bluenet.ch [138.188.174.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD73FA5FB
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.188.174.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633022; cv=none; b=e7B9QYbrmAzejdLQ7ND+k5+dO4K79wUs9CS/NUJTn+lXmsCOHeHJq7USalM6zRbMaFZ+Ft48FhuzIG4FigJdsvQiqtZZpCeYNb1dMHWrHVZhDQ02Rqgqnvbaph6/BOzKH+nQptBRBa/cA9DAbszwh7RIgQ7XNR3yu/Owlv6X294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633022; c=relaxed/simple;
	bh=RUTFzlacZr3y7KOZNplp7GRc5hcQ6fhrFmKkoyYNO8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfupwJpG7u00hIRFmDMkxwXjhkFA4ui3TV+hco3EhtIaSRfpxNoBcGS1hKZsvEYYVZqswVxyundnsiQQ03/bodRPUWZrvHcJ8WHezyqapdx70DUvKiZRxQlV8Xje98mj1iSZWYozzswNpSHssycRmfF0r5j9jFCVRnqGZQJVcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluewin.ch; spf=pass smtp.mailfrom=bluewin.ch; dkim=pass (2048-bit key) header.d=bluewin.ch header.i=@bluewin.ch header.b=FNr2rWDR; arc=none smtp.client-ip=138.188.174.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluewin.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluewin.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluewin.ch header.i=@bluewin.ch header.b="FNr2rWDR"
Received: from [192.168.21.108] ([79.154.91.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by mailout-006.p.bluenet.ch Swisscom AG with ESMTPSA
	id 6B78w5GyEtv3m6B79wKFar; Fri, 27 Mar 2026 17:36:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluewin.ch;
	s=fxzs-2048-20230414; t=1774633015;
	bh=6hanI+P/tu1Z6V6ivcAvmmYxzVkIJLNw76vKkVtyqOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From;
	b=FNr2rWDRQ0VYCnKc0qbfFaJ6wpR2lsF+A0T+GoFaH+ubWi1igZztRtlOUyDSNvm89
	 eLwrPYDE3h9orquXOt2P2BM3hwHTpT2z4RQTqYKkfEiipe8NrgKVJWaTOV+2s8KdxY
	 lRAXKumJFJclsMvh8fHYDV6zW9Jcq1kncbe9hiWXy05aMTHdsZHPHnXuGNYVdz0C35
	 IRudzynuU+S4LpOpj1khrFpWQrpjjDzv4HyY/D1pm+gYkUPSE6dYPMhd0JMUHLGPVD
	 IdDyIDXzGWBte+S1I2sQVTmngNKgNKcP8/efct95LZk21WLZXdq8MgyXCVNZb5kl5W
	 zRIt7u+ODyg+A==
X-Bluewin-Spam-Analysis: v=2.4 cv=X8xi7mTe c=1 sm=1 tr=0 ts=69c6c037
 a=WY6/0jjk7zsOyTa5/3SlqA==:117 a=WY6/0jjk7zsOyTa5/3SlqA==:17
 a=IkcTkHD0fZMA:10 a=DeIIBJn7KGIvGhicOCYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Bluewin-Spam-Score: 0.00
Message-ID: <6b5a5bd8-0631-4c1b-b87b-c75d99dc9c50@bluewin.ch>
Date: Fri, 27 Mar 2026 18:36:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix git stash grammar
To: Junio C Hamano <gitster@pobox.com>
Cc: Mirko Faina <mroik@delayed.space>, "D. Ben Knoble"
 <ben.knoble@gmail.com>,
 Quentin Bernet via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
 <CALnO6CD-5NBUoooMD+pQAxeyXCjkZ3Za6LJrLrJN57Nrz03xBw@mail.gmail.com>
 <acXIl2cuBv0ifiK6@exploit> <xmqqqzp5mfh5.fsf@gitster.g>
 <fbe531eb-b742-4cd1-ab6a-2eaaf8d236c5@bluewin.ch>
 <xmqq7bqxkyd5.fsf@gitster.g>
 <9d0befb7-4f2b-4b47-bf9c-784fcacfe418@bluewin.ch>
 <xmqqtsu1jipp.fsf@gitster.g>
Content-Language: en-US
From: Quentin Bernet <quentin.bernet@bluewin.ch>
In-Reply-To: <xmqqtsu1jipp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPbYiE8152m5GKLItsrIHm+XZEi3Qqb7yixpOGYm227CUZTy9hBtexcxgjzGgK+rhO9ple0AWtSyBuWir+Cf4RzcVlT0IxGoz2Bg9z5mba9Xa9InqbyP
 e7/B0Fn+YO4djus65QAGpLFMG5DQZcjNHy+Ji8NRKQs2nj2IAfbe0/iSA7pHXxCI+VFjqrYofw8R7igHIVEiJACWV0Vw9MnMkmBBpAnnkjpB0HZWZBAPzhN9
 jtGGh0qBxs+IB2gG44YZzq5lYVuwYG/91whTBD9iAFcbGmLw2Gk05lsPzV5FVqVRp5tau3R3MtXgTpU4HqnSTa1l8nUXLYH69rY7h4J+mXI=

I'm assuming "#leftoverbits" means "this is something that would be 
nice, but which is for another time"
And I'll leave the pleasure of implementing that to someone more 
well-versed in C and git internals !


Therefore my previous change (current status of the github PR) works, as 
a reminder, here it is:


diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 235d57ddd8..41086c21a4 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -14,10 +14,10 @@ git stash drop [-q | --quiet] [<stash>]
  git stash pop [--index] [-q | --quiet] [<stash>]
  git stash apply [--index] [-q | --quiet] [<stash>]
  git stash branch <branchname> [<stash>]
-git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] 
[-q | --quiet]
+git stash [push] [-p | --patch] [-S | --staged] [-k | 
--[no-]keep-index] [-q | --quiet]
              [-u | --include-untracked] [-a | --all] [(-m | --message) 
<message>]
              [--pathspec-from-file=<file> [--pathspec-file-nul]]
-            [--] [<pathspec>...]]
+            [--] [<pathspec>...]
  git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] 
[-q | --quiet]
             [-u | --include-untracked] [-a | --all] [<message>]
  git stash clear
diff --git a/builtin/stash.c b/builtin/stash.c
index 95c5005b0b..0d27b2fb1f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -50,10 +50,10 @@
  #define BUILTIN_STASH_STORE_USAGE \
         N_("git stash store [(-m | --message) <message>] [-q | --quiet] 
<commit>")
  #define BUILTIN_STASH_PUSH_USAGE \
-       N_("git stash [push [-p | --patch] [-S | --staged] [-k | 
--[no-]keep-index] [-q | --quiet]\n" \
+       N_("git stash [push] [-p | --patch] [-S | --staged] [-k | 
--[no-]keep-index] [-q | --quiet]\n" \
            "          [-u | --include-untracked] [-a | --all] [(-m | 
--message) <message>]\n" \
            "          [--pathspec-from-file=<file> 
[--pathspec-file-nul]]\n" \
-          "          [--] [<pathspec>...]]")
+          "          [--] [<pathspec>...]")
  #define BUILTIN_STASH_SAVE_USAGE \
         N_("git stash save [-p | --patch] [-S | --staged] [-k | 
--[no-]keep-index] [-q | --quiet]\n" \
            "          [-u | --include-untracked] [-a | --all] [<message>]")


Is there something else I should do ?


On 3/27/26 18:16, Junio C Hamano wrote:
> Quentin Bernet <quentin.bernet@bluewin.ch> writes:
>
>> Just so we're clear: my previous grammar did allow "git stash path1
>> path2" (no "push", no "--"), which is not allowed
>> Do you still think it is good enough ?
> Absolutely.
>
> It is not huge enough issue to warrant separating synopsis form for
> push into two almost identical pairs, and having to maintain both of
> them.  It would be sufficient to make sure the readers understand
> that they may have to disambiguate pathspec with "--" like any other
> command (like "git log foo" when you have both file "foo" and tag
> "foo") in the description part.
>
> One thing that we may want to fix in the code is that we probably do
> not want to require "--" when doing something like
>
>      git stash -m foo <pathspec>
>
> to assume that it is a lazy "push" that does not say "push".
> Currently we complain against the lack of subcommand name.
>
> Once "-m" (i.e., a potential option) is seen before seeing any
> subcommand, we can commit to treat it as a lazy "push", and have the
> parser pretend as if we got
>
>      git stash push -m foo <pathspec>
>
> We may see "git stash -m foo --no-such-option garbage arge" and the
> option and argument parser of "git stash push" becomes responsible
> for complaining about such a command line.
>
> #leftoverbits obviously.
>
