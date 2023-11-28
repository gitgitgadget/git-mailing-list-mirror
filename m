Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dpZXRSIm"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8197D1A5
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 17:54:22 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9DD191D4ED;
	Mon, 27 Nov 2023 20:54:21 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to:content-transfer-encoding; s=sasl; bh=DX4DkEzt3MOCq
	bal+9rB6sCUPcXdA02iGp5hX8oZfBc=; b=dpZXRSImiEu1UvpWAXM7N5jHea2JF
	8By6VonvEsxSoqZYQqkPpsuFbSGEhUuEgnaVDrmWwt19giKFAkDvKrpfUFiZawF8
	WtLV9jswYWdSCGc1L5fvsvxxxmweB6gtlb4+LRVj5wfDZroR6jQ4VyrT/rwoccII
	TXir41pgXLBtUc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 95BE71D4EC;
	Mon, 27 Nov 2023 20:54:21 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C046F1D4E5;
	Mon, 27 Nov 2023 20:54:16 -0500 (EST)
	(envelope-from tmz@pobox.com)
Date: Mon, 27 Nov 2023 20:54:13 -0500
From: Todd Zullinger <tmz@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Matt Burke <spraints@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>
Subject: Re: Migration of git-scm.com to a static web site: ready for
 review/testing
Message-ID: <ZWVIRXodL9pQZbtj@pobox.com>
References: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de>
 <ZVeUQEG5jIzKbvmT@pobox.com>
 <4dd9b45d-b352-d8ba-3314-96ab48f7abf7@gmx.de>
 <ZVgoKPAg6jKZk_M6@pobox.com>
 <1d83b8f8-b739-6277-ac4f-e7fe6ff2d2fe@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9dunkuSzfuOUDp/B"
Content-Disposition: inline
In-Reply-To: <1d83b8f8-b739-6277-ac4f-e7fe6ff2d2fe@gmx.de>
X-Pobox-Relay-ID:
 09F49378-8D91-11EE-A184-F515D2CDFF5E-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: 7bit


--9dunkuSzfuOUDp/B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

Johannes Schindelin wrote:
> I found https://lychee.cli.rs/#/ in the meantime and figured out how to
> use it in a local setup:

Nice.  That's much faster.

> My most recent lychee run results in 0 broken links.
>=20
> As a bonus, some of the links that are currently broken on
> https://git-scm.com/ are fixed in https://git.github.io/git-scm.com/.
> For example, following the `Pull Request Referl=C9=99ri` link at the to=
p of
> https://git-scm.com/book/az/v2/Appendix-C:-Git-%C6%8Fmrl%C9%99ri-Plumbi=
ng-%C6%8Fmrl%C9%99ri/
> leads to a 404. But following it in
> https://git.github.io/git-scm.com/book/az/v2/Appendix-C:-Git-%C6%8Fmrl%=
C9%99ri-Plumbing-%C6%8Fmrl%C9%99ri/
> directs the browser to the correct URL:
> https://git.github.io/git-scm.com/book/az/v2/GitHub-Bir-Layih%C9%99nin-=
Saxlan%C4%B1lmas%C4%B1/#_pr_refs
>=20
> Another thing that is broken on https://git-scm.com/ are the footnotes =
in
> the Czech translation of the ProGit book. These were broken in the Hugo
> version, too, but now they are fixed. See e.g.
> https://dscho.github.io/git-scm.com/book/cs/v2/Z%C3%A1klady-pr%C3%A1ce-=
se-syst%C3%A9mem-Git-Zobrazen%C3%AD-historie-reviz%C3%AD/#_footnotedef_7
> and note that the Rails App redirects to
> https://git-scm.com/book/cs/v2/Z%C3%A1klady-pr%C3%A1ce-se-syst%C3%A9mem=
-Git-Zobrazen%C3%AD-historie-reviz%C3%AD/ch00/_footnotedef_7
> when clicking on the `[7]`, which 404s.
>=20
> Could you double-check that the links in the current version?

Since I had it already, I ran linkchecker again.  It found
25 errors.  I'll attach the output, though I'm not sure if
the list will pass it along or not.

It looks like a number of errors are due to '?' characters
in the generated links, e.g.:

