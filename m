Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6538120248
	for <e@80x24.org>; Wed,  6 Mar 2019 05:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfCFFXQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 00:23:16 -0500
Received: from mout.web.de ([212.227.17.12]:57199 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfCFFXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 00:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1551849793;
        bh=QbK5E5TiWgksammBvj+5WAL+wLdW9jFEk82btMAYUqE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kMuDPzXWRUG8K14FLFPehBCilfg+mQeIZabr+ACWK5nuK+L505FpY8nxYnyKbS374
         5td6gQhk8seh5ChNeuG8o4ZqgFNWrnG95G1eu3Lqik/4gfIrUOA9pejgdL9chvui7I
         SlmkZRTPHtQlLtgwzx1+pVg3IMM9NVCp0jip5KBs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([195.198.252.176]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MdLo7-1giuX42aaB-00IWF3; Wed, 06 Mar 2019 06:23:13 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, ybhatambare@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/1] gitattributes.txt: fix typo
Date:   Wed,  6 Mar 2019 05:23:10 +0000
Message-Id: <20190306052310.31546-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.1.593.gc670b1f876
In-Reply-To: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rJy5yIQrW5cM/ELHw0S4h2Vc58fsI7LGcycwi8IO+ikHQz+DzIm
 7huzQY9xyoHrcGLDmSYSsdr4JcL4OYrvZa0lWyShEqx7ZQjRjutr21zFS35/3qUkxZF1VZf
 6sFbMD/6ezIfl0tIEQIm6g2DI0f6k1PSUCxuv9kTBZN+F9nJdnM935fggbgqOzAFs2iUJh1
 CqEvk4HaDmzYSqUrrpRZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OEbUy1PmMFg=:2D4oH9n6gBsUV04xxJr110
 DAwQrrSzHaaqHL1KrrXVJ5suYoyKFGwb8hIo6iVsYOciTRuMmLcNh0NPqJ4JPVDlBg+xazQD5
 MSEbOz5BhVyUglsf/vla1y91pxzeutz3FdlKZnU4eK+38AdHLHXpq3VrI2AMgyRBicOUoMMC2
 JVAR9frROuM6Kq1fUR/Q98enQQKcS19MUNMVyNRa8X8KHqAEnpLkyGcK4z4H3msseeNsRpPsZ
 hSdDjX/aMOyNyOdimGKUiwlQXOWYqvtlkQOzv/CCf1PP1sFGP6x5vrjmkK4q4w8WL4Kny/OJ0
 hV8FEf1OLEbEEbq751w3H1W3+FsUAbKujl/oWyBkxRF2bqD7UZaitATP9aeorKEY5RyEu8bot
 cpYTyowlCuo7D2p/mozJsiRKNjg/TPZTi+Gb7AZpuPpaK5fkPgHGzD84vzwRTtncmtX1TbKhT
 bfKXsSzDuH9A1NyCLaht3ksYm7Z6/7NkvqtGJqebyh02+TrN1xqHFytpIQANbBcEMKUIT0kKH
 LBY3LTKHskrFXGshJXs+Af+idbmu3v8nZ8adiL/igSQU8IV5XmTo+8V6TPa2Io0QHn8Eyxx5K
 bYh82Sa5EoIr5OproAW0BSWwfCROr8Tzs/1wQUQTocsC8Vud3c8LSnqPqqLRD4pQtA+3IQyq3
 RZrpB7FyqLVpDeEx/4iqD2oNd1B1/1Je+7HmlVBQLKBVf188OB1a2F8oI69GpN0edA9QOjk8n
 sNonXpFNBgsQWYhKoespxN5ohsYa/keR87eJqnVATMTaMVnPTC3KzK8sS2Gg3dLTDhbYiNjpx
 5HhSzwKBW9pBhwwB4vmbV+VXmUK4HGj3DpaGOvWt/UVDLy/LsKru/9vAir0FRdZAD+210nzQe
 2K+LTVedBMnqmWaHcitV/PXtelMQF5joQxvLN6FlLrPignVMyOXfTpxxNyqrdd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Yash Bhatambare <ybhatambare@gmail.com>

`UTF-16-LE-BOM` to `UTF-16LE-BOM`.

this closes https://github.com/git-for-windows/git/issues/2095

Signed-off-by: Yash Bhatambare <ybhatambare@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--

This patch already made it into Git for Windows,
so I send it upstream "as is".

Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes=
.txt
index 9b41f81c06..bdd11a2ddd 100644
=2D-- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -346,7 +346,7 @@ automatic line ending conversion based on your platfor=
m.

 Use the following attributes if your '*.ps1' files are UTF-16 little
 endian encoded without BOM and you want Git to use Windows line endings
-in the working directory (use `UTF-16-LE-BOM` instead of `UTF-16LE` if
+in the working directory (use `UTF-16LE-BOM` instead of `UTF-16LE` if
 you want UTF-16 little endian with BOM).
 Please note, it is highly recommended to
 explicitly define the line endings with `eol` if the `working-tree-encodi=
ng`
=2D-
2.19.1.593.gc670b1f876

