Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85900C433E2
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 09:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6941520768
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 09:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgGQJZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQJZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 05:25:09 -0400
X-Greylist: delayed 2009 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Jul 2020 02:25:09 PDT
Received: from wp126.webpack.hosteurope.de (wp126.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8485::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B586CC061755
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 02:25:09 -0700 (PDT)
Received: from p2e50faf0.dip0.t-ipconnect.de ([46.80.250.240] helo=pan.bitplan.com); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jwM5i-0000WK-QT; Fri, 17 Jul 2020 10:51:38 +0200
To:     git@vger.kernel.org
From:   Wolfgang Fahl <wf@bitplan.com>
Subject: git pull warning
Autocrypt: addr=wf@bitplan.com; prefer-encrypt=mutual; keydata=
 mQENBE81PbUBCACX2+5dsKRdF4N5SNiqokbZekPpFPEE7oybvEt0+7I8fiJyeO3oA8qfkh2A
 xi/fEMpJqk5Rb0L9k/y+/4yd3xkXe32n9iqvraATjk0t9Aifo0V26eohRCigDGgTjLR4SjpL
 cWPjAwFZjf44g9iZuMw2oUiIPeJZb7AQnmOAw+WDj/HZoDbJMVLbsxseCef5h3oP/pzNW1qU
 tszsxgbtNfhZeKOZuRZlHqNRj3aihStVEazps/mE0bqaQhv2QGSrvZA1ApSWB1nmFGC3k0YI
 TS+zRIxtYI2K+932AiQttdYoIaObRcYqV1G9BtL7l6KClxadGMrNzIsil/PZC8Cb1fm9ABEB
 AAG0HldvbGZnYW5nIEZhaGwgPHdmQGJpdHBsYW4uY29tPokBVQQTAQIAPwIbIwYLCQgHAwIG
 FQgCCQoLBBYCAwECHgECF4AWIQSYI/xJldfKDYF+WnqQoAqcuYDxWAUCXHUFNQUJEuNiAAAK
 CRCQoAqcuYDxWMbfB/sFaKXOSGaK5NUpTZRlSkLvNrR3wc6Ega5Ts04qmhxd/5Wu4NMZMIGq
 AB/C1C0DpIwlxqbMsyFaeO28Y4D7z+LuVdhZTTNT31SEoL+fTU+S0jdKKa3WWFigtCDcIDkE
 ezmFjxfwPBMdI0k0aFNL7ACSu5tgqBLWPi8DEdI+7JeXJ6IRzxAWYB7ebThcUwyCtYK2xLr3
 j5edw84tD6s1cWR7f1tT/B/8zqH0a84iIzafhb2y+9UC9z+pGYc859rq3nWs6oxzHGQM2yB+
 NbNpTdpENjFAp6G7YwUoxU578M6KsYdYZwUnkpnwQkbdX/tDmP5zfXqZyQ15Cp2tQWbWnIvv
 uQENBE81PbUBCACjg30unuEFb2rTK6C/68IkPnJSJ2CTn0UymAglJmLY6/9z3wiPoySUKyYy
 9+sD0G5MUiVhXmXsbJUhM5JjLx1Z2jRQopPSOKLOJFmARS57Bghm0CQAZKO/KsKsftgkhUjz
 5RmmTZLYbgYB3BbgLCp4Sj1EXchJKTSfF++3rCHdNYJ8qG/QkqgiXexD1B10Yp1jRgi/Pkqh
 MNbgKKsI7DPyHLruNeFqp7dd2y0nmtW7AQnoz++ghqGEmITwi90x4fvH/nmaV/3qsD99rjmg
 DhZQy/XyLQaNyiU5D/gd9hD1KGKDS48YE7Z8w+8wEq/E03mQCPUQumrzl7nJV99bf29XABEB
 AAGJATwEGAECACYCGwwWIQSYI/xJldfKDYF+WnqQoAqcuYDxWAUCXHUFIAUJEuNh6wAKCRCQ
 oAqcuYDxWLnzB/9mU+9pHLMM4uHSk+NtkpcsKsG4eApkI7Y6rCyeZ9/fzwEGEX+KJRT4sOJr
 bL1ISkeqwiVsPEOyj33Uc9wi2NbRREXZR52gRM6SRQ1qUCJhyqfPrdgnHykZ2XYDqg4yDGy8
 NrCZhremEuVoXlkgx2Olpi/ZYc3Q7V5kNXT5Lj3mCb4txtSBwIy6VWckVu9TpS813wsXwjNm
 sIMEifMQ4RwimHQo43wpL0jQOX50WJ2ihupsSG7YrhJZ12nxSikNfp71YjFlhjOWUg3rRBQU
 75IuzaXtKLRvOliXzb4xzmWFFgS+zY/wzNEtjyHMoyxITX7GnWypzr2IrR+mJac5NoKu
Organization: BITPlan GmbH
Message-ID: <30eadf73-689a-b5fd-6e59-bfef4f48814b@bitplan.com>
Date:   Fri, 17 Jul 2020 10:51:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HV3U8idu9PZmI4hVcf3kxAPjOBunPpY7Q"
X-bounce-key: webpack.hosteurope.de;wf@bitplan.com;1594977909;bf70be14;
X-HE-SMSGID: 1jwM5i-0000WK-QT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HV3U8idu9PZmI4hVcf3kxAPjOBunPpY7Q
Content-Type: multipart/mixed; boundary="N3xOdnv9H5qKNYQOqHzLPjUEbjYRIpY33"

--N3xOdnv9H5qKNYQOqHzLPjUEbjYRIpY33
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



Vielen Dank f=C3=BCr das Ausf=C3=BCllen eines Git-Fehlerberichts!
Bitte antworten Sie auf die folgenden Fragen, um uns dabei zu helfen, Ihr=

Problem zu verstehen.

Was haben Sie gemacht, bevor der Fehler auftrat? (Schritte, um Ihr Fehler=

zu reproduzieren)
git pull
Was haben Sie erwartet, was passieren soll? (Erwartetes Verhalten)
git pull
Was ist stattdessen passiert? (Wirkliches Verhalten)
a warning

git pull
warning: Es wird davon abgeraten zu Pullen, ohne anzugeben, wie mit
abweichenden
Branches umgegangen werden soll. Sie k=C3=B6nnen diese Nachricht unterdr=C3=
=BCcken,
indem Sie einen der folgenden Befehle ausf=C3=BChren, bevor der n=C3=A4ch=
ste Pull
ausgef=C3=BChrt wird:

=C2=A0 git config pull.rebase false=C2=A0 # Merge (Standard-Strategie)
=C2=A0 git config pull.rebase true=C2=A0=C2=A0 # Rebase
=C2=A0 git config pull.ff only=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # auss=
chlie=C3=9Flich Vorspulen

Sie k=C3=B6nnen statt "git config" auch "git config --global" nutzen, um
einen Standard f=C3=BCr alle Repositories festzulegen. Sie k=C3=B6nnen au=
ch die
Option --rebase, --no-rebase oder --ff-only auf der Kommandozeile nutzen,=

um das konfigurierte Standardverhalten pro Aufruf zu =C3=BCberschreiben.

Bereits aktuell.
Was ist der Unterschied zwischen dem, was Sie erwartet haben und was
wirklich passiert ist?
the warning
Sonstige Anmerkungen, die Sie hinzuf=C3=BCgen m=C3=B6chten:
please remove the warning
Bitte =C3=BCberpr=C3=BCfen Sie den restlichen Teil des Fehlerberichts unt=
en.
Sie k=C3=B6nnen jede Zeile l=C3=B6schen, die Sie nicht mitteilen m=C3=B6c=
hten.


[System Info]
git Version:
git version 2.27.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
uname: Darwin 17.7.0 Darwin Kernel Version 17.7.0: Thu Jan 23 07:05:23
PST 2020; root:xnu-4570.71.69~1/RELEASE_X86_64 x86_64
Compiler Info: clang: 10.0.0 (clang-1000.10.44.4)
libc Info: keine libc Informationen verf=C3=BCgbar
"/tmp/git-bugreport-2020-07-17-1049.txt" 33L, 1083C

--=20

BITPlan - smart solutions
Wolfgang Fahl
Pater-Delp-Str. 1, D-47877 Willich Schiefbahn
Tel. +49 2154 811-480, Fax +49 2154 811-481
Web: http://www.bitplan.de
BITPlan GmbH, Willich - HRB 6820 Krefeld, Steuer-Nr.: 10258040548, Gesch=C3=
=A4ftsf=C3=BChrer: Wolfgang Fahl=20



--N3xOdnv9H5qKNYQOqHzLPjUEbjYRIpY33--

--HV3U8idu9PZmI4hVcf3kxAPjOBunPpY7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEmCP8SZXXyg2Bflp6kKAKnLmA8VgFAl8RZpoACgkQkKAKnLmA
8Vj1jQf/ZbkXzEz5Swx0qn2wTrTMbQgWE4QLffD4L+206t9G1PyVBiBy9ACJ6Eds
MXh6fGI7wYulK4yrWsEs4rHKLseGymkWq5QPRbTR32pMe3O6wKr1bUVLnkSY21xP
0GE1hbSPWHsxA7oVSksL2NR2XclMOCuisZZG0nGH5Y+gWy8bo8k9p4/XXuUwlAQI
tDVI/ZdX7STA/ZUDJCkMrpAC6/S9tGBugCMMo4t7bdJPBXp4gCA5lDUdV83O2bIR
h0gYqx99ID7kkxLsRfRujc5EONZy3WdRB70yGZwgNVFh+x7oh3/lDtzh6TjDin2I
WT9vGCUqqqZwQaMelLJhuNaKJr3+OA==
=Pv5M
-----END PGP SIGNATURE-----

--HV3U8idu9PZmI4hVcf3kxAPjOBunPpY7Q--
