Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92762839FD
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418576; cv=none; b=J5TMdOHCtNIfnh+/19VwdrKFHEy+3Hmxs52viO0n/Sbp+PBbAlcfzxriVTm4fcpzdCZifyzrQtk+ZUfuHWnebtAXQZOO9U9jVWhMjKxCO2M2hf+kC9+SOFENBN6DCqEqSYKEo759iLbDN/1nvIQu+e7u+rM9Jg+U4FsRpkHtezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418576; c=relaxed/simple;
	bh=exNDGrOudqvyErC5MfxOPnE0vkVOmyMHyc2mTOmDSOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YgKGoVyjm02nF8Fyu9i/7bHUMfaBGtR3lw8Fo/RlIlLty2rBQx3hspBrE2QJUoiQ66u5JjcBNqLKodqNbDLODcoVGfjqmUrzJCEBDqTTsAA1LzmzyHu5h1nmGUudLH5rLAfhQZDz1nemzTnz5LQYxQQ9n4GIoMyT/iUWejeicU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V9YkT0MF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V9YkT0MF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C3F4318615;
	Mon, 29 Apr 2024 15:22:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=exNDGrOudqvy
	ErC5MfxOPnE0vkVOmyMHyc2mTOmDSOo=; b=V9YkT0MFjGm/2dOIwzzXF9asfhxx
	kYaYZCCEHAc/i4+F6ddqbjt0ozL0OfDPeaRsMRVdFsQ8pTY/eUlWadK9deeVGtpH
	6QajmJASQ1S24sFx0lGUIdGWIOS5TcmC8TPyjE5UgjpIGHwLsyf0DzsPaXpLMo7+
	Qga+v25yqIXvFnU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BBECB18614;
	Mon, 29 Apr 2024 15:22:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24E8518613;
	Mon, 29 Apr 2024 15:22:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Passaro
 <john.a.passaro@gmail.com>
