Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9915E90
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522334; cv=none; b=M8TB9k3UxgJfMEWw4acX+sFOcxnE7GDg/CWpdDhGbWT/qgJfWIxJA6hyh7oftIDqZ5HCTUbey9ymHl1+k0YeM0hnnZPTnbJkH+vK7rckYPy53aRZwGdOdknCZop/Ed0ata05rKLs9UtZI2ktDGnpPgdpUaQEwPBuIX05CKE5W3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522334; c=relaxed/simple;
	bh=o6ZYlhNxbGw3efhgtFtiS9pakp44tf8/8d9a5r9KFX0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IviNuLDAAOy6QRyRcNt/C2G709M8SYwu3qE4t5JAoKrK0eAAVaFeU0hcv/RwKF6o63x9i3urpYuNl989KJ4cI02U+B8msxBz/2p5VM9ptiE0q67SDqFkxObfkphZhaEFLJxZVNcW4SPqgXJDe35LNWQYJahIMwmxB8q76BAbtYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=uBEwnFQ0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="uBEwnFQ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743522330; x=1744127130;
	i=johannes.schindelin@gmx.de;
	bh=eAWIXiftJfPBLF4QT9LBZWXmirykKfkszu7uuAYCjEI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uBEwnFQ0KRhlGE8eNApGDfd9Fb4hJaxYJRuSOxXs1czMZVcf/vFVcFJb/MWHeuPX
	 f//YSuLQASJMaBX3FjR0nBPKuTdnlO5bX3vMi0ML1caN0siXZDLHGndO2lEKwD7pu
	 r3+k1mUnW1Jb/RFnUpKqFEnZVFxcyBMZjvTgM9pGqNFI5ilNZnKym6onVoYl4E3N7
	 xr2VpgLTeK3FlZWFtOjor/Wab93an64T7UUhdddZXBTRqoXpFGD4Hwf//TcusZb97
	 IC02vvIDqeqPDw+FPROMps1CrkAwIBkxNgai7Gfo2r0AaR4UwpL1Efo/QyK/8zdeW
	 R7ghT4Rp7JQIeDtF1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1tHGiC0Lkk-00cxzx; Tue, 01
 Apr 2025 17:45:30 +0200
