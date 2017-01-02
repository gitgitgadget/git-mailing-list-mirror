Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07199205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 16:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756242AbdABQEK (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 11:04:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:50236 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756185AbdABQEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 11:04:09 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgqQQ-1ctWLx2tKI-00oDbT; Mon, 02
 Jan 2017 17:04:00 +0100
Date:   Mon, 2 Jan 2017 17:03:57 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     =?UTF-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] asciidoctor: fix user-manual to be built by
 `asciidoctor`
In-Reply-To: <cover.1483373021.git.johannes.schindelin@gmx.de>
Message-ID: <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de>
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-705827979-1483373039=:3469"
X-Provags-ID: V03:K0:xNpE9w2sMYX384qsfN2IPuTmHgomeYbARoByzEPsZHqJ5c22Dph
 WHRQq31m0Ya6rpaw8qZrKsZ3sNs2K3Voh8q9SNPmH5yc2QXsGr1VhLw1n6YVY8oDk0mSwW2
 KdTQ75M4oHC/RDLUOT/1DwQjmPYnv98zGTlhpqD6A9jrW1Lbvzcb3nzgAAghotlKxezd7cy
 9XELOrAGE5aMQxYtoIO6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NHkdGMvx8B0=:ZQmWMiHUJfvgI6+L77H7Ap
 EpqilVBf8lV2IvEC987pu0KOzqzDo7enJwa7/y6y8y+SyHBtPrbWJYWev1MGSZCqJ8X2FLb0Q
 NYREA9W9qvyqZS0SG/ItsXNKQNDuNKqrXtGU6VTF2acvFl6zTg0i63ygUarbmAo88+h5KvZR0
 6h9sxoQs00APzscVqESSYeZqhvgTSXtDHbB3dT9lS/0/ARJ9XkDEur7MxkyYaJf+aOnZHM1fe
 02VRG00Fcz6QWcA6EyG4vTv/y3ZOaLyXbwtq5OrngkWBmuqr3EOPJXVF3DrkPYPB5Giw3oy8g
 s9BXIClCArp4i0W5A4RN2Lf0mkIjOLaGx+j4/4jbNm5+RQV00B6Cmrd5lpDPJUDMHXRWcNERR
 xZ6yFWOUz/YUa2QJE+8CphzX6bT+XWmABa1VA3dT9JR9Gm/8So0wQy64PwMvHuGI2+PTmUxRK
 FWHBeer+lXro1RGNVj57eJp/YVNCcMHBJG9CVZO834uiVJ0W8/O0tROWsHX7b+WAqe5LQwLeN
 TgX96E2W2PLoseb7m7r+b/CfHRL/xQ4m01I/rCR38F29SgW7vFaKld9/4AnVGk55bURFI0Ej2
 LeUEKrxYx20qRKiqV/58fUJh9isFvfNSU9iLxUtRZMsT/KooqzrC7c7LCE8kPcHLnxWc6Jd4L
 rqX1Bwb1v7iPLyW8kcFDCJ0pjJiAvon+kbTxKUfWvP6xXh6mzj1BxoVMV8lMP7IDUPDPUSJHN
 TmVDj23PyzSJshjWGIJH07B4cPwfMZa8VdcIiSv5wYbZJoUs/BuwwWHx4sF8gOxr9u95oNU0V
 OugefnU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-705827979-1483373039=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

From: =3D?UTF-8?q?=3DEB=3DA7=3D88=3DEB=3D88=3D84=3DEC=3D97=3D98?=3D <nalla@=
hamal.uberspace.de>

The `user-manual.txt` is designed as a `book` but the `Makefile` wants
to build it as an `article`. This seems to be a problem when building
the documentation with `asciidoctor`. Furthermore the parts *Git
Glossary* and *Appendix B* had no subsections which is not allowed when
building with `asciidoctor`. So lets add a *dummy* section.

Signed-off-by: =EB=A7=88=EB=88=84=EC=97=98 <nalla@hamal.uberspace.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/Makefile        | 2 +-
 Documentation/user-manual.txt | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b43d66eae6..a9fb497b83 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -337,7 +337,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
=20
 user-manual.xml: user-manual.txt user-manual.conf
 =09$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-=09$(TXT_TO_XML) -d article -o $@+ $< && \
+=09$(TXT_TO_XML) -d book -o $@+ $< && \
 =09mv $@+ $@
=20
 technical/api-index.txt: technical/api-index-skel.txt \
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 5e07454572..bc29298678 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4395,6 +4395,10 @@ itself!
 Git Glossary
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
+[[git-explained]]
+Git explained
+-------------
+
 include::glossary-content.txt[]
=20
 [[git-quick-start]]
@@ -4636,6 +4640,10 @@ $ git gc
 Appendix B: Notes and todo list for this manual
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
+[[todo-list]]
+Todo list
+---------
+
 This is a work in progress.
=20
 The basic requirements:
--=20
2.11.0.rc3.windows.1


--8323329-705827979-1483373039=:3469--
