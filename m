Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866831CF9C
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432242; cv=none; b=tBMyEY+imXsmIFyAR9Sy3L9gAt9h2qhz4FJlM0eq9KnPZ5wKjHfH+UjNpyDlb5x1lrlswusSPC4+9IDNM9+4nsCo7AhRzlnUm6isfEeX4vCKA2w9KEEGIPO369biCWiaoO3GEzL4ovq/vR3ad+OUaYEFKgCqLs3rv54hHai0ql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432242; c=relaxed/simple;
	bh=Y6OEvziQHmJkOdX3cE3VCE+oz6jPSGdrrZNvdbRexOs=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=ZgI55/0eQL97HKobk+gGu/0D9Nncf2O82Bgigqr9iK78k5Bfcydi+Ft7FoOth18KFSQjNJYAH9mTw19RHfIRGDK6GzmUlm1/iLMwcKndvBYmlHDMY3CSU/q0Cmk4Zcrq1AIMge132w7lJaBAM0rhdidiwzm/pkUrE8ML2c7k7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=IzkE33Ly; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="IzkE33Ly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705432237; x=1706037037; i=l.s.r@web.de;
	bh=Y6OEvziQHmJkOdX3cE3VCE+oz6jPSGdrrZNvdbRexOs=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=IzkE33LyuHlxFuqRtJOJ8u0nibNJ4wo5GoT+xtG1qTRGvIt0V0I/v0xm40gRkuXx
	 bQccAnzckyJyMEmU6khQ9eQeZQidXQBAugzqII+f6cgXdDnhxkIlxnfk3rDneW4SR
	 oGrihy5QfRmKGi9pI0976Ngj3eYN8r7zH1BnqUIg+UYi1RRuvg2l/YqJSmn2ZWWWP
	 pPidewLzy1+4pSSkCIWPmNJhJb+QX8Vm6Tof+bqy36Q+ganIRW35z+z3bIF822IW4
	 u7a2Tb9FkxddPFMqzfym5sLP3EU/2JDgvlK5RzMRyNkDhlcXPiYmEVlzVbQ2UqzEW
	 9HdbZUTYRvbOnBooXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.146.177]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2ggX-1rQeRO3FrL-004KMP; Tue, 16
 Jan 2024 20:10:37 +0100
Message-ID: <2914293d-7128-435c-9e02-0531954cab26@web.de>
Date: Tue, 16 Jan 2024 20:10:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-bugreport-2024-01-16-2051
To: Vaibhav Naik <vaibhavnaik2004@gmail.com>, git@vger.kernel.org
References: <CALZECO2kHf_qPX06kOUPbJT_hNd5Txt9FTh_Pxr+9x_sMJdKOg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CALZECO2kHf_qPX06kOUPbJT_hNd5Txt9FTh_Pxr+9x_sMJdKOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RL9XxXtDsRDgpuulhLWSvjUpqKo8CG/hGonswoLTGta0xDsJYJx
 94DiOqabsD0oMwr7ZtPJzOp2LbC0+jKwkrEQnpKMYFSyBhEc8SPfafCRKe9wz3gsHVxMoaA
 akBRulO/N/Z2dA3MIcvwsx0q7J2+3CAMRTXjnBx47fhQc6z6uWMw1mGMXWbR1AxvesdVjer
 a4SSkqDYXqTul3pKJ+ZkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lV3CLnbd8eU=;cooN84CBuAoDuhOlpQ8lUOvbTGH
 9Ewczi9K2NxMR+8sH/h+XuwvX5audtYROMRUBirkZufa7MxQSbmNBlqhIaS8WuSR7f9oWUbHP
 yb0J33KiU0PmNyWd6i2bUzfCmbtzuGbNyqR0KwY9rrpYSYALbONYnrFPdN4auuY7MVuUX7tQ6
 XIeznFQ2jSOMVM/tAt+rkjQXGTp5dKykn7qUCm+uYmcBjYjkaNGIzbNstpiyWXhbIubQXOqKQ
 nqSQsbnOULFt0LlB8VmbmZ5JtVmXseIWguD/257Pt7iW146UbV3Rui892L8qXN6Kx+cgqztYa
 +ULP8cU3hWRdd0im6VemB8jh6YL3DtdxRfb2CLjoHX/m1/kOnE+CqooyO/yK/KHUNZZ3szFvv
 VdYRelrLP3svZUQMr0zVqbzQmq5AhSdotWhrafX3wBflMOGNFRvFfyGS5pX9MbIDxFIL92nm8
 AxX313Wvf+0EEFLbWjr28HnEUPg/SA0cNhZUV0NjSxGr/8W7WZ83j6e+Ws+ZTyQGr4GJpZTgf
 UZwlfeyOuMCutoNr34PpsScX+Ybcrd7Zb3Q22fvzv9oOJ73aSsQE4uuPhaiBRXJ2Lu059Boqs
 f2PsgGNRQqveJIkLfKTMTxqL2DBrmViG6lmgtdOrDF5xmAhRQWmANKC1B1HE/lWdAY2aVMH80
 ge+aOrxM455Y0aFQwN0G0t30ulM7f1kMPA1js4DrR8YE2DiTH9HssZjvP5+IQEmw6lbu4ZY52
 UBCsCNhBtVO5O3qkmE9bUu82qsqNZpyWplHkKoTEAhktGnZvJMgVrnDtUdAw65BnQ70os8xBY
 X4TOa/55mZgeXdyLV1CtyjxmeVgIMBB1rHN/LY3PipSTXUPqa68kQyYu9dpFz9Cy3MJSJaUu0
 AHBqZ6nk/3Stu/lZUGzA9TiYUpTqsyTaQpoJdWT5Mx9S9vUOyeIUbq6IUVb9bJWDpJWmYn9iX
 QaQTog==