Subject: Re: [PATCH v3 3/3] po: update git-tag translations
In-Reply-To: <d5335e30b0bf8f126f5bd3ac71d8a0afb3fa86f6.1714416865.git.gitgitgadget@gmail.com>
	(John Passaro via GitGitGadget's message of "Mon, 29 Apr 2024 18:54:23
	+0000")
References: <pull.1723.v2.git.1714409638089.gitgitgadget@gmail.com>
	<pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
	<d5335e30b0bf8f126f5bd3ac71d8a0afb3fa86f6.1714416865.git.gitgitgadget@gmail.com>
Date: Mon, 29 Apr 2024 12:22:46 -0700
Message-ID: <xmqqjzkgug6x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 DD9EC6A4-065D-11EF-B701-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

"John Passaro via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In both cases, reuse translations found elsewhere in the file.

When each l10n team sees an updated code and translations together,
will they have a chance to easily (1) notice that there are
translations for their language that came from outside the normal
process (namely, this patch), and (2) double-check such a
translated text that came from sidelines are reasonable?

I am wondering if we should be doing some trick that involve use of
comments like "# fuzzy" in the file here.  While I applaud your good
intention to help reduce the workload for translators, unless you
belong to all of the l10n teams for these languages (note: I did not
say "unless you are fluent in these languages" here---I am playing
safe by assuming that l10n teams would want to have a chance to
verify even a translation that comes from a native that comes
outside the usual workflow of the l10n groups), I would really want
to avoid a change like this go unnoticed by l10n teams (iow, as long
as we are sure they will notice and have chance to verify, I am
fine with a change like this).

Thanks.

> Signed-off-by: John Passaro <john.a.passaro@gmail.com>
> ---
>  po/bg.po    |  2 ++
>  po/ca.po    |  4 +++-
>  po/de.po    |  2 ++
>  po/el.po    |  9 ++++++---
>  po/es.po    | 14 ++++++++------
>  po/fr.po    |  2 ++
>  po/id.po    |  2 ++
>  po/it.po    |  6 ++++--
>  po/ko.po    | 10 ++++++----
>  po/pl.po    |  6 ++++--
>  po/ru.po    |  1 +
>  po/sv.po    |  2 ++
>  po/tr.po    |  2 ++
>  po/uk.po    |  2 ++
>  po/vi.po    |  2 ++
>  po/zh_CN.po |  2 ++
>  po/zh_TW.po |  2 ++
>  17 files changed, 52 insertions(+), 18 deletions(-)
>
> diff --git a/po/bg.po b/po/bg.po
> index a7cbc617a53..d2fe6c87186 100644
> --- a/po/bg.po
> +++ b/po/bg.po
> @@ -13555,9 +13555,11 @@ msgstr "=D0=BF=D1=80=D0=B8=D1=87=D0=B8=D0=BD=D0=
=B0 =D0=B7=D0=B0 =D0=BE=D0=B1=D0=BD=D0=BE=D0=B2=D1=8F=D0=B2=D0=B0=D0=BD=D0=
=B5=D1=82=D0=BE"
> =20
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  "        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a|-s|-u =D0=98=D0=94=D0=95=D0=9D=D0=A2=D0=98=D0=A4=D0=98=D0=
=9A=D0=90=D0=A2=D0=9E=D0=A0_=D0=9D=D0=90_=D0=9A=D0=9B=D0=AE=D0=A7] [-f] [=
-m =D0=A1=D0=AA=D0=9E=D0=91=D0=A9=D0=95=D0=9D=D0=98=D0=95|-F =D0=A4=D0=90=
=D0=99=D0=9B] [-e]\n"
> +"        [(--trailer =D0=9B=D0=95=D0=9A=D0=A1=D0=95=D0=9C=D0=90[(=3D|:=
)=D0=A1=D0=A2=D0=9E=D0=99=D0=9D=D0=9E=D0=A1=D0=A2])=E2=80=A6]\n"
>  "        =D0=95=D0=A2=D0=98=D0=9A=D0=95=D0=A2 [=D0=9F=D0=9E=D0=94=D0=90=
=D0=92=D0=90=D0=9D=D0=95|=D0=9E=D0=91=D0=95=D0=9A=D0=A2]"
> =20
>  msgid "git tag -d <tagname>..."
> diff --git a/po/ca.po b/po/ca.po
> index bcb4da80fb9..8c8f52985b7 100644
> --- a/po/ca.po
> +++ b/po/ca.po
> @@ -13114,10 +13114,12 @@ msgstr "ra=C3=B3 de l'actualitzaci=C3=B3"
> =20
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  "        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <fitxer>] [-e]\n"
> -"        <tagname> [<comissi=C3=B3> | <objecte>]"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
> +"        <nom-d'etiqueta> [<comissi=C3=B3> | <objecte>]"
> =20
>  msgid "git tag -d <tagname>..."
>  msgstr "git tag -d <nom-d'etiqueta>..."
> diff --git a/po/de.po b/po/de.po
> index 29465665976..5380f294920 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -13297,9 +13297,11 @@ msgstr "Grund f=C3=BCr die Aktualisierung"
> =20
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  "        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a | -s | -u <Key-ID>] [-f] [-m <Beschreibung> | -F <Datei>]=
 [-e]\n"
> +"        [(--trailer <Token>[(=3D|:)<Wert>])...]\n"
>  "        <Tagname> [<Commit> | <Objekt>]"
> =20
>  msgid "git tag -d <tagname>..."
> diff --git a/po/el.po b/po/el.po
> index 703f46d0c7c..210304b75da 100644
> --- a/po/el.po
> +++ b/po/el.po
> @@ -18093,11 +18093,14 @@ msgstr ""
> =20
>  #: builtin/tag.c:25
>  msgid ""
> -"git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname>=
 "
