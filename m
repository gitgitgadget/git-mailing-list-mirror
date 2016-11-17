Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655A11FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 19:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754325AbcKQTBh (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 14:01:37 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:56494 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753383AbcKQTBh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 14:01:37 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Nov 2016 14:01:36 EST
Received: from [95.222.122.98] (helo=[192.168.178.44])
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.84)
        (envelope-from <archlinux@nicohood.de>)
        id 1c7Ro7-0006if-1w
        for git@vger.kernel.org; Thu, 17 Nov 2016 19:53:11 +0100
To:     git@vger.kernel.org
From:   NicoHood <archlinux@nicohood.de>
Subject: [Bug] gpgsign bashcompletion not available
Message-ID: <8998a9be-e7b3-7726-46c8-e60b45eabb3f@nicohood.de>
Date:   Thu, 17 Nov 2016 19:52:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CG50DCJC24kf6rbXp7aU387CDSsRLN4ci"
X-Df-Sender: bWFpbEBuaWNvaG9vZC5kZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CG50DCJC24kf6rbXp7aU387CDSsRLN4ci
Content-Type: multipart/mixed; boundary="dgN7vc1NBGCcG5AW1fopX09skgS38OiWC";
 protected-headers="v1"
From: NicoHood <archlinux@nicohood.de>
To: git@vger.kernel.org
Message-ID: <8998a9be-e7b3-7726-46c8-e60b45eabb3f@nicohood.de>
Subject: [Bug] gpgsign bashcompletion not available

--dgN7vc1NBGCcG5AW1fopX09skgS38OiWC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The gpgsign feature is not available via bashcompletion on git.

$ git config --global commit.
commit.status     commit.template  =20
$ git config --global commit.gpgsign true
$ git --version
git version 2.10.2

Due to this I could also find no option to automatically sign every tag
that I do. If this option does not exist yet, please add it to the todo
list. If those reports are tracked anywhere else, please also let me
know, so I can test that out.

Cheers,
Nico


--dgN7vc1NBGCcG5AW1fopX09skgS38OiWC--

--CG50DCJC24kf6rbXp7aU387CDSsRLN4ci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYLfx1AAoJEFHa6bfBrpFhIO8P/iEMvNie8439PDUYB4vpqME8
j+F3L7UcpsZsJR7UCOlr+Kadxpq4y1Ne3AvA9eMjee/Fg/CrBFjssivzcBZdPQa7
fy8sBgDoL+WyA1b+s5DxbaZzQVSUb9NSXQbKn31kvnQTrvGlQADFusp1QXv3gQg5
nkNRHEEzDtgYMBLxWi8ftdwT2WQp6F3PiqVzgQUwE8hyQMCZcahOIBvlfWPE0/gq
8hZLqGuaqUq7u9y8zR61Nm5Y0c5+9rMXG5mr1zNS7OB6gi4StY3cUIB5Mqoa5+6R
LPXc7tgF9BVO+eLA0+zVHzL0LNIfcCMUSD2OGhznrCOckCgNZ5Vw3hllQvG42l0G
L3DH5RTQP8BHscw/lZCkP7uebUrws3cF8RA/XMz27UIsWzwCtfkdhyd0ci5WV1Rd
/mzcBcNU+A/6g7+GiYBFQpoqz023tF0DS04lOdS30UjXoCBUq+6ahRGkuAM+5QFE
uHhXGbey49S0tU/Rl71SQP832ShBpHcA205tR0JfIeGcwti5botPPbd0ZbV+ljB3
21S1fDV8KWVR+oWgzV2Z30JWui6hIUciWF4s8a9cCjC1b5qMf2ynu5auKuj94k73
hQHNI6D27+uH1r24aUZL0pRW6Dhs5hzQcmTpyqA4cwL9ZxkFm7ZfxrNJtE50WgKG
IlFbeD//CIHglT8lhcDF
=JzvO
-----END PGP SIGNATURE-----

--CG50DCJC24kf6rbXp7aU387CDSsRLN4ci--
