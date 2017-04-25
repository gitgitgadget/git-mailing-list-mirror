Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0DC207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 10:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1429378AbdDYKeo (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 06:34:44 -0400
Received: from mx1.ernw.net ([62.159.96.78]:28528 "EHLO mx1.ernw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1428425AbdDYKel (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 06:34:41 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Apr 2017 06:34:41 EDT
Received: from mail1.ernw.net (unknown [172.31.1.30])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail1.ernw.net", Issuer "ernw ca1" (verified OK))
        by mx1.ernw.net (Postfix) with ESMTPS id 129AC27323
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 12:29:27 +0200 (CEST)
Received: from [IPv6:fd00:2001:0:cf20::101f] (unknown [IPv6:fd00:2001:0:cf20::101f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail1.ernw.net (Postfix) with ESMTPSA id DF44153A1B7
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 12:29:26 +0200 (CEST)
To:     git@vger.kernel.org
From:   Timo Schmid <tschmid@ernw.de>
Subject: Git Shell Security Issues
Organization: ERNW GmbH
Message-ID: <5a5b33d8-f36f-bf94-6473-a9c2a980f65d@ernw.de>
Date:   Tue, 25 Apr 2017 12:29:22 +0200
User-Agent: PyMail (Python SMTP class)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="fTtdDWnGCek9ASxBui3nctHVbQbnlAV9o"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fTtdDWnGCek9ASxBui3nctHVbQbnlAV9o
Content-Type: multipart/mixed; boundary="lUJTFlvVkgBmJ5JGnsTTU1M7RA05Ke87M";
 protected-headers="v1"
From: Timo Schmid <tschmid@ernw.de>
To: git@vger.kernel.org
Message-ID: <5a5b33d8-f36f-bf94-6473-a9c2a980f65d@ernw.de>
Subject: Git Shell Security Issues

--lUJTFlvVkgBmJ5JGnsTTU1M7RA05Ke87M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

I've found a security issue in the git-shell command, which allows authen=
ticated
attackers to read files, partially write files and in some configurations=
 to execute
shell commands in the context of the remote user.

Should I report the details here or is there a security mailing list whic=
h I haven't
found yet?

Thanks,
--=20
Timo Schmid

ERNW GmbH, Carl-Bosch-Str. 4, 69115 Heidelberg  -  www.ernw.de
Tel. +49 6221 48039-0 (HQ) - Fax +49 6221 419008 - Cell +49 151 16227192
PGP-FP F436 A5DE D817 E5A6 AFA0 A0A5 E04E 7BA1 EBDF B848

Handelsregister Mannheim: HRB 337135
Geschaeftsfuehrer: Enno Rey

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
|| Blog: www.insinuator.net | | Conference: www.troopers.de ||
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


--lUJTFlvVkgBmJ5JGnsTTU1M7RA05Ke87M--

--fTtdDWnGCek9ASxBui3nctHVbQbnlAV9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBAwAdFiEE9Dal3tgX5aavoKCl4E57oevfuEgFAlj/JQIACgkQ4E57oevf
uEgkzQ/9FMAau9jXGfl433ldZS9S/o8vBNyQYPmQTY9IzR7dSawmB6ZrRuE7asHz
dPyDk1i4Ghihp8FkFFI7DJyHUrqT7DcuMYLT5EZkEluj+UOpJJifdwVNDNFXb4E0
jsdRF0BNNMbo8nBP8NaiPqojmSuSGPnFM9osVkCXgvpmeAtPEhhjenDwRLFQyB4A
OJC5dkAyj0qJa1In+K/D+6HTUhC17QUKrpWZ3dz7/HeiE3VfQygKXpSaMO4FlIek
sast6/rfCSfv/R1zLhX9kLed3q6tXP9AM1Vjydu9UVPWJMN4Za9r+9oEhqdw1Gh8
j8Fu7bKIfIztR9DVOHnbXpIr1mKFOWgPQMlVlSMVCNPjApY7tWZxPAgp+J0prSPM
+rdQmFATTmRSWdmHJOUYVfoJ6PDGttaKU/WSIIIBCrVM1k7nHlrKU6Yum3Juvsyl
aWivfGfx/0srZX0Jmvis69cdMg44qZQcxFQCe3fT+TiOxJVt6QOL7Oj0SfyneMIC
3cGbVTOqakpn9F4dvDUFvdl3ujytDPOKjCKoDNp5Zn+/jaoTGMt8s8VnJqdjlr6P
rwg/HUKpzOWU3ewkNNADI4sP8NTcdwJBMlhyh11LkdwJxWZ5RiahzP3yezs6gGX1
ON3k9eMWcIyqFPL9mCHvvnMoeBxumOA1IXWQkTlp9X7tT2hJTm0=
=/m9B
-----END PGP SIGNATURE-----

--fTtdDWnGCek9ASxBui3nctHVbQbnlAV9o--