https://git.github.io/git-scm.com/book/en/v2/Getting-Started-What-is-Git?=
/

Cheers,

--=20
Todd

--9dunkuSzfuOUDp/B
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="git.github.io_git-scm.com.txt"
Content-Transfer-Encoding: quoted-printable

LinkChecker 10.2.1
Copyright (C) 2000-2016 Bastian Kleineidam, 2010-2022 LinkChecker Authors
LinkChecker comes with ABSOLUTELY NO WARRANTY!
This is free software, and you are welcome to redistribute it under
certain conditions. Look at the file `LICENSE' within this distribution.
Read the documentation at https://linkchecker.github.io/linkchecker/
Write comments and bugs to https://github.com/linkchecker/linkchecker/iss=
ues

Start checking at 2023-11-25 18:49:01+000

URL        `/git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F'
Name       `What is Git?'
Parent URL https://git.github.io/git-scm.com/book/en/v2, line 9, col 1
Real URL   https://git.github.io/git-scm.com/book/en/v2/Getting-Started-W=
hat-is-Git?/
Check time 2.388 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/en/v2/Getting-Started-=
What-is-Git?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/az/v2/Ba%c5%9flan%c4%9f%c4%b1c-Git-N%c9%99d=
ir%3F'
Name       `Git N=C9=99dir?'
Parent URL https://git.github.io/git-scm.com/book/az/v2, line 8, col 1
Real URL   https://git.github.io/git-scm.com/book/az/v2/Ba%C5%9Flan%C4%9F=
%C4%B1c-Git-N%C9%99dir?/
Check time 0.074 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/az/v2/Ba%C5%9Flan%C4%9=
F%C4%B1c-Git-N%C9%99dir?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/de/v2/Erste-Schritte-Was-ist-Versionsverwal=
tung%3F'
Name       `Erste Schritte'
Parent URL https://git.github.io/git-scm.com/book/de/v2, line 5, col 3159
Real URL   https://git.github.io/git-scm.com/book/de/v2/Erste-Schritte-Wa=
s-ist-Versionsverwaltung?/
Check time 0.121 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/de/v2/Erste-Schritte-W=
as-ist-Versionsverwaltung?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/de/v2/Erste-Schritte-Was-ist-Git%3F'
Name       `Was ist Git?'
Parent URL https://git.github.io/git-scm.com/book/de/v2, line 8, col 1
Real URL   https://git.github.io/git-scm.com/book/de/v2/Erste-Schritte-Wa=
s-ist-Git?/
Check time 0.068 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/de/v2/Erste-Schritte-W=
as-ist-Git?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/es/v2/Inicio---Sobre-el-Control-de-Versione=
s-%c2%bfC%c3%b3mo-obtener-ayuda%3F'
Name       `=C2=BFC=C3=B3mo obtener ayuda?'
Parent URL https://git.github.io/git-scm.com/book/es/v2, line 12, col 1
Real URL   https://git.github.io/git-scm.com/book/es/v2/Inicio---Sobre-el=
-Control-de-Versiones-%C2%BFC%C3%B3mo-obtener-ayuda?/
Check time 0.093 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/es/v2/Inicio---Sobre-e=
l-Control-de-Versiones-%C2%BFC%C3%B3mo-obtener-ayuda?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/es/v2/Ramificaciones-en-Git-%c2%bfQu%c3%a9-=
es-una-rama%3F'
Name       `Ramificaciones en Git'
Parent URL https://git.github.io/git-scm.com/book/es/v2, line 21, col 111
Real URL   https://git.github.io/git-scm.com/book/es/v2/Ramificaciones-en=
-Git-%C2%BFQu%C3%A9-es-una-rama?/
Check time 0.094 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/es/v2/Ramificaciones-e=
n-Git-%C2%BFQu%C3%A9-es-una-rama?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/ko/v2/%ec%8b%9c%ec%9e%91%ed%95%98%ea%b8%b0-=
%eb%b2%84%ec%a0%84-%ea%b4%80%eb%a6%ac%eb%9e%80%3F'
Name       `=EC=8B=9C=EC=9E=91=ED=95=98=EA=B8=B0'
Parent URL https://git.github.io/git-scm.com/book/ko/v2, line 5, col 3159
Real URL   https://git.github.io/git-scm.com/book/ko/v2/%EC%8B%9C%EC%9E%9=
1%ED%95%98%EA%B8%B0-%EB%B2%84%EC%A0%84-%EA%B4%80%EB%A6%AC%EB%9E%80?/
Check time 0.094 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/ko/v2/%EC%8B%9C%EC%9E%=
91%ED%95%98%EA%B8%B0-%EB%B2%84%EC%A0%84-%EA%B4%80%EB%A6%AC%EB%9E%80?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/nl/v2/Aan-de-slag-Wat-is-Git%3F'
Name       `Wat is Git?'
Parent URL https://git.github.io/git-scm.com/book/nl/v2, line 8, col 1
Real URL   https://git.github.io/git-scm.com/book/nl/v2/Aan-de-slag-Wat-i=
s-Git?/
Check time 0.070 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/nl/v2/Aan-de-slag-Wat-=
is-Git?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/ru/v2/%d0%92%d0%b2%d0%b5%d0%b4%d0%b5%d0%bd%=
d0%b8%d0%b5-%d0%a7%d1%82%d0%be-%d1%82%d0%b0%d0%ba%d0%be%d0%b5-Git%3F'
Name       `=D0=A7=D1=82=D0=BE =D1=82=D0=B0=D0=BA=D0=BE=D0=B5 Git?'
Parent URL https://git.github.io/git-scm.com/book/ru/v2, line 8, col 1
Real URL   https://git.github.io/git-scm.com/book/ru/v2/%D0%92%D0%B2%D0%B=
5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%A7%D1%82%D0%BE-%D1%82%D0%B0%D0%BA%D0%=
BE%D0%B5-Git?/
Check time 0.075 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/ru/v2/%D0%92%D0%B2%D0%=
B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%A7%D1%82%D0%BE-%D1%82%D0%B0%D0%BA%D0=
%BE%D0%B5-Git?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/sl/v2/Za%c4%8detek-Kaj-je-Git%3F'
Name       `Kaj je Git?'
Parent URL https://git.github.io/git-scm.com/book/sl/v2, line 8, col 1
Real URL   https://git.github.io/git-scm.com/book/sl/v2/Za%C4%8Detek-Kaj-=
je-Git?/
Check time 0.071 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/sl/v2/Za%C4%8Detek-Kaj=
-je-Git?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/ru/v2/%d0%92%d0%b2%d0%b5%d0%b4%d0%b5%d0%bd%=
d0%b8%d0%b5-%d0%9a%d0%b0%d0%ba-%d0%bf%d0%be%d0%bb%d1%83%d1%87%d0%b8%d1%82=
%d1%8c-%d0%bf%d0%be%d0%bc%d0%be%d1%89%d1%8c%3F'
Name       `=D0=9A=D0=B0=D0=BA =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=
=D1=8C =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C?'
Parent URL https://git.github.io/git-scm.com/book/ru/v2, line 12, col 1
Real URL   https://git.github.io/git-scm.com/book/ru/v2/%D0%92%D0%B2%D0%B=
5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%9A%D0%B0%D0%BA-%D0%BF%D0%BE%D0%BB%D1%=
83%D1%87%D0%B8%D1%82%D1%8C-%D0%BF%D0%BE%D0%BC%D0%BE%D1%89%D1%8C?/
Check time 0.077 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/ru/v2/%D0%92%D0%B2%D0%=
B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%9A%D0%B0%D0%BA-%D0%BF%D0%BE%D0%BB%D1=
%83%D1%87%D0%B8%D1%82%D1%8C-%D0%BF%D0%BE%D0%BC%D0%BE%D1%89%D1%8C?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/sr/v2/%d0%9f%d0%be%d1%87%d0%b5%d1%82%d0%b0%=
d0%ba-%d0%a8%d1%82%d0%b0-%d1%98%d0%b5-%d0%93%d0%b8%d1%82%3F'
Name       `=D0=A8=D1=82=D0=B0 =D1=98=D0=B5 =D0=93=D0=B8=D1=82?'
Parent URL https://git.github.io/git-scm.com/book/sr/v2, line 8, col 1
Real URL   https://git.github.io/git-scm.com/book/sr/v2/%D0%9F%D0%BE%D1%8=
7%D0%B5%D1%82%D0%B0%D0%BA-%D0%A8%D1%82%D0%B0-%D1%98%D0%B5-%D0%93%D0%B8%D1=
%82?/
Check time 0.084 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/sr/v2/%D0%9F%D0%BE%D1%=
87%D0%B5%D1%82%D0%B0%D0%BA-%D0%A8%D1%82%D0%B0-%D1%98%D0%B5-%D0%93%D0%B8%D=
1%82?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/uz/v2/%d0%98%d1%88-%d0%b1%d0%be%d1%88%d0%bb=
%d0%b0%d0%bd%d0%b8%d1%88%d0%b8-%d2%9a%d0%b0%d0%bd%d0%b4%d0%b0%d0%b9-%d1%9=
1%d1%80%d0%b4%d0%b0%d0%bc-%d0%be%d0%bb%d0%b8%d1%88-%d0%bc%d1%83%d0%bc%d0%=
ba%d0%b8%d0%bd%3F'
Name       `=D2=9A=D0=B0=D0=BD=D0=B4=D0=B0=D0=B9 =D1=91=D1=80=D0=B4=D0=B0=
=D0=BC =D0=BE=D0=BB=D0=B8=D1=88 =D0=BC=D1=83=D0=BC=D0=BA=D0=B8=D0=BD?'
Parent URL https://git.github.io/git-scm.com/book/uz/v2, line 12, col 1
Real URL   https://git.github.io/git-scm.com/book/uz/v2/%D0%98%D1%88-%D0%=
B1%D0%BE%D1%88%D0%BB%D0%B0%D0%BD%D0%B8%D1%88%D0%B8-%D2%9A%D0%B0%D0%BD%D0%=
B4%D0%B0%D0%B9-%D1%91%D1%80%D0%B4%D0%B0%D0%BC-%D0%BE%D0%BB%D0%B8%D1%88-%D=
0%BC%D1%83%D0%BC%D0%BA%D0%B8%D0%BD?/
Check time 0.074 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/uz/v2/%D0%98%D1%88-%D0=
%B1%D0%BE%D1%88%D0%BB%D0%B0%D0%BD%D0%B8%D1%88%D0%B8-%D2%9A%D0%B0%D0%BD%D0=
%B4%D0%B0%D0%B9-%D1%91%D1%80%D0%B4%D0%B0%D0%BC-%D0%BE%D0%BB%D0%B8%D1%88-%=
D0%BC%D1%83%D0%BC%D0%BA%D0%B8%D0%BD?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/be/v2/%d0%9f%d0%b5%d1%80%d1%88%d1%8b%d1%8f-=
%d0%ba%d1%80%d0%be%d0%ba%d1%96-What-is-Git%3F'
Name       `What is Git?'
Parent URL https://git.github.io/git-scm.com/book/be/v2, line 8, col 1
Real URL   https://git.github.io/git-scm.com/book/be/v2/%D0%9F%D0%B5%D1%8=
0%D1%88%D1%8B%D1%8F-%D0%BA%D1%80%D0%BE%D0%BA%D1%96-What-is-Git?/
Check time 0.105 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/be/v2/%D0%9F%D0%B5%D1%=
80%D1%88%D1%8B%D1%8F-%D0%BA%D1%80%D0%BE%D0%BA%D1%96-What-is-Git?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/it/v2/Per-Iniziare-Cos%e2%80%99%c3%a9-Git%3=
F'
Name       `Cos=E2=80=99=C3=A9 Git?'
Parent URL https://git.github.io/git-scm.com/book/it/v2, line 8, col 1
Real URL   https://git.github.io/git-scm.com/book/it/v2/Per-Iniziare-Cos%=
E2%80%99%C3%A9-Git?/
Check time 0.068 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/it/v2/Per-Iniziare-Cos=
%E2%80%99%C3%A9-Git?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/ms/v2/Getting-Started-What-is-Git%3F'
Name       `What is Git?'
Parent URL https://git.github.io/git-scm.com/book/ms/v2, line 8, col 1
Real URL   https://git.github.io/git-scm.com/book/ms/v2/Getting-Started-W=
hat-is-Git?/
Check time 0.078 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/ms/v2/Getting-Started-=
What-is-Git?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/sv/v2/Kom-ig%c3%a5ng-Vad-%c3%a4r-Git%3F'
Name       `Vad =C3=A4r Git?'
Parent URL https://git.github.io/git-scm.com/book/sv/v2, line 8, col 1
Real URL   https://git.github.io/git-scm.com/book/sv/v2/Kom-ig%C3%A5ng-Va=
d-%C3%A4r-Git?/
Check time 0.086 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/sv/v2/Kom-ig%C3%A5ng-V=
ad-%C3%A4r-Git?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/tr/v2/Ba%c5%9flang%c4%b1%c3%a7-Git-Nedir%3F=
'
Name       `Git Nedir?'
Parent URL https://git.github.io/git-scm.com/book/tr/v2, line 8, col 1
Real URL   https://git.github.io/git-scm.com/book/tr/v2/Ba%C5%9Flang%C4%B=
1%C3%A7-Git-Nedir?/
Check time 0.076 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/book/tr/v2/Ba%C5%9Flang%C4%=
B1%C3%A7-Git-Nedir?/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/book/fr/v2/Les-branches-avec-Git-Branches-et-fus=
ions'
Name       `next'
Parent URL https://git.github.io/git-scm.com/book/fr/v2/Les-branches-avec=
-Git-Les-branches-en-bref, line 160, col 1436
Real URL   https://git.github.io/git-scm.com/book/fr/v2/Les-branches-avec=
-Git-Branches-et-fusions
Check time 1.887 seconds
Size       1KB
Result     Error: 404 Not Found

URL        `/git-scm.com/docs/git-submodules'
Parent URL https://git.github.io/git-scm.com/docs/git-submodules/fr, line=
 2, col 1