> -"[<head>]"
> +"git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
> +"        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a | -s | -u <=CE=B1=CE=BD=CE=B1=CE=B3=CE=BD=CF=89=CF=81=CE=B9=
=CF=83=CF=84=CE=B9=CE=BA=CF=8C =CE=BA=CE=BB=CE=B5=CE=B9=CE=B4=CE=AF>] [-f=
] [-m <=CE=BC=CE=AE=CE=BD=CF=85=CE=BC=CE=B1> | -F "
> -"<=CE=B1=CF=81=CF=87=CE=B5=CE=AF=CE=BF>] <=CF=8C=CE=BD=CE=BF=CE=BC=CE=B1=
 =CE=B5=CF=84=CE=B9=CE=BA=CE=AD=CF=84=CE=B1=CF=82> [<head>]"
> +"<=CE=B1=CF=81=CF=87=CE=B5=CE=AF=CE=BF>]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
> +"        <=CF=8C=CE=BD=CE=BF=CE=BC=CE=B1 =CE=B5=CF=84=CE=B9=CE=BA=CE=AD=
=CF=84=CE=B1=CF=82> [<=CF=85=CF=80=CE=BF=CE=B2=CE=BF=CE=BB=CE=AE> | <=CE=B1=
=CE=BD=CF=84=CE=B9=CE=BA=CE=B5=CE=AF=CE=BC=CE=B5=CE=BD=CE=BF>]"
> =20
>  #: builtin/tag.c:26
>  msgid "git tag -d <tagname>..."
> diff --git a/po/es.po b/po/es.po
> index 1ff5ff3911d..b7b15ad6e4b 100644
> --- a/po/es.po
> +++ b/po/es.po
> @@ -12682,10 +12682,12 @@ msgstr "raz=C3=B3n de la actualizaci=C3=B3n"
> =20
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
> -"        <tagname> [<head>]"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
> +"        <tagname> [<commit> | <object>]"
>  msgstr ""
> -"git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
> -"        <tagname> [<head>]"
> +"git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <archivo>]\n"
> +"        [(--trailer <token>[(=3D|:)<valor>])...]\n"
> +"        <nombre-de-tag> [<commit> | <objeto>]"
> =20
>  msgid "git tag -d <tagname>..."
>  msgstr "git tag -d <nombre-de-tag>..."
> @@ -12697,8 +12699,8 @@ msgid ""
>  "[<pattern>...]"
>  msgstr ""
>  "git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>]=
 [--"
> -"points-at <object>]\n"
> -"        [--format=3D<format>] [--merged <commit>] [--no-merged <commi=
t>] "
> +"points-at <objeto>]\n"
> +"        [--format=3D<formato>] [--merged <commit>] [--no-merged <comm=
it>] "
>  "[<pattern>...]"
> =20
>  msgid "git tag -v [--format=3D<format>] <tagname>..."
> @@ -18461,7 +18463,7 @@ msgstr "%%(body) no toma ning=C3=BAn argumento"
> =20
>  #, c-format
>  msgid "expected %%(trailers:key=3D<value>)"
> -msgstr "se esperaba %%(trailers:key=3D<value>)"
> +msgstr "se esperaba %%(trailers:key=3D<valor>)"
> =20
>  #, c-format
>  msgid "unknown %%(trailers) argument: %s"
> diff --git a/po/fr.po b/po/fr.po
> index 837a695485a..2f7a345c74a 100644
> --- a/po/fr.po
> +++ b/po/fr.po
> @@ -13266,9 +13266,11 @@ msgstr "raison de la mise =C3=A0 jour"
> =20
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  "        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a | -s | -u <id-cl=C3=A9>] [-f] [-m <msg> | -F <fichier>] [=
-e]\n"
> +"        [(--trailer <symbole>[(=3D|:)<valeur>])...]\n"
>  "        <nom-d-=C3=A9tiquette> [<commit> | <objet>]"
> =20
>  msgid "git tag -d <tagname>..."
> diff --git a/po/id.po b/po/id.po
> index 2dc4b79e8a5..85b5631b3c7 100644
> --- a/po/id.po
> +++ b/po/id.po
> @@ -16230,9 +16230,11 @@ msgstr "alasan pembaruan"
>  #: builtin/tag.c
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  "        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a | -s | -u <id kunci>] [-f] [-m <pesan> | -F <berkas>] [-e=
]\n"
> +"        [(--trailer <token>[(=3D|:)<nilai>])...]\n"
>  "        <nama tag> [<komit> | <objek>]"
> =20
>  #: builtin/tag.c
> diff --git a/po/it.po b/po/it.po
> index c31560834d8..c4ceb8b2444 100644
> --- a/po/it.po
> +++ b/po/it.po
> @@ -22486,10 +22486,12 @@ msgstr "motivo dell'aggiornamento"
>  #: builtin/tag.c:25
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
> -"\t\t<tagname> [<head>]"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
> +"        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a | -s | -u <ID chiave>] [-f] [-m <messaggio> | -F <file>]\=
n"
> -"\t\t<nome tag> [<head>]"
> +"        [(--trailer <token>[(=3D|:)<valore>])...]\n"
> +"        <nome tag> [<commit> | <oggetto>]"
> =20
>  #: builtin/tag.c:27
>  msgid "git tag -d <tagname>..."
> diff --git a/po/ko.po b/po/ko.po
> index 5d190e52380..7484304eddb 100644
> --- a/po/ko.po
> +++ b/po/ko.po
> @@ -14397,11 +14397,13 @@ msgstr "=EC=97=85=EB=8D=B0=EC=9D=B4=ED=8A=B8=EC=
=9D=98 =EC=9D=B4=EC=9C=A0"
> =20
>  #: builtin/tag.c:24
>  msgid ""
> -"git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname>=
 "
