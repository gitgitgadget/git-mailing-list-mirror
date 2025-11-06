Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7E8239562
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443472; cv=none; b=J1MYciGvAVNCGVbyJno9uillk7EoPvKj1vAYk8jOaYkogBUANHcPfk0ffngeclHgcmjvaROEiy3nzw6uQtSFJsjxt4GvdIepbZaOd7+Ddxp4ou3z3vuI7CkvGo+ZPtSqI/yT3eAbNKRRSYThAXgPcWaz+X9OelWF3qsa2ife158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443472; c=relaxed/simple;
	bh=wOjp9kD+tcwOLkRsDAJWIGjTUpZ7AqjjTAJB6jINYLk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O2m1qE5zmQDZ+WYZVUSg9APAE+6Y5SATdEGwegTEi0J5YcduL4VlBMqzWJpWyK63tbcQR9A8pE6lY89uJV6j2TmhRQLFFghvfFjzbvqXPenf+c3x4vJmRoH6/2weYS5WtoTCgoh1TqERu5exQfMtVQ3pIwZOiLxvDNooJnFTF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=gKA8W1m/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="gKA8W1m/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762443466; x=1763048266;
	i=johannes.schindelin@gmx.de;
	bh=p/uK8/CNVWsCvgDKSrqnovMDabuTRcZYd9nr4qzHZW4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gKA8W1m/E9J12j+c8vKPf3/0AcC4PbxrAdIdIF7bCehtdR9KX8QPthKGu/8Q2F4e
	 SqUeWl9hhtamAT0yhQmQXygD6j85HfTZ+Y+BGwj7HdAOcGUTcNN31Fka15TLJHd+G
	 TYXw58pBTFf8XL3zvJohaIuVJPEuq1V6PRqarLX6kippLy1Vz8qW8q6NuM9viHg3Q
	 1deQkASOzTn5tCAqWhYu0U6uIUneotlTMfBDGtG8zVfDhIhRHD1jiGQLiHQj2l2Qh
	 26PtJ1hQ+3F7o2kScElv35FAuQiuwXZzFMKbUm1Rgx+iv1Acup2wcDiqLWEmpUyDd
	 +3Yklmjnw2jvgkOZsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXyJ-1vjM1N2RCx-00OT6M; Thu, 06
 Nov 2025 16:37:46 +0100
Date: Thu, 6 Nov 2025 16:37:45 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
cc: git@vger.kernel.org
Subject: Re: [PATCH] wincred: align Makefile with other Makefiles in
 contrib
In-Reply-To: <3869ec21-e20d-cf9b-5913-6389c372a5f0@mailbox.tu-dresden.de>
Message-ID: <927c2094-3654-edec-072e-1f6ca7d91f96@gmx.de>
References: <3869ec21-e20d-cf9b-5913-6389c372a5f0@mailbox.tu-dresden.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-90970998-1762443466=:12977"
X-Provags-ID: V03:K1:SvY590y6l+hBOHBfcSTOP/RwqvzcEZHT9IqMt4AKSI6aWZI3qXJ
 xpMOd5t7GaW6moitMioQVGD7r1fIzYe+HR7f46iWPN9+/Fk9eWEdqrdT9aE4QzFVV2M5NYO
 Zsju9lXYRrRZluxzSjr2u0ZflZt++DzzAB2pawFRLzoVeBWUtxTNvSuXdMuPd0HrEqw8j3W
 OKiGIZF9AEWNBpMBNdilw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hzY5Kp55YqY=;GRPiR75LDNKIzb8UmnJLZaY8L28
 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
 Rp27kA2Ed8VAKNQfJTQ9BSohBAiWU

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-90970998-1762443466=:12977
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hallo Thomas, wie geht's? Gr=C3=BC=C3=9Fe an den Biergarten am Blauen Wund=
er!

On Wed, 5 Nov 2025, Thomas Uhle wrote:

> * Replace $(LOADLIBES) because it is deprecated since long and it is
>   used nowhere else in the git project.
> * Use $(gitexecdir) instead of $(libexecdir) because config.mak defines
>   $(libexecdir) as $(prefix)/libexec, not as $(prefix)/libexec/git-core.
> * Similar to other Makefiles, let install target rule create
>   $(gitexecdir) to make sure the directory exists before copying the
>   executable and also let it respect $(DESTDIR).
> * Shuffle the lines for the default settings to align them with the
>   other Makefiles in contrib/credential.
> * Define .PHONY for all special targets (all, install, clean).

These changes all make sense to me. Feel free to add

	Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you,
Johannes

>=20
> Signed-off-by: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
> ---
>  contrib/credential/wincred/Makefile | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wi=
ncred/Makefile
> index 5b795fc..d92e721 100644
> --- a/contrib/credential/wincred/Makefile
> +++ b/contrib/credential/wincred/Makefile
> @@ -4,20 +4,22 @@
>  -include ../../../config.mak.autogen
>  -include ../../../config.mak
>=20
> -CC ?=3D gcc
> -RM ?=3D rm -f
> -CFLAGS ?=3D -O2 -Wall
> -
>  prefix ?=3D /usr/local
> -libexecdir ?=3D $(prefix)/libexec/git-core
> +gitexecdir ?=3D $(prefix)/libexec/git-core
>=20
> +CC ?=3D gcc
> +CFLAGS ?=3D -O2 -Wall
>  INSTALL ?=3D install
> +RM ?=3D rm -f
>=20
> -git-credential-wincred.exe : git-credential-wincred.c
> -	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
> +git-credential-wincred.exe: git-credential-wincred.c
> +	$(LINK.c) -o $@ $^ $(LDFLAGS) $(LDLIBS)
>=20
>  install: git-credential-wincred.exe
> -	$(INSTALL) -m 755 $^ $(libexecdir)
> +	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
> +	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
>=20
>  clean:
>  	$(RM) git-credential-wincred.exe
> +
> +.PHONY: all install clean
>=20
> base-commit: 4cf919bd7b946477798af5414a371b23fd68bf93
> --=20
> 2.47.3
>=20
>=20

--8323328-90970998-1762443466=:12977--