Date: Tue, 1 Apr 2025 17:45:29 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?Hohwiller=2C_J=C3=B6rg?= <joerg.hohwiller@capgemini.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Windows] Severe problems after upgrading to 2.48.1.windows.1
In-Reply-To: <VI1PR02MB64955FD0B8A0B8C4438F605FFBC92@VI1PR02MB6495.eurprd02.prod.outlook.com>
Message-ID: <d3f55106-8f87-b535-1c7c-29d382378342@gmx.de>
References: <VI1PR02MB64955FD0B8A0B8C4438F605FFBC92@VI1PR02MB6495.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-13064751-1743522330=:31313"
X-Provags-ID: V03:K1:sU4tQY+vx/KzSAfDX+80owNXGTTk+as8t3MjGvZv1LJ3XKzer0N
 qqqAMlsfwO6T+PaU+1UrQkxlTl5ObDGdbM+R4vDsZvhzfPgSW2BxlFXodW0j+TTdP5LMjwm
 5BIlSVDxokK4PLGdjyvyCAhsoOuoUBUOmeJ4eca7CIipAmEOoM6KJGXsEkVTnM3h9eWG4xN
 AQ8gypwPiHAjWTNVaaymQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+DO1wxR8KHw=;UDvLguamkH28wqhR91VDqOj+LYB
 odi6iYIfCrrg+4EtiG0rc8JOEDvt2I9PwDpsvzv0OqwubYbmAQi3XQxMVb1pMO1PLUZoyUSuc
 6712r//JyFF6mnzfYyNjWrR/89GLpO9kLEw6fxTTpqBmGiaH6D1CwBxhUx+ruBNzKeFFBe2jc
 l7rO9nyQm7/yMAv54q/w1j9Pp9ESco+SywWpmln7nzm5LtH2QfTBL7GY3ROgzP5w+L9Ta8/eU
 UsGcB3IIpLaNY+bOL/aQ+rOTrNn/dkAJZxBBb+52xaPfRC7XTkfdVe1zK72n0F2XYPU5/LefU
 N6j+fwjTnp0BORS8kYmCpWNTujIyR05ofFSjjy6KkOO55ZyNh8XDF7R5KPCsTKCU4izQGJ6Rj
 k/K1AAUEpATFQ2q+MJYE718GtXFHiVcBuUAGSWdSWXUJEzxnSGZCnYBu7vLyziLAm2lucYvZ6
 H4Xlv86b71aYvkj02fswvekSIpnnZVKkc7YnI3lBd3ztsJfUJqheaCS2w3hodr/BYuYNdszyo
 5ATjn3kAZAIhBjNWsvAZcHOkQOASiuphRMNdK0ECHK8HxU453qrPztMXD1Dx3dB+B/Op8MamF
 HCK6AiXHBJXWWizKpG9UTHUCBYVJ44Mo0jVTHDC5bILx6vmmCQSI4EA8erIJwqR88mrlc/Cx5
 mQZ64h7Ftv7K0y5ce9Oy31/qNW6HLI2EKvapfRv/e52OJ5KBSQACDXZP+2ImpeMAmSvHUG4Co
 mayuENCubskWSeolbw9SVDU8jVXsDx0EJrWYtaNjbrVgHkT+h8ketTtEySorodbFDUuzGtFmb
 1J00yA2AwF+Cj6ALw8H7in1+fa2Hu1WYYKukVwlQYbxIfiKvYIQRGSqvRxLo71oCw3KSU0WBz
 4pAjFwwwnfzhITN6jbwIGAIMb2D1E8+FcxeAYURM0NO39di6CFa/I5Epq17Ji7wXVDIHAR3Dw
 zZiu2E4jqtPp4VJJaMeTLPiMKvWE6MI5jRE9HHOYl2DOkT8RKPaoWj59YgDt5+MHTQYGzoetA
 bo8ZU2ALUip5JvNeEhaqUyboz2I+p0dRdfYooSAG8ZCEGdwbS96S+dG624eria0n9Pd2kUDZN
 3Cbl7NcF7kwcLDZMJHPtBgcBbr/Mg+TlfvVX+/sSiuf2CioGft5C9WwHPr6RvbAaYWNB1MvJn
 BLdDr885qDueIIop0EDygHZYXreAHIUIp/bYp2pVJJlaxzbHHtxpXkIW6xbhL18mkpC+Xj0dI
 AAuxRYoJNB2mcvmfd5/ZeUWer5RX8rj1DSljTSzsPM0Mt3kKzPO0xWPbPq6DWeNDhyGaWgAHM
 l0+aYzyErjXyUtek2O+iYQ3yfkUPtPxjfhAhKqgMQoLIAUZNxdMwK9q7Jh8XWEsbz16qI1SuP
 LLC06pwrZIRn2dOrAP2FBGI/ETaPRcp//xW0tzTlGSqdoq5VQ/w4JAg766B3r4Tloy1G2ErC8
 WdvxRS/pcFyJsWWWUknJhO1AokmpSNyhvTUL0WtyaPfYP8LPFWUpxhFthhd3lh1pF7LabOQ2V
 mkYTrcg1N+ISFiU3/175zWOcDBcSfLjN4CVV6mYO

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-13064751-1743522330=:31313
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi J=C3=B6rg,

On Mon, 3 Mar 2025, Hohwiller, J=C3=B6rg wrote:

> I just upgraded to 2.48.1.windows.1 (reinstall via Git-2.48.1-64-bit.exe=
).
> Also I kept the checkbox to cache files (new feature?) =E2=80=93 maybe a=
 mistake, let see.

If you are referring to FSCache, no that's not a new feature.

