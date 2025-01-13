Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9792E1C5D6F
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786153; cv=none; b=qjBuD9TAA3RUEXallOVwcH2anv/FaR+MrtBUTvCcxan4CS0+dJ+NQA28Qja+GuM8YVdDjxAy7IITQtlmSxLPAOKswUgtzWZ7hLYxmlonXYglxVIFYzlBPuPKm4FHmfdSJN/KNGVk33RS9ZMWMIeah8aVvOI6e8p1GFhfqBNc/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786153; c=relaxed/simple;
	bh=gY/DBfE72DdAV6LJFEDHwHhZMTA0NXE6+00TCTmssg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F3sy0NncEWBZCRV2HCbns7hdPEMwY2E8P6xKgGoTGYhvfYVpYJ8VMND9LPSZBtmRnhNSiOKfgh2DQeCRThmGUPtMlh82z/tdHX3A9kWLIAvDKMkT0HtLg64FayjM8dOPKqzht04buFOVs4QAKe+sY+ebWcUs4RS+Gjm2y6sVoIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=fNliRsPw; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="fNliRsPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1736786147; x=1737390947; i=tboegi@web.de;
	bh=PyYR0HFVELb3NYJu/I7RO/K3S6ocFwCfM8pCuyVgpO0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fNliRsPwwv9oGmPIn5/kxHd52Nz03aPJeBwCc2gUszjDkFKZ1P8nv0VSFTI9xTWn
	 XAz9oEwKuTYEf2nZTxOZtdLADrP0tcHrO4VYuLzwH1ZAH2PSlCkKGyeZAaxME8x4S
	 Nbcb1f4xAEZt9Yj6Ed2WpdSnGtTE25dq/BpN/ctcs2HkFxL5TPqq5GmSHw/2udAz4
	 6NWtDxTh4wL0XVSeqs9DdPPaNQETdyybzgRdxMP6fEVe+M6WpCmY5k+wm6jvqz7AL
	 j8ihV3AXHfG1cJSAPADayFiPmGXgEb9zdgYAIjQ2cLp3zk9mUsSWreL5WpoUzYyd3
	 GHC3shx5tmjICuzBsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.209.87] ([81.231.143.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ma0Pm-1u13sV1VbA-00Uyoz; Mon, 13
 Jan 2025 17:35:47 +0100
Message-ID: <136f18cc-7b6a-4427-a4a7-96ef073ada49@web.de>
Date: Mon, 13 Jan 2025 17:35:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug report - Apple git
To: =?UTF-8?Q?Andr=C3=A9_de_Castro?= <aramosdecastro@gmail.com>,
 git@vger.kernel.org
References: <C2871318-4745-4481-9199-72D4544ECD5C@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
In-Reply-To: <C2871318-4745-4481-9199-72D4544ECD5C@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zGEN3X6FfmwZX3hED2lbwrzMxQQXJrCjT70by+F6v54VZu7MCwI
 cfPv9u/7R29zFPo6QPhhHJadX4HOPn+9LcbSr/KV8hLtK6/aQEw0O/vwFBCSwuEVd4dP7ES
 PVO0ZKAE6eCeuVHrc/PQmvXEHZX2JmOYZsPH/dElsTMyaqe96OYpvuah8yUmcHLwBIpvu9N
 yJKQD/toC9JStKaGlJ3Pw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kaOhUmZda7I=;TSGtF1UlzFDcBVf7+Cpicf0e8tP
 o5mI9V5tiihubgMYgDNyIORZTQs9RUSpO89+PQSxRtrvt314hQvkESRjorjtpElvE3/yZ62vY
 n2XOJbdGpMJLQ2iBDYdkQRW62eNcudvNAByzHUS1bVX+4cuW7S5FQdKLwg1k66+sTvfPw6apu
 giN7rA8m6sF9S1rjhlpGs9WZQ2Wqso+G+Yv+zpW5w9Bukkt2/ney07OUa8ojnbpgAu1pUx4ot
 ut7kEkXNIv7FW4HNFinqCByr5WdSNDBQlC28mpQ/dTJftY1pwIw6vOEXE92/qdICm62jH/GT2
 HYaJfygQMD6FtajDERXOACT77k4AptUCD+ruokhrullb/Di6leUIvd97kjwes8IbYmIZJ+48v
 2Ki+RtWqRBEdoDzkpWvQdP2ndDUJtKFkx0R3tCigw6pdAI4a26Nv2AZ3/PX/Vh9V0u6i910DV
 D4Q5mF6J1wzNASwESnnxN7n9/pgU0xWkfx6nZUsE6yqxQ33OdIFAAzGoQjR9asE2C6VQcn7Ym
 S0/HQAagGksjbgetPa2WyzLm4O7/ZTNZWM9pEns7+26IDbB9BdhWmaY4lbIWOJ0D7JAj4iNng
 eUJ2ZwMd0izyzggrvwdX8hkbHENmnQvhPxABbyiUDmnkl5yHo2G9BfATOMemf1M78LjlfDAQT
 /kYXTp9B6gQGtnzM0Pxv/aTl5989GgINc9ywvjFU33EzgZQkmwnxKa6x/5J5qa5B20pHxwyUq
 z7ixWNAbAgIauBQaJtKdv3xm9dt97yBaE5GrzVdtSVEDH1MBlP674m+1MbmcGWC7Mf1cstzFI
 wKvLkD75xuPqBEonZiJt0I6FdGJdUytv9ui1jkvSKQ1CvOYwR5W5FBaLNE69z23tPYliv/koN
 nLpDcHk0KhGY7q0DjzJUUR6XbJw+nxi7tVlLM1H/F3KraiKFuANTJNdC0tnJKEZdBN3uO8iDB
 9bJW/ud5rYfXbpkhpg9tmgi65zHfOcrpmdlNudhcgyTDbcnCCtCi7JKe48e8cL6MFaa5Ql+Jp
 Hanso3fRY3Vooh3CabaeGUuaQGBXt+2AH4EZcmr1FdLq5fw+T+q/1pKl0rk7qE+NQYCBjTxIs
 buORyUAIk=

(Please no top-posting here)

On 2025-01-13 15:23, Andr=C3=A9 de Castro wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> Checked out a branch, ran "git diff --merge-base <some-annotated-tag> HE=
AD".
>
> What did you expect to happen? (Expected behavior)
> To see a normal git diff output.
>
> What happened instead? (Actual behavior)
> Didn't get a diff output. Got the following error instead:
> "fatal: --merge-base only works with commits"
>
> What's different between what you expected and what actually happened?
> I didn't get the expected diff output and got an error message instead.
>
> Anything else you want to add:
> Seems it happens when I use a tag as one of the commits for git diff
> --merge-base. This is on a macOS, with apple git.
> On Windows, with Git Bash, it works as expected.
>
> I can get this to work with "git diff --merge-base $(git rev-list -n 1
> <some-annotated-tag>) HEAD".
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.39.5 (Apple Git-154)
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 24.2.0 Darwin Kernel Version 24.2.0: Fri Dec  6 18:56:34 P=
ST 2024; root:xnu-11215.61.5~2/RELEASE_ARM64_T6020 arm64
> compiler info: clang: 16.0.0 (clang-1600.0.26.6)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
> pre-push
>

Hm, I don't think that this group/mailing list takes responsibility
for binaries shipped by companies.

If you want, you can compile Git yourself to be "on par" with
what you find under other OS.
That is the good thing with open source - please let us know,
if help is needed.



