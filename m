Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9400E20248
	for <e@80x24.org>; Sat, 16 Mar 2019 10:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCPKoR (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 06:44:17 -0400
Received: from mx-ext.e-mehlbox.eu ([81.7.14.185]:56381 "EHLO e-mehlbox.eu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726571AbfCPKoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 06:44:16 -0400
Received: from [IPv6:2003:f8:5bc3:e001:4d49:c132:2c58:2203] (p200300F85BC3E0014D49C1322C582203.dip0.t-ipconnect.de [IPv6:2003:f8:5bc3:e001:4d49:c132:2c58:2203])
        (Authenticated sender: alexander.blesius)
        by e-mehlbox.eu (Postfix) with ESMTPSA id D433A133AE82
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 11:34:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=blesius.eu; s=mail;
        t=1552732480; bh=nWRNrMEq9yJIVTdqzI+kvQV+4nU7JIMacMGGbYb2BUE=;
        h=From:Subject:To:Date;
        b=G67dFT6v72jIrT888lm91k7hezS6RXtnavZlHSf6UuqNBnUFpYcv3zQ9sJhV3jb28
         Lh4IdtTC4ffyDcBPBEuSwT2+dyDVHWOhyvSZQ6vilRcP9M4vydTM0GPLcNha+MycT/
         vibmST4Ub8aZdIGTrpGj5D+DeyJ97yw17E9pay2w=
From:   Alexander Blesius <alexander+git@blesius.eu>
Subject: [PATCH] doc: fix typos in man pages
To:     git@vger.kernel.org
Openpgp: preference=signencrypt
Autocrypt: addr=alexander+git@blesius.eu; prefer-encrypt=mutual; keydata=
 mQENBFO5X3UBCADDxy2dppA+7A+KEXWx3rS44pdKC6nYx6m3XEWxfs45CKbSq0J88Zupmqrw
 M0MWK/KbzeBQ0N2IjHp8DaflY7pI3uDOoDqKZ5GiAeXIpaeBDD6z3am5/abQRG5oY8Zy2O+3
 OyA78R9LnbMRXvb2+mOfPZYGA14zkhAlGUj8u7Hm3n2IkVJMlKjpYnj1GZcgc+01nnnUT3fn
 0lhGkcxzOiiGkMWaZ5Nyh5sYEDGhFquySGFihmbbxkNsqXD8MffqQc2N7rrxl2GOnAlTlNG4
 XwLscJC8XgF5x+ChrQyrgcdhoXsd8E/PXawkwWVPWr1eNP3BXjBlczT+9qnziM7A+ZqzABEB
 AAG0P0FsZXhhbmRlciBCbGVzaXVzIChwcml2YXRlIG1haWwgYWRkcmVzcykgPGFsZXhhbmRl
 ckBibGVzaXVzLmV1PokBWQQTAQIAQwIbIwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAhkB
 FiEEeKbtWWINxpqa7GJ7r0HG3q8DMW4FAlmpF0IFCQ9VuU0ACgkQr0HG3q8DMW6Ztwf7BDK2
 V6Nv+qoSC3rqPV9Mzu0JXZJ9QSJzf+B+DZLFP0iHmPhcKUidYs2ZibqsMVB7+jKLsmEtqJJl
 EjLZ+aSoQXGDsdnntV/4QvtSoCuqUeBQO8gm2OlPk/uBUdwKLup48LaebpqN/pd/EDKcE67K
 +u8F197Hg0pARUJ5iJEDn0ciDw/u7ycNruPNndCiNVg/28w+5sVOlC7g6C19CAMQo1dwc4D8
 ARTXteNePPAiNbnmJaXFLNxSWVAbyJe98noqBlEsVzhy0YlEIpAhlMFn3E/+dwhurBXTpKdW
 o8cXiMvb0I85W0s9+yjYtnqVJlNYSLuPIkAqU7hUnjla0LIrrLkBDQRTuV91AQgA5kINGMjs
 ZMaFKgxrabujJsCUY1mL7CCf2JOfAB0MuPBVi5O6mK5lrIMD+vFhJll2+rHGvUApB4CMt4OV
 hiqzUjuO6pmIoBl/QzFic8/I/KG3tuCciz3HrDwYiGSpe684THqELb4JFYCi2rzEOJm462g7
 VI507hqaG3JBfjZFIsg7atwKGseaJpHwY2zW5wpbpE6xH9+8X6Q3DTeUru9SlD/Pu6crE/We
 5tEgzneMaewLNnEoL2tSsLv6lr7ZB6zaAM9VyW59W30VxlIXoeQl3lUM/XQG/8wnKCTqKlGA
 DxieeVds0G5SqoLuGoq0oPiruPXm+meZSFMNu2mBqIA0QQARAQABiQE8BBgBAgAmAhsMFiEE
 eKbtWWINxpqa7GJ7r0HG3q8DMW4FAlmpF0cFCQ9VuVIACgkQr0HG3q8DMW52mwf+PoUtEap+
 DTv+/T1ZIwSabpuz28NsZj/O1kJBv8PJ7xLC5jKzpU5cIFIv2AG0bqZzFsgDRZBfB8SW0QgY
 8lqHovxSF8V5RgnzhJNMYmPKWGsvWHrWiafh+YXrT5NBSQmpZD61yYEF64CUIXe9pbFPSdex
 Aye81qKTWjekoVa35VsDmXq8zskXTHZE9NKngL5mTzSSwFzivrWHy6IhMHZhpEXsU3bfaDpu
 GCpHlNKZZIsN64CiE3js4BsyGd42mA5DFA0NJ0PugWmPV3e1WhU9yBcYyR2IMqOujBofIVKr
 AI4eVDrld6ki2Dh1g+AnACyCG4XEXqhaKWa5/lg/E4X+0Q==
Message-ID: <6e00f5fc-13a3-a9b9-d964-f787ae194a73@blesius.eu>
Date:   Sat, 16 Mar 2019 11:34:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Pe2WcxZdUgmEflfqfWwl6zSRcGITyNixj"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pe2WcxZdUgmEflfqfWwl6zSRcGITyNixj
Content-Type: multipart/mixed; boundary="F0LkJP3q9rAfda2tHR3dlJJjEWahhw1vJ";
 protected-headers="v1"
From: Alexander Blesius <alexander+git@blesius.eu>
To: git@vger.kernel.org
Message-ID: <6e00f5fc-13a3-a9b9-d964-f787ae194a73@blesius.eu>
Subject: [PATCH] doc: fix typos in man pages

--F0LkJP3q9rAfda2tHR3dlJJjEWahhw1vJ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Alexander Blesius <alexander+git@blesius.eu>
---
 Documentation/git-worktree.txt  | 4 ++--
 Documentation/gitattributes.txt | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.=
txt
index cb86318f3e..fa5ec7a5dc 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -213,8 +213,8 @@ refs of one working tree from another.
  In general, all pseudo refs are per working tree and all refs starting
 with "refs/" are shared. Pseudo refs are ones like HEAD which are
-directly under GIT_DIR instead of inside GIT_DIR/refs. There are one
-exception to this: refs inside refs/bisect and refs/worktree is not
+directly under GIT_DIR instead of inside GIT_DIR/refs. There is one
+exception to this: refs inside refs/bisect and refs/worktree are not
 shared.
  Refs that are per working tree can still be accessed from another
diff --git a/Documentation/gitattributes.txt
b/Documentation/gitattributes.txt
index 9b41f81c06..908d9a3009 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -314,8 +314,8 @@ stored as UTF-8 internally. A client without
`working-tree-encoding`
 support will checkout `foo.ps1` as UTF-8 encoded file. This will
 typically cause trouble for the users of this file.
 +
-If a Git client, that does not support the `working-tree-encoding`
-attribute, adds a new file `bar.ps1`, then `bar.ps1` will be
+If a Git client that does not support the `working-tree-encoding`
+attribute adds a new file `bar.ps1`, then `bar.ps1` will be
 stored "as-is" internally (in this example probably as UTF-16).
 A client with `working-tree-encoding` support will interpret the
 internal contents as UTF-8 and try to convert it to UTF-16 on checkout.
--=20
2.21.0





--F0LkJP3q9rAfda2tHR3dlJJjEWahhw1vJ--

--Pe2WcxZdUgmEflfqfWwl6zSRcGITyNixj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEeKbtWWINxpqa7GJ7r0HG3q8DMW4FAlyM0UAACgkQr0HG3q8D
MW7u4gf9GMd3IAs/v+uicqKNjV0m7UqoZT5Z2phdC3nImuID3VS8R7xz2E818kGB
Z6nGFeYyCL0ftj3VqoFKHIuZpK8RTqaAD59DV7jqRZUb86SObarGBbQ6bXMIdJ9n
MylvEvZcD75k0RiO/19L3NltCsngQVU/RIGXSadMUk4mY/FcQ9djsmCbyXJCNCxq
wCWAoO3ajHNefg4qed479sVTePUbFprbVNlf3xagXBj/q2Dqgm1KqKVa5c5+jsU8
znyXQt7/vjm72zWEOGCKBLO1R5AtRO64jw6YXfV1akVSSQ3eX63oVZsRaOoB5nQq
NNhdsFxD/yuYXr2pwakFP7fo7PVeIQ==
=/Ym3
-----END PGP SIGNATURE-----

--Pe2WcxZdUgmEflfqfWwl6zSRcGITyNixj--