> -"[<head>]"
> +"git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
> +"        <tagname> [<commit> | <object>]"
>  msgstr ""
> -"git tag [-a | -s | -u <=ED=82=A4-ID>] [-f] [-m <=EB=A9=94=EC=8B=9C=EC=
=A7=80> | -F <=ED=8C=8C=EC=9D=BC>] <=ED=83=9C=EA=B7=B8=EC=9D=B4=EB=A6=84>=
\n"
> -"\t\t[<=ED=97=A4=EB=93=9C>]"
> +"git tag [-a | -s | -u <=ED=82=A4-ID>] [-f] [-m <=EB=A9=94=EC=8B=9C=EC=
=A7=80> | -F <=ED=8C=8C=EC=9D=BC>]\n"
> +"        [(--trailer <=ED=86=A0=ED=81=B0>[(=3D|:)<=EA=B0=92>])...]\n"
> +"        <=ED=83=9C=EA=B7=B8=EC=9D=B4=EB=A6=84> [<=EC=BB=A4=EB=B0=8B> =
| <=EC=98=A4=EB=B8=8C=EC=A0=9D=ED=8A=B8>]"
> =20
>  #: builtin/tag.c:25
>  msgid "git tag -d <tagname>..."
> diff --git a/po/pl.po b/po/pl.po
> index 0ec127e14cc..287354b17b4 100644
> --- a/po/pl.po
> +++ b/po/pl.po
> @@ -23549,10 +23549,12 @@ msgstr "pow=C3=B3d aktualizacji"
>  #: builtin/tag.c:25
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
> -"        <tagname> [<head>]"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
> +"        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a | -s | -u <id-klucza>] [-f] [-m <komunikat> | -F <plik>]\=
n"
> -"        <tag> [<czo=C5=82o>]"
> +"        [(--trailer <klucz>[(=3D|:)<warto=C5=9B=C4=87>])...]\n"
> +"        <nazwa-tagu> [<zapis> | <obiekt>]"
> =20
>  #: builtin/tag.c:27
>  msgid "git tag -d <tagname>..."
> diff --git a/po/ru.po b/po/ru.po
> index 3e56eb546ea..d357bc30c2c 100644
> --- a/po/ru.po
> +++ b/po/ru.po
> @@ -12490,6 +12490,7 @@ msgstr "=D0=BF=D1=80=D0=B8=D1=87=D0=B8=D0=BD=D0=
=B0 =D0=BE=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F"
> =20
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  "        <tagname> [<commit> | <object>]"
>  msgstr ""
> =20
> diff --git a/po/sv.po b/po/sv.po
> index ad1aad94fff..1f878ee28bc 100644
> --- a/po/sv.po
> +++ b/po/sv.po
> @@ -12835,9 +12835,11 @@ msgstr "sk=C3=A4l till uppdateringen"
> =20
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  "        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a | -s | -u <nyckel-id>] [-f] [-m <medd> | -F <fil>] [-e]\n=
"
> +"        [(--trailer <symbol>[(=3D|:)<v=C3=A4rde>])...]\n"
>  "        <taggnamn> [<incheckning> | <objekt>]"
> =20
>  msgid "git tag -d <tagname>..."
> diff --git a/po/tr.po b/po/tr.po
> index 0e220e1c1cd..8c506c34a9e 100644
> --- a/po/tr.po
> +++ b/po/tr.po
> @@ -12975,10 +12975,12 @@ msgstr "g=C3=BCncelleme nedeni"
> =20
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  "        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a | -s | -u <anahtar-kimli=C4=9Fi>] [-f] [-m <ileti> | -F <=
dosya>] [-"
>  "e]\n"
> +"        [(--trailer <jeton>[(=3D|:)<de=C4=9Fer>])...]\n"
>  "        <etiket-ad=C4=B1> [<i=C5=9Fleme> | <nesne>]"
> =20
>  msgid "git tag -d <tagname>..."
> diff --git a/po/uk.po b/po/uk.po
> index 528a3dc6f76..e3b6441e3c1 100644
> --- a/po/uk.po
> +++ b/po/uk.po
> @@ -13086,10 +13086,12 @@ msgstr "=D0=BF=D1=80=D0=B8=D1=87=D0=B8=D0=BD=D0=
=B0 =D0=BE=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8F"
> =20
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  "        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a | -s | -u <=D1=96=D0=B4=D0=B5=D0=BD=D1=82=D0=B8=D1=84=D1=96=
=D0=BA=D0=B0=D1=82=D0=BE=D1=80-=D0=BA=D0=BB=D1=8E=D1=87=D0=B0>] [-f] [-m =
<=D0=B4=D0=BE=D0=BF=D0=B8=D1=81> | -F <=D1=84=D0=B0=D0=B9=D0=BB>] [-"
>  "e]\n"
> +"        [(--trailer <=D1=82=D0=BE=D0=BA=D0=B5=D0=BD>[(=3D|:)<=D0=B7=D0=
=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=BD=D1=8F>])...]\n"
>  "        <=D0=BD=D0=B0=D0=B7=D0=B2=D0=B0-=D1=82=D0=B5=D0=B3=D1=83> [<=D0=
=BA=D0=BE=D0=BC=D1=96=D1=82> | <=D0=BE=D0=B1=E2=80=99=D1=94=D0=BA=D1=82>]=
"
> =20
>  msgid "git tag -d <tagname>..."
> diff --git a/po/vi.po b/po/vi.po
> index 965e79e9658..0b206309f9b 100644
> --- a/po/vi.po
> +++ b/po/vi.po
> @@ -12915,9 +12915,11 @@ msgstr "l=C3=BD do c=E1=BA=ADp nh=E1=BA=ADt"
> =20
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  "        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <t=E1=BA=ADp-tin>=
] [-e]\n"
> +"        [(--trailer <th=E1=BA=BB>[(=3D|:)<gi=C3=A1-tr=E1=BB=8B>])...]=
\n"
>  "        <t=C3=AAn-th=E1=BA=BB> [<l=E1=BA=A7n chuy=E1=BB=83n giao> | <=
=C4=91=E1=BB=91i t=C6=B0=E1=BB=A3ng> ]"
> =20
>  msgid "git tag -d <tagname>..."
> diff --git a/po/zh_CN.po b/po/zh_CN.po
> index 4838c19b0be..aaedddcd864 100644
> --- a/po/zh_CN.po
> +++ b/po/zh_CN.po
> @@ -16033,9 +16033,11 @@ msgstr "=E6=9B=B4=E6=96=B0=E7=9A=84=E5=8E=9F=E5=
=9B=A0"
>  #: builtin/tag.c
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  "        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a | -s | -u <=E7=A7=81=E9=92=A5 ID>] [-f] [-m <=E6=B6=88=E6=
=81=AF> | -F <=E6=96=87=E4=BB=B6>] [-e]\n"
> +"        [(--trailer <=E9=94=AE>[(=3D|:)<=E5=80=BC>])...]\n"
>  "        <=E6=A0=87=E7=AD=BE=E5=90=8D> [<=E6=8F=90=E4=BA=A4> | <=E5=AF=
=B9=E8=B1=A1>]"
> =20
>  #: builtin/tag.c
> diff --git a/po/zh_TW.po b/po/zh_TW.po
> index f554381a7af..168591c141e 100644
> --- a/po/zh_TW.po
> +++ b/po/zh_TW.po
> @@ -15911,9 +15911,11 @@ msgstr "=E6=9B=B4=E6=96=B0=E7=9A=84=E5=8E=9F=E5=
=9B=A0"
>  #: builtin/tag.c
>  msgid ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  "        <tagname> [<commit> | <object>]"
>  msgstr ""
>  "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
> +"        [(--trailer <token>[(=3D|:)<value>])...]\n"
>  "        <tagname> [<commit> | <object>]"
> =20
>  #: builtin/tag.c
