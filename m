Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D15188900
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379112; cv=none; b=kETgqv2f7QR4/grLOoMOr3wcaz5PYGYyQPqCj9+xsyjlaLoBqEngnC4lYoYex1CDYaZNfBuh3kojSflXOj99NudKiQd2SpugKFHCdYlWwHp/fcKZSRnS6Dcf1QuOdc6iBlcGJmekylt9R8fnNQ7ehdag1UsD3aO7JnNrJ4URtAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379112; c=relaxed/simple;
	bh=QBS+Eim6bWD07RuV738H/KBbQNstfeAmkzgn8XVQw5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCXeiz8ffpzrQwwm5iynT6JBytzj9JcQ2pgwIbrIuqCjJrupobGL617ylS/jWTPuSXnddAkJm0XC4XOOo9b2nJeE6YY6vZ+2gYahUIeteXhIMvvi3NAHk9ouIKZyB5y9kMaFup+PSf0/EjAzvWnd/FyE8Bg2Gxsjann07OR63hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=Cvq+m9jc; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="Cvq+m9jc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725379099; x=1725983899; i=tboegi@web.de;
	bh=yZn5xN+SPDl/5b1DfzO/Wdj4BHMpDJ/xyGcsovCbq2o=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Cvq+m9jcmTibokOLhcF8UWTqD0F/JhMoM9Sf6DxRAr1aDqUJXVqtluBkzuYUJkQS
	 0rbFgUJ2qd6g5ca4jKnBG8hHXzWGysCd4Ad/ITR9yJeEEdrPw+sxNoik2HxOabiVw
	 ZEldWeMl35CEWBqcW+4+nLWY7o//13QDpRUkf6yhgy4+efaCB6ge4vPq01IzOrqQn
	 xO8DH/ecVCgLA7byN4GzofXx10mztAp3hW4XO882APPLfgRoW8CbOGQM+zBYPtR9j
	 1cUSDBwxo+I2GUx7eyfVhZ7CGmojLTfJgRYPV8DrZXwYBF1tg+JZv6tgKHuWjmabG
	 vBpd8/q05q28ucMF6Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MV2Oi-1sb6Lt0nJ8-00MyCH; Tue, 03
 Sep 2024 17:58:19 +0200
Date: Tue, 3 Sep 2024 17:58:18 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Roman Sandu <r.sandu@gaijin.team>,
	git@vger.kernel.org
Subject: Re: Committing crimes with NTFS-3G
Message-ID: <20240903155818.GA9437@tb-raspi4>
References: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
 <b282c83c-2fa2-4e8e-b8bf-d42f28c17439@kdbg.org>
 <xmqq1q26t1pa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1q26t1pa.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:OWxpV9/w45T9av45SQc/U2dYfT7WSZqLH/yM92YHkDbH1u0YK9f
 IpnhX4IZcMnDhqYCPabqg8JuqS/mVUSXHLVcQXWu3sFqWXAgPNy3XQj+sA+4PFiq/dRnri/
 00z9nOBW1MOccpvTgL4upgzx3hC13giqWCjoSkfNisyjtB+9AHjK4FhV+2CYD74AkxK5TJZ
 ueuaPo/Kv7EWWcSwqaaeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AiCc61a31as=;7/c2/bovwmbQ9JivvT74ROSXiTQ
 P1mbhy4Hvwi+KjyfqrPQiWYQGbAyEco3BGB6mza+t8l6DCs6nmZbweEmxZ1s8VPTDwUdA86NR
 l/dMQWKOn9Sm5/ti7w6TW5p6UBYpWm0ubZUYSdXQ4DY6gJbZrBMcSWXxAC4Xpea38uFZC48y2
 iXWjSKnmiLHVrbxO+1D6yZ9uwP26VXzftF7uiUyV16P7sd8L5uoD9kQJKM5YZcTon/wEtVscy
 uF75ZfhiAwStYrbcwJhaXSy35I583e7YzIrewuS1mM9WNmdhsUNmsk7xHjhRv7jtXBfhnba17
 f36FbNlC8zMeopupePrzWFeVpt80mH2UsZdFqmD/mxOxsLZKUKik/E6BNRmaZLhx5L+sWi+jV
 P7ICWu6AqHEB1T0BevWavnvNybO3uUMNdXQqM0JgG9bPY1sgIPIod3I89Q621QGZ3r0gdbyKX
 s9ZfuClfL4Fls/E5OGptw/xWWwuFa3jtPCmJ1l/jLFpZd/ZvYDrqxc4kH0aWGOKsMwwaqn81g
 rSS6tuHIyNoxSxkQrz9zPubKmZaNl+A8P3wrxCu8T/YkhJbVjdXaj655bi/ocaaVuASLlJ5KC
 8d8ZIOw3CLmlkrfdZs2nFaAgR7hEkRW2a5FhJqD/KssAZJKG3KJvfcffAm4xeXAyWV3iJkvQ1
 CVbsqLf8U5VYvGFZpXbkQnCBFDSsexQlSiMFZvBrVQlkTwhVu7WctXY0/BqmV1ULEeAWC1n2D
 fwRrqONidOj6zju2vxMPuDd/6teBCud4T1nCnRo7/WafFhAxNAUXUgLQkixk8FcYdLIvRujm7
 ZsrL8yX/o1XRBIv+3+u36E1w==
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 09:28:17AM -0700, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
> > Am 29.08.24 um 22:43 schrieb Roman Sandu:
> >> To diagnose the problem, I ran git status with GIT_TRACE_PERFORMANCE
> >> enabled, and what I see is that the "refresh index" region is taking =
up
> >> 99% of the time.
> >
> > Of course. The stat information that Git on Linux caches in the index =
is
> > vastly different from that that Git for Windows caches. So every time
> > you switch OS, all files appear modified to Git.
> >
> > I suggest that you don't switch OS on a whim and take the 8 seconds
> > delay once when you have to.
>
> I somehow got an impression that the hit is not just that we need to
> adjust cached lstat information in the index file once to the new
> filesystem implementation after an OS switch, but every time (as if
> we are forced to be extra careful and rehash every time until the
> things improve, somewhat like how we handle the racy-Git situation).
> Timestamps given by these OSes are not consistent and the clock
> appears to have rewound, or something?
>
> Timestamps of files in the working tree ordinarily should match
> timestamps in the cached lstat information of these paths in the
> index, and timestamp of the index file itself should be newer than
> any of the above, or the recy-Git prevention code may tell us to
> play safe.
>
> I do not do Windows and/or NTFS, but I have to wonder if the smudge
> filters (including the EOL conversion) play a role in this situation
> as the working tree is getting switched between LF-native and
> CRLF-native systems.  May there be situations where the system must
> spend time only to realize that there is nothing it needs to do to
> canonicalize the file contents and there is no modifications between
> the HEAD commit, the index, and the working tree files, or something
> silly like that?

Now, that make me wonder:
What are the settings for core.autocrlf ?
Is there a .gitattributes file ?
According to my experience there should be one, when working cross-platfor=
m.
A version with the single line
* text=3Dauto
works for many projects, and may be fine-tuned to what you need.

The questin about core.filemode has been raised elsewhere, it should
be false for this repo (but probably is).

Now back to the lstat() question:
There is a
git ls-files --debug

which may give more insight about what is going on.

And back to the line-endings:
does
git ls-files --eol
give any hints, may be ?