Real URL   https://git.github.io/git-scm.com/docs/git-submodules/
Check time 5.581 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/docs/git-submodules/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/docs/git-maintainance'
Parent URL https://git.github.io/git-scm.com/docs/git-maintainance/is, li=
ne 2, col 1
Real URL   https://git.github.io/git-scm.com/docs/git-maintainance/
Check time 5.867 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/docs/git-maintainance/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/docs/gitignorar'
Parent URL https://git.github.io/git-scm.com/docs/gitignorar/pt_BR, line =
2, col 1
Real URL   https://git.github.io/git-scm.com/docs/gitignorar/
Check time 5.546 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/docs/gitignorar/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/docs/git-fsmonitor----daemon'
Parent URL https://git.github.io/git-scm.com/docs/git-fsmonitor----daemon=
/pt_BR, line 2, col 1
Real URL   https://git.github.io/git-scm.com/docs/git-fsmonitor----daemon=
/
Check time 5.616 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/docs/git-fsmonitor----daemo=
n/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/docs/git-pack'
Parent URL https://git.github.io/git-scm.com/docs/git-pack/pt_BR, line 2,=
 col 1
Real URL   https://git.github.io/git-scm.com/docs/git-pack/
Check time 4.311 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/docs/git-pack/'.
Result     Error: 404 Not Found

URL        `/git-scm.com/docs/git-hash'
Parent URL https://git.github.io/git-scm.com/docs/git-hash/fr, line 2, co=
l 1
Real URL   https://git.github.io/git-scm.com/docs/git-hash/
Check time 1.156 seconds
Size       1KB
Info       Redirected to
           `https://git.github.io/git-scm.com/docs/git-hash/'.
Result     Error: 404 Not Found

Statistics:
Downloaded: 302.2MB.
Content types: 5656 image, 11838 text, 0 video, 0 audio, 15 application, =
29 mail and 620 other.
URL lengths: min=3D15, max=3D841, avg=3D72.

That's it. 18158 links in 19951 URLs checked. 0 warnings found. 25 errors=
 found.
Stopped checking at 2023-11-25 19:34:52+000 (45 minutes, 51 seconds)

--9dunkuSzfuOUDp/B--