Am 16.01.24 um 16:30 schrieb Vaibhav Naik:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> i typed this command in order:
> git checkout ca35d53
> git tag 1.1.2
> git commit --allow-empty -m "want to commit at any cost"
> (i just wanted to commit to catch the bug)
>
> What did you expect to happen? (Expected behavior)
> when I checkout, it was showing the commit id at the place of HEAD Point=
:
> vaibh@VaibhavNaik MINGW64 /d/E Drive/MyCodes/Git-Testing ((ca35d53...))
> and then after creating a new tag it was showing the tag name at the pla=
ce of HEAD Point:
> vaibh@VaibhavNaik MINGW64 /d/E Drive/MyCodes/Git-Testing ((1.1.2))
> which is wrong, that place is to show where the HEAD is pointing at and =
not the newly created tag name

The "it" in "it was showing the tag name" is your prompt, right?  It
looks like the one provided by contrib/completion/git-prompt.sh.  A
version of that script is at [1].  It is quite long and configurable,
but it shows the output of "git describe --tags --exact-match HEAD" if
the HEAD commit is tagged or otherwise its abbreviated hash.

Which matches what you see: both your (detached) HEAD and your tag
point to commit ca35d53, so the tag name is shown.  The idea being
that a symbolic name is more meaningful to a reader than a hash value.
You just gave that commit a name, so the prompt script uses it.

> What happened instead? (Actual behavior)
> It showed the newly created tag name at the place of the HEAD Point:
> vaibh@VaibhavNaik MINGW64 /d/E Drive/MyCodes/Git-Testing ((1.1.2))
>
> What's different between what you expected and what actually happened?
> It should show the the detached HEAD commit id at the place of HEAD Poin=
t and not the newly created tag name
> I proved this wrong by doing a commit which didn't got committed to any =
branch or tag but it moved the HEAD:
>
> vaibh@VaibhavNaik MINGW64 /d/E Drive/MyCodes/Git-Testing ((newt))
> $ git commit --allow-empty -m "want to commit at any cost"
> [detached HEAD caad8ef] want to commit at any cost
>
> vaibh@VaibhavNaik MINGW64 /d/E Drive/MyCodes/Git-Testing ((caad8ef...))
> $ git status
> HEAD detached from ca35d53
> nothing to commit, working tree clean
>
> it showed the tag name in the brackets

git commit moves the HEAD, even if it is detached, true.  And you
created an untagged commit, so the prompt fell back to showing its
abbreviated hash.  I don't see how this proves that showing the tag name
for a tagged commit is somehow wrong.  What would be the benefit?

I can understand that prompts are a matter of personal preference,
though.  You can adjust what the prompt shows by setting the environment
variable GIT_PS1_DESCRIBE_STYLE.  See git-prompt.sh lines 91 ff. for a
description of the recognized values (or check your local version of the
script).  There's no option to ignore tags and always show the
abbreviated hash, though, yet.

To summarize: I don't think the behavior you saw indicates a bug, and
the prompt style you'd like to use doesn't seem to be implemented, yet.
It shouldn't be difficult to add, but I don't quite get why you'd want
to shun tags.

>
> Anything else you want to add:
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.43.0.windows.1
> cpu: x86_64
> built from commit: 4b968f3ea3b32a7bc50846bab49f3f381841d297
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 22631
> compiler info: gnuc: 13.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash=
.exe
>
>
> [Enabled Hooks]