> After the upgrade, I pulled some repo with git-fork and got this error:
> error: could not delete references: cannot lock ref 'refs/remotes/origin=
/bugfix/XY-74488': Unable to create 'D:/projects/projectname/workspaces/ma=
in/projectname/.git/refs/remotes/origin/bugfix/XY-74488.lock': File exists=
.

While this looks different than
https://github.com/git-for-windows/git/pull/5515 (where writing to a ReFS
drive on Windows 2022 was broken by a regression), the root cause as well
as its fix could be the same. Can you test the latest snapshot at
https://gitforwindows.org/git-snapshots/ to confirm or refute this
hypothesis?

Ciao,
Johannes

>
> I looked locally (even in CMD with copy & paste of the exact file refere=
nce) but the lock file is NOT there.
> I repeat the pull and get the same error, but no such lock file exists.
>
> To avoid external side-effects from git-fork, I opened a new git-bash an=
d called =E2=80=9Cgit pull=E2=80=9D manually in the terminal.
> This did not give me any error but gave me this:
> $ git pull
> From ssh://git.company.com/repos/projectname
>    72477d57f026..de79f4dbbf68  =E2=80=A6
> * [new branch] =E2=80=A6
> * [new branch] =E2=80=A6
> * [new branch] =E2=80=A6
> * [new branch] =E2=80=A6
> * [new branch] =E2=80=A6
> * [new branch] =E2=80=A6
> * [new branch] =E2=80=A6
>    ce3979d639d7..b80b70a56da7 =E2=80=A6
> $ echo $?
> 1
>
> So what could be the error leading to exit code 1?
>
> Almost the same happens for git-fetch.
>
> I downgraded to git version 2.47.1.windows.2 and after that tried the sa=
me again.
> A difference is that now I additionally I get logs like this at the top
> $ git pull
> remote: Enumerating objects: 269, done.
> remote: Counting objects: 100% (143/143), done.
> remote: Compressing objects: 100% (41/41), done.
> remote: Total 269 (delta 89), reused 87 (delta 87), pack-reused 126
> Receiving objects: 100% (269/269), 59.37 KiB | 2.58 MiB/s, done.
> Resolving deltas: 100% (94/94), completed with 51 local objects.
> From ssh://git.company.com/repos/projectname
> =E2=80=A6
> $ echo $?
> 1
>
> Looks familiar. Is it a bug or a feature that the latest git stops loggi=
ng these status information?
>
> I have various other git repos that continue to work fine so I now rathe=
r think that this is not a general bug in git pull/fetch but related to th=
e specific repo.
> However, that used to work for years before I upgraded today.
>
> Status on that repo says:
> $ git status
> On branch main
> Your branch is behind 'origin/main' by 387 commits, and can be fast-forw=
arded.
>   (use "git pull" to update your local branch)
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>         find-tests.sh
>
> nothing added to commit but untracked files present (use "git add" to tr=
ack)
>
> Sorry to bother but do you have any further hints or ideas, what I could=
 try to fix my problem?
>
> Kind regards
>   J=C3=B6rg
>
>
> ________________________________
>
> Firma: Capgemini Deutschland GmbH
> Aufsichtsratsvorsitzender: Dr. Volkmar Varnhagen
> Gesch=C3=A4ftsf=C3=BChrer: Henrik Ljungstr=C3=B6m (Sprecher) =E2=80=A2 J=
ost F=C3=B6rster =E2=80=A2 Felizitas Graeber =E2=80=A2 Vera Schierholt
>
> Sitz: Berlin, Amtsgericht Berlin-Charlottenburg, HRB 98814
> This message contains information that may be privileged or confidential=
 and is the property of the Capgemini Group. It is intended only for the p=
erson to whom it is addressed. If you are not the intended recipient, you =
are not authorized to read, print, retain, copy, disseminate, distribute, =
or use this message or any part thereof. If you receive this message in er=
ror, please notify the sender immediately and delete all copies of this me=
ssage.
>

--8323328-13064751-1743522330=:31313--
