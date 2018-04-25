Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFEA31F404
	for <e@80x24.org>; Wed, 25 Apr 2018 09:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeDYJyp (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 05:54:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:51203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751980AbeDYJyk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 05:54:40 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MRB8F-1eoz1o40lj-00UWc2; Wed, 25 Apr 2018 11:54:36 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v5 09/11] technical/shallow: stop referring to grafts
Date:   Wed, 25 Apr 2018 11:54:34 +0200
Message-Id: <a3403a69b692e4f4b0337800268a16818e790caa.1524650029.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524650028.git.johannes.schindelin@gmx.de>
References: <cover.1524303776.git.johannes.schindelin@gmx.de> <cover.1524650028.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:xR763jcqTR/O7DiIKLjMsbigVAxKsxpeb8iYHdo7X8fZ8v7W7xC
 VmbFF5rxqNC4lBoYAn50syAKFdM4N6gK/uJqYl+3qFYy5H5g2HX9hnf0pWdp2b5NjdHeLYM
 zT1qfipBeGc6UDRsEieo5x6ZQpQuEOP3F9dco45FZTOC6VU5avAl0/aM/Cgtds87BHsjAEa
 IqS4H7fF/7PrTGXHsvydg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4V692slUYtY=:DgW0LjX4qqWl2K45oKDFu9
 MK+131RaOJ+xFYwXr3ZqoVeIUaOAT6TW2K96Ycq9pjWGPUeVsw3I0/et2DddOu4nfIwKJznV5
 v0/LhtYEENZZkgmiyQr/wSpyWNtX4eFkdnyPr5/WxOi1jST3rnuBgzTPzcrdEDm4R4JdsceAh
 NWMdC7JYHwgz/5x/E86vsH3bd22kk03SqsZesc14Waj5so/ap2Tz75CCBfpnfmAP67Ez/IVcS
 sE3W40lOz0AQFa7WbuAWlcJGk5At3zN3keeiwRFZGnWOu3Ol/4Yo6Mp4F7wfYBO8WyBPSG+NR
 2KXh8+KIbJXnV/6ZYSVH7P7UZTQA5Fk0SizEU97+HgZtO1doPbN3vHLXFuCCaffhNeAUgAOQF
 2U0L6o+ZoNdr3JtzQbEVaqL/trmW+dpwh8MW0fK6MkzaYgc0TkorOufHqxPW762q2obMLHtFJ
 urgLiil3GYKexuOMF5lmJwD2FY++gb4ReONyvNOJh1DOrSGtRDSB3dqYL0+OmjusAmrfJScqq
 zKjo4hSY9NeQV7i7tHXSR1K5R1F6N7PxHEKx+8BnQqqHspUopcl/N5zEEhfAhS0ibrA2m4Xnr
 Kl3f2xo3XZC9k3RMbP0S+BtPYpm5LHBlD6sZcgc5Mfasjpdccwxq9Rw3LkBSxjZnD/AHpF+WW
 HEFnC84B0f6mNc0KOj5ak5gp/tEr3bUzN/ZrpUbsJSzVw42w9+5KULTR4usmejcWR0YN2KOvI
 r4qF0HSOiuVzxQhOWVlj3UUmn66XTnbuj0HizpvAKqZkzrpEiNZb61TCfbq7JKToCjBdqeJzG
 4jak0qce6bSMZ/7PZqK9ZWueQRFt0m5yjStrjyDP4qlquFVldo46FOD9T9AclozG+D6fdZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that grafts are deprecated, we should start to assume that readers
have no idea what grafts are. So it makes more sense to make the
description of the "shallow" feature stand on its own.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/shallow.txt | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index 5183b154229..4ec721335d2 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -8,15 +8,10 @@ repo, and therefore grafts are introduced pretending that
 these commits have no parents.
 *********************************************************
 
-The basic idea is to write the SHA-1s of shallow commits into
-$GIT_DIR/shallow, and handle its contents like the contents
-of $GIT_DIR/info/grafts (with the difference that shallow
-cannot contain parent information).
-
-This information is stored in a new file instead of grafts, or
-even the config, since the user should not touch that file
-at all (even throughout development of the shallow clone, it
-was never manually edited!).
+$GIT_DIR/shallow lists commit object names and tells Git to
+pretend as if they are root commits (e.g. "git log" traversal
+stops after showing them; "git fsck" does not complain saying
+the commits listed on their "parent" lines do not exist).
 
 Each line contains exactly one SHA-1. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
-- 
2.17.0.windows.1.33.gfcbb1fa0445


