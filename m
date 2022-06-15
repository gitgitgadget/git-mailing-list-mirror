Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4807C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 09:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345362AbiFOJki (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 05:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346319AbiFOJkd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 05:40:33 -0400
Received: from forward106p.mail.yandex.net (forward106p.mail.yandex.net [77.88.28.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0FC3E5F5
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 02:40:29 -0700 (PDT)
Received: from myt6-61e9e731de9c.qloud-c.yandex.net (myt6-61e9e731de9c.qloud-c.yandex.net [IPv6:2a02:6b8:c12:4ca0:0:640:61e9:e731])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 70B5F2FC1E2D
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 12:40:27 +0300 (MSK)
Received: from myt5-aad1beefab42.qloud-c.yandex.net (myt5-aad1beefab42.qloud-c.yandex.net [2a02:6b8:c12:128:0:640:aad1:beef])
        by myt6-61e9e731de9c.qloud-c.yandex.net (mxback/Yandex) with ESMTP id xilLtFMBUX-eRfeKFoL;
        Wed, 15 Jun 2022 12:40:27 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1655286027;
        bh=3uNkWGJuBs1P0E/cCCEHkI4GnDlZec4BBsJx1zH6Vs0=;
        h=Subject:To:From:Date:Message-ID;
        b=ubUIGAmQy8DP1sFj4x+lRZsj3kkJ5F4fVxg4/7pYIyXZ7kCPH5cbB/jJ8n6a9gffM
         IATPBY4v/Fw3MHYiBTsGdPs5zS+712Llft+CYM2pSs3AKcCNe+J7ZjZnq6Y3xtAO2Z
         hK2wSLzzo6P+8+h9rjKGqvLROHhw8jWuyT8ebI5c=
Authentication-Results: myt6-61e9e731de9c.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-aad1beefab42.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id cWhOTwfAKV-eQM0m4PH;
        Wed, 15 Jun 2022 12:40:27 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Wed, 15 Jun 2022 11:40:25 +0200
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <1217705990.20220615114025@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Not every patch displayed
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,

I am curious why 'Rebasing (113/113)' was not displayed?
git version 2.36.1


git pull -v --rebase=3Dmerges origin ekonkov/chim-580/try-latest-perl
From=20hub:/UK2group/Chimera
 * branch                  ekonkov/chim-580/try-latest-perl -> FETCH_HEAD
 =3D [up to date]            ekonkov/chim-580/try-latest-perl -> origin/eko=
nkov/chim-580/try-latest-perl
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.
Changes from 95b0edb3a74e074dabe06ef41b2b1049e989bf6f to 1f39d7a2c8491e5f9a=
2021df90ac37ad56e1fc33:
 cpanfile                                                            |  4 +=
+--
 lib/our/way/dumper.pm                                               |  6 +=
++++-
 perl_version                                                        |  2 +-
 t/unit/test/Chimera/UnitTest/Objects/Doc/Tree/MergeOutput.pm        | 14 +=
+++++++------
 t/unit/test/Chimera/UnitTest/Objects/Logger/Rich/Document/Metric.pm | 14 +=
++-----------
 5 files changed, 19 insertions(+), 21 deletions(-)
warning: skipped previously applied commit a4e73c147a
warning: skipped previously applied commit a6d8ae7dd4
warning: skipped previously applied commit 075de700e3
warning: skipped previously applied commit 2ca90839a0
warning: skipped previously applied commit b2622d33d5
warning: skipped previously applied commit a8f367568b
hint: use --reapply-cherry-picks to include skipped commits
hint: Disable this message with "git config advice.skippedCherryPicks false"
Rebasing (1/113)
Rebasing (2/113)
Rebasing (3/113)
Rebasing (4/113)
Rebasing (5/113)
Rebasing (6/113)
Rebasing (7/113)
Rebasing (8/113)
Rebasing (9/113)
Rebasing (10/113)
Rebasing (11/113)
Rebasing (12/113)
Rebasing (13/113)
Rebasing (14/113)
Rebasing (15/113)
Rebasing (16/113)
Rebasing (17/113)
Rebasing (18/113)
Rebasing (19/113)
Rebasing (20/113)
Rebasing (21/113)
Rebasing (22/113)
Rebasing (23/113)
Rebasing (24/113)
Rebasing (25/113)
Rebasing (26/113)
Rebasing (27/113)
Rebasing (28/113)
Rebasing (29/113)
Rebasing (30/113)
Rebasing (31/113)
Rebasing (32/113)
Rebasing (33/113)
Rebasing (34/113)
Rebasing (35/113)
Rebasing (36/113)
Rebasing (37/113)
Rebasing (38/113)
Rebasing (39/113)
Rebasing (40/113)
Rebasing (41/113)
Rebasing (42/113)
Rebasing (43/113)
Rebasing (44/113)
Rebasing (45/113)
Rebasing (46/113)
Rebasing (47/113)
Rebasing (48/113)
Rebasing (49/113)
Rebasing (50/113)
Rebasing (51/113)
Rebasing (52/113)
Rebasing (53/113)
Rebasing (54/113)
Rebasing (55/113)
Rebasing (56/113)
Rebasing (57/113)
Rebasing (58/113)
Rebasing (59/113)
Rebasing (60/113)
Rebasing (61/113)
Rebasing (62/113)
Rebasing (63/113)
Rebasing (64/113)
Rebasing (65/113)
Rebasing (66/113)
Rebasing (67/113)
Rebasing (68/113)
Rebasing (69/113)
Rebasing (70/113)
Rebasing (71/113)
Rebasing (72/113)
Rebasing (73/113)
Rebasing (74/113)
Rebasing (75/113)
Rebasing (76/113)
Rebasing (77/113)
Rebasing (78/113)
Rebasing (79/113)
Rebasing (80/113)
Rebasing (81/113)
Rebasing (82/113)
Rebasing (83/113)
Rebasing (84/113)
Rebasing (85/113)
Rebasing (86/113)
Rebasing (87/113)
Rebasing (88/113)
Rebasing (89/113)
Rebasing (90/113)
Rebasing (91/113)
Rebasing (92/113)
Rebasing (93/113)
Rebasing (94/113)
Rebasing (95/113)
Rebasing (96/113)
Rebasing (97/113)
Rebasing (98/113)
Rebasing (99/113)
Rebasing (100/113)
Rebasing (101/113)
Rebasing (102/113)
Rebasing (103/113)
Rebasing (104/113)
Rebasing (105/113)
Rebasing (106/113)
Rebasing (107/113)
Rebasing (108/113)
Rebasing (109/113)
Rebasing (110/113)
Rebasing (111/113)
Rebasing (112/113)
Successfully rebased and updated refs/heads/ekonkov/chim-xxx/improve-deploy=
ment-and-testing-process.


--
Best regards,
Eugen Konkov 

