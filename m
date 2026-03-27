Received: from mailout-001.p.bluenet.ch (mailout-001.p.bluenet.ch [138.188.175.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6E36CDEC
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.188.175.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774600041; cv=none; b=N0Gu0Q6lsPEK11OL9exfUOc1da4D95DsTZN5WpYfD36WtRylEjOzP7TTUxK3c1GdUbW6HUUnTvmWhJi+JzDZnn8mxMhLe0iPhHGA//277cRZyIfX9v+KK4CL2krPbMfK/enBDNdURxvSlOd9OGcoeqPuJXt4bPEonWJjlAyu39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774600041; c=relaxed/simple;
	bh=V8A8M+0HMyCl1soQ7OW28BKDrnXZ1marxuFYf5PRwTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDl3UHnGEArRkFPCuZiLWhZRc3k1i27TBUJg7cHwh0C6Iq+VA2OPcBdNzMmRxxRe3pTkStoB4NqXh3cyJoH1O6VBtWsbKwiUfZjouOp3rQR3ugzqj2hven/NiwiijFA+hKjBmeS8PNRT/Wfuo9k36+iyD92lkPf1AiH58RUcO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluewin.ch; spf=pass smtp.mailfrom=bluewin.ch; dkim=pass (2048-bit key) header.d=bluewin.ch header.i=@bluewin.ch header.b=KKJZSSnY; arc=none smtp.client-ip=138.188.175.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bluewin.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluewin.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluewin.ch header.i=@bluewin.ch header.b="KKJZSSnY"
Received: from [192.168.21.108] ([79.154.91.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by mailout-001.p.bluenet.ch Swisscom AG with ESMTPSA
	id 62VBwAAlmDkrf62VBwGHD4; Fri, 27 Mar 2026 08:25:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluewin.ch;
	s=fxzs-2048-20230414; t=1774599910;
	bh=iopg345agG5RVpTraFodjEHRXXIcbgn3lepzrrIoEZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From;
	b=KKJZSSnY/eF09SSyQbIDiWYnktxHuuCf9ezdSgf8NPID2mDjH394Cx4ec6dxa4s3X
	 haUf9XK+/PiDn7tZQT9dv0c/TLmW47EMMQj28Gb0vJjsSntLBer84klQ/0o8ZRrvS/
	 ZU22x+/mOOAiTbmaaiRZ3ZtgGvSJ/KUq+W45oUyLaJAwahdAurMKcklnpWsgmzUSaU
	 A4dsHrVqk8W17sA3drQiQfMtCtYMshjZeAH7AWWvmUqp09Uh6PZIzxOe7lq9denZAB
	 1+BdSnO5OflUbapbZNZJlPdHk0W5XvE9tEqdbKbtbzuH9vq07941hH8DyEIYs+XLju
	 Z1VFy3K3PwUDg==
X-Bluewin-Spam-Analysis: v=2.4 cv=SMtykuvH c=1 sm=1 tr=0 ts=69c63ee6
 a=WY6/0jjk7zsOyTa5/3SlqA==:117 a=WY6/0jjk7zsOyTa5/3SlqA==:17
 a=IkcTkHD0fZMA:10 a=w0RzvLSWAAAA:20 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
 a=GrsELN7seP4a2jTIFLYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Bluewin-Spam-Score: 0.00
Message-ID: <ce083a4a-321d-4c29-af04-decfab33d237@bluewin.ch>
Date: Fri, 27 Mar 2026 09:25:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix git stash grammar
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Quentin Bernet via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
 <CALnO6CD-5NBUoooMD+pQAxeyXCjkZ3Za6LJrLrJN57Nrz03xBw@mail.gmail.com>
Content-Language: en-US
From: Quentin Bernet <quentin.bernet@bluewin.ch>
In-Reply-To: <CALnO6CD-5NBUoooMD+pQAxeyXCjkZ3Za6LJrLrJN57Nrz03xBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMOhu3wV2GML4k+oPE+cBtTKAemfn3ziR0ypGHqpEgilNK3UHyVpHUnNvAIdGUzwIULHS5UubmVJUt94hBo71zB5uxEOh55C5cBlAbNd+1JcVFZlS4EH
 ++YGWVCFGJ6VZDW2pdgAC4pjhLhpS5ai/dE52LcOyJJLtQncAd4xObPPX76xWBfpeajQuCCL1PFpxmLDTA4o7NjBK/E/0mAOjhAZATmtQ7cqFj1DbivtBDbo
 R4P7b37ChfUWRtNt+f33KNW/yk6/k2lOcqHQrHf9zPA=

This seems to be describing more the content of the patch than the 
intention behind it, what about:

The grammar for "git stash" does not contain valid combinations such as
"git stash --include-untracked"; fix it

On 3/26/26 17:17, D. Ben Knoble wrote:
> On Thu, Mar 26, 2026 at 8:46 AM Quentin Bernet via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> From: Quentin Bernet <quentin.bernet@bluewin.ch>
>>
>> Grammar incorrectly did not include `git stash -m`
>> and other valid `git stash push` flags
> Typically commits for Git describe
> - the current situation (present tense)
> - commands to make the code better
>
> In this case, something like
>
>      The grammar for "git stash" is incorrectly bracketed; fix it.
>
> ?
>
>> Signed-off-by: Quentin Bernet <quentin.bernet@bluewin.ch>
>> ---
>>      Fix git stash grammar
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2255%2FSporarum%2Fpatch-1-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2255/Sporarum/patch-1-v1
>> Pull-Request: https://github.com/git/git/pull/2255
>>
>>   Documentation/git-stash.adoc | 4 ++--
>>   builtin/stash.c              | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
>> index 235d57ddd8..41086c21a4 100644
>> --- a/Documentation/git-stash.adoc
>> +++ b/Documentation/git-stash.adoc
>> @@ -14,10 +14,10 @@ git stash drop [-q | --quiet] [<stash>]
>>   git stash pop [--index] [-q | --quiet] [<stash>]
>>   git stash apply [--index] [-q | --quiet] [<stash>]
>>   git stash branch <branchname> [<stash>]
>> -git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
>> +git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
>>               [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
>>               [--pathspec-from-file=<file> [--pathspec-file-nul]]
>> -            [--] [<pathspec>...]]
>> +            [--] [<pathspec>...]
>>   git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
>>              [-u | --include-untracked] [-a | --all] [<message>]
>>   git stash clear
>> diff --git a/builtin/stash.c b/builtin/stash.c
>> index 95c5005b0b..0d27b2fb1f 100644
>> --- a/builtin/stash.c
>> +++ b/builtin/stash.c
>> @@ -50,10 +50,10 @@
>>   #define BUILTIN_STASH_STORE_USAGE \
>>          N_("git stash store [(-m | --message) <message>] [-q | --quiet] <commit>")
>>   #define BUILTIN_STASH_PUSH_USAGE \
>> -       N_("git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
>> +       N_("git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
>>             "          [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]\n" \
>>             "          [--pathspec-from-file=<file> [--pathspec-file-nul]]\n" \
>> -          "          [--] [<pathspec>...]]")
>> +          "          [--] [<pathspec>...]")
>>   #define BUILTIN_STASH_SAVE_USAGE \
>>          N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
>>             "          [-u | --include-untracked] [-a | --all] [<message>]")
>>
>> base-commit: ce74208c2fa13943fffa58f168ac27a76d0eb789
>> --
>> gitgitgadget
> Now, _is_ the grammar bracketed wrong? "git help stash" says
>
>             For quickly making a snapshot, you can omit "push". In this mode,
>             non-option arguments are not allowed to prevent a misspelled
>             subcommand from making an unwanted stash entry. The two exceptions
>             to this are stash -p which acts as alias for stash push -p and
>             pathspec elements, which are allowed after a double hyphen -- for
>             disambiguation.
>
> So _if_ you want to provide options (other than "-p"), the "push" is
> required. I think the existing brackets indicate that.
>
