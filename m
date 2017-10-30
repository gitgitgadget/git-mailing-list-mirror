Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C341FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932633AbdJ3RU6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:20:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:62110 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932252AbdJ3RU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:20:56 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzpWx-1d4Tzm0Ge3-014zzT; Mon, 30
 Oct 2017 18:20:41 +0100
Date:   Mon, 30 Oct 2017 18:20:12 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     =?UTF-8?Q?Jakub_Bere=C5=BCa=C5=84ski?= <kuba@berezanscy.pl>,
        Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] t0302: check helper can handle empty credentials
In-Reply-To: <cover.1509383993.git.johannes.schindelin@gmx.de>
Message-ID: <e055913ec27fc3feb3f017747560f454f6817a0b.1509383993.git.johannes.schindelin@gmx.de>
References: <cover.1509383993.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1151495086-1509384041=:6482"
X-Provags-ID: V03:K0:YTZQ1IgOUZr6eTsaDa3H0lOw0j/4MtODqoVniyHQEeNzwGByXFl
 XR3LlDqsL+KslLU42s5hyZWyYt0aT+rGcUq6fKn5X/SH2WjADbo28CFSdZ2783L0lNUiJSg
 /uy+9ocYZaPcoyc41pPEVUavZ/ho5C2fIGu6npf6nP8c05Hr7u5y2SelZVM5w4WUngEILGk
 pNl8nJp0QChWqbr9h1sCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BQrE4UDSM88=:dJM/p5XXhZWXrfj41ds5gd
 fjdPrZlKnRAmQog9b3nI9ecbbrstREHlIeaLsUYTDxywtPREMGApk4G/1TexR0Pc4DLhhAsyV
 cBaUKptwgza88Dk6V1h1EbcjV8zugZby4F4d0BgBuHxGbObZrBZX4aNQfSlP+yic2w0Jce6L8
 OZolFhi+ispGS1TvPZYUQkfTn6yN7h3JFimBIOrMFv3ROSFFe2cW4XkT3i9huD7HuFjbXOb2p
 /pJG6nzbMAPW0UyQwgijgckrWPFSsQdqU5iYIIiM8M+Mx8IZkdoi3NG4ZmhYANxDbzsqPvutP
 RKAsEklWhTehxWa+nUQjpOzz6X7b8q+Bg6XmxzaqtdyUVoLqV1t+GVlztEEXTT8dxKatPIASq
 obiKtGlFkwcFmC6BL2tMZAW7Kk3LWjYd766zAMB3zjVhHOuQsmX0P3RwqYnJ6WCdEdvY5cht5
 U+eEa/9+L0ktgBYWzQdUgUaQIAnWutFeJFIJkUYVn8cETSyPS2uWNw7wuA99lP1BsRYhEeOEn
 YCJ2lc0+28i+KpMfLSA3UZdjIpn8Qb8TxEHsshl9WjkPwzr8kcZa0o3SiFvbLLzGHfIovtXjc
 m+UIB/ZJ62scofPgyixX0krTumhb6YWCrSs2lieqDVYiOrRsPoH3eLFtteItiX2NHf8n8QEzM
 +EfzBw9ytRDvJtExDzZr+k6e4n6QLJLU79GlkO4cPNBitQUBSE8Vrye42v/2YhcwFt2JW1DvV
 EXuQE2PM/ZjjaURCFoVM2OIYoGUUb/bFlKGvZH1NnMCKfp9P5aZu+agXHl4KL+CK3M5d94dgP
 w2ty4hNsSOCeOhasVdCldWZv94LzSdB7zA3E8Gxk+Ip0OFW6Vp9IYf5cv+ExVekl2VLifV1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1151495086-1509384041=:6482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

From: =3D?UTF-8?q?Jakub=3D20Bere=3DC5=3DBCa=3DC5=3D84ski?=3D <kuba@berezans=
cy.pl>

Make sure the helper does not crash when blank username and password is
provided. If the helper can save such credentials, it should be able to
read them back.

Signed-off-by: Jakub Bere=C5=BCa=C5=84ski <kuba@berezanscy.pl>
---
 t/lib-credential.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index d8e41f7ddd1..937b831ea67 100755
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -44,6 +44,7 @@ helper_test_clean() {
 =09reject $1 https example.com user2
 =09reject $1 http path.tld user
 =09reject $1 https timeout.tld user
+=09reject $1 https sso.tld
 }
=20
 reject() {
@@ -250,6 +251,24 @@ helper_test() {
 =09=09password=3Dpass2
 =09=09EOF
 =09'
+
+=09test_expect_success "helper ($HELPER) can store empty username" '
+=09=09check approve $HELPER <<-\EOF &&
+=09=09protocol=3Dhttps
+=09=09host=3Dsso.tld
+=09=09username=3D
+=09=09password=3D
+=09=09EOF
+=09=09check fill $HELPER <<-\EOF
+=09=09protocol=3Dhttps
+=09=09host=3Dsso.tld
+=09=09--
+=09=09protocol=3Dhttps
+=09=09host=3Dsso.tld
+=09=09username=3D
+=09=09password=3D
+=09=09EOF
+=09'
 }
=20
 helper_test_timeout() {
--=20
2.15.0.windows.1


--8323329-1151495086-1509384041=:6482--
