Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8ECC07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 22:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiI0WtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiI0WtC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 18:49:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F9EB56FF
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664318938;
        bh=w+lwbr6LiXrpPrrRbv22V4Xl9jdJ7R1OrocOjvyg5sw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Sh/BqD+eQguNt6Wk5DYO4T6ZWB2dXuNC95d5EXhoWoQCaR9A5z2NoDutF+pnsBxZn
         MVnlHEfhrGm6xezzA6UvJLvnevvZVtTRRMB5YGoVu/MgGvPjywQSnuoi6w2oZqAJ+l
         65jNCR0p8tz87z3fV7SLORpyPOY+qKqHL3Y5fWOY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az71-629.54gadnqkfkfezo4rfhga4mummb.dx.internal.cloudapp.net
 ([20.237.228.24]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MeCpb-1pCuz70iBj-00bIz6; Wed, 28 Sep 2022 00:48:58 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.38.0-rc2
Date:   Tue, 27 Sep 2022 22:48:54 +0000
Message-Id: <20220927224855.4682-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:sZANF5ClhemX/Q0bP+eupFmh5akgL0zpbAxzzvEKgH51qBlhB+G
 Cw1/oslRfaLV3Sl2846gafVexXczfGm5zBG/+QP83sOnbZApzB/EiHPt07jAdfyQMc7RH0w
 dlujpsvyjDGK5atf9pkzXETUy9ANiwvP80+udTvi8gu0ckLkQ6ehV5AqELoG65Knmh59+8+
 ZibiNUo7/rcyxC7kX9XJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kZMGHSZJuiI=:qrl5NqrlrWSOAztLqVnDx5
 ElZzi2korn8W0om8Q+8PxMu9Tw23x2lG051I/e1NM8gL583fVTxUUGsSXFywCPvPb8iW2Ra3C
 8g0JsmsX6ZeGBSbZ36HF6St3rmaA1U6s4pFoemWiRJdYVjCLldg9OLHejsrwTqx9Dw4VVv6M0
 BUiTL7UL+0j5ewPbNdpAddWug3c2CCYVMIC0Z28nFVhjp5s1DBLeDxKfmT50VlL9qgM7FvIcB
 5hUsqqQZOWOcdM9K/5VWr1BBv8I5HhmVrX9XNUcGiTMLmxV2pm/Y2vaCB20PF7mRYWydRRtyH
 AFzzk6z8u9fYlnPDaUcf+NXAIyjtmr8Hudp9jhErRs+c0xzyk0CZ+ArHeos8X/AtdqrH64Zay
 H23kOkKoiU/FnJZUhnHDQLKNsoKjPvIWBkBwjkk5V/u0sUjRleilBpAukYCqrDn925BOwdfMg
 lvAWKP8R+aCZmQB1RoHafjAAONK75JdlqkPduovO/2a8Iwej84agv3Lm50QWOT9KIcOB8SNi+
 lPRr0pidrtrjHx5cPagR2TUNe4YDp/aMrfD3tGoF09utdJRCnnq1tgGC01DyixDx+Dm3O9aG2
 BCPR96UsVolptmLu2XO16ZTqQ6gP1lMYB/cvDte+biOng3IJu8gL956zxdEstR9uzUrwi6lmh
 7ed4ICDa7/TFNrRO9YRCDR4SMjx0gf7wKtf5bQO0N7W9ZaJtSBUwYH5J2e9xRCXiq6urwsljr
 j7bcuPN7Px+HrqzmQ/yBGrpEQnN10i1vNBUhGj/hH+NGuhrWdegYEcFFmijxTX43NOKls1jQ3
 bst3oArJKFx/Wg7+QIkXUJX+i3GN86htjJ40rN/OwCzq1ObN/m+QhnkyMm3OWh3aO2oMqH7eR
 q14AhNvahgluOmWoYSmhGsKh6S3kORbNPgYY8qm4Kwc2JBfI4haMSZGK/6vxieNFNSDGm3XQA
 JBhzw/faYBHlHar5FHG7T9xzyncRc6V3/6zB9EytfJkrduGOjdI832KB2+ar5/fM8Dp9JEQXP
 aRgcBvRbadiWA2OG2z5jRn7N/LancTMS2GbeD7vGb1HZUEql905U8hCHlVNcJtqm7XG58EEzf
 KFdwPscOmASUsT0sZd2P43pTt4RpcOHewec2BmxmvNsu6KDwVcrNFWeNhjA0esNrXELIbAVay
 faSkcghU+LoAczDdR568Z8XBBv
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.38.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.38.0-rc2.windows.1

Changes since Git for Windows v2.37.3 (August 30th 2022)

New Features

  * Comes with Git v2.38.0-rc2.
  * Comes with cURL v7.85.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.3.6.
  * Comes with BusyBox v1.34.0.19688.985b51cf7.
  * The scalar command is now included. Scalar is a helper to
    automatically configure your (large) Git repositories to take
    advantage of the latest and greatest features. Note: If you work
    with repositories hosted on Azure Repos, use Microsoft's fork of
    Git for the best user experience.

Git-2.38.0-rc2-64-bit.exe | 0119ba61071b45fb6e6c647473192c1513db568e43310cba8150e842cc526ef9
Git-2.38.0-rc2-32-bit.exe | cd5735be6047512cd3d52fcc7d152930d28c6e1d89245273d4cf1594e03c2211
PortableGit-2.38.0-rc2-64-bit.7z.exe | 5abe7fbcf30d028f9cfbc0bb9bdf418f04afe06f2131cca5bc5ca5b8823d8c5b
PortableGit-2.38.0-rc2-32-bit.7z.exe | 718b21123565d4bd0676ffd8bf74a5ef736b12e489c600d37285fada29b30e0e
MinGit-2.38.0-rc2-64-bit.zip | c9005c8c48c30d93aaa2d401d2902bdce5cdebd1bb21f3207dac6d3cf5fff913
MinGit-2.38.0-rc2-32-bit.zip | ace20517a2cd2e7940e79438c439010cb43ba95bd0170facd8bd72148e20f1ff
MinGit-2.38.0-rc2-busybox-64-bit.zip | 64e5cac970b6b08ce10237fffce1a666fae46ab87896032ee996c6f3b6c94710
MinGit-2.38.0-rc2-busybox-32-bit.zip | 659c0d517dc312e42ccd3941c59e61989003173706ba13fbf9d11a02537f9a4d
Git-2.38.0-rc2-64-bit.tar.bz2 | f12622455408dc4febf8b7c8666ac7a30c0794697e13f71bd6c3df227aa1e22c
Git-2.38.0-rc2-32-bit.tar.bz2 | 86388c90c6eaf46ea420d5969ef2d3c08b4bed3629136904daf0a129ab91cbf9

Ciao,
Johannes
