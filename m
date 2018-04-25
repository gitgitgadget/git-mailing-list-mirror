Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3F01F404
	for <e@80x24.org>; Wed, 25 Apr 2018 09:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeDYJyz (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 05:54:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:34357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752086AbeDYJyu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 05:54:50 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MC8iq-1f2Vgz17Oy-008oof; Wed, 25 Apr 2018 11:54:45 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v5 11/11] Remove obsolete script to convert grafts to replace refs
Date:   Wed, 25 Apr 2018 11:54:44 +0200
Message-Id: <aa5b64805fdb188bfdca5193ee01c081d9917634.1524650029.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524650028.git.johannes.schindelin@gmx.de>
References: <cover.1524303776.git.johannes.schindelin@gmx.de> <cover.1524650028.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:y1VBuSUyxCAfHPn0KrQno1nYlkjcb8n1xeY7P65RCCs0+cSRGlW
 dcfY1Y1gzc7Sknfbl/ONjVD54bY1ZlSjOtjSFR7uu6umjbbsR7Cdh+HA9KNeDS4UF1jZflT
 QJl5xffj/e+bX1X1WtrpuYgPO4ITb5ZMN5vrrQfNuMjDvARqiT92rbXZycYEBv/tr/nZ12B
 50rRgsfVmeynqoDb86sAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:574km6SC8fc=:e2H7P6bnDoJ/JfRcuNfzEw
 Mfe3d360fSMvtU4QExFhJBcZb60n5a7iJZALuoG7q1BJNJofnYqI3LhxHguXUVTLpof7fAEhd
 q3stJ169pM56MCMqTSMbcVBH1HjUM2/2CvFBE/IFBRrIu5tGBinjeqR8tGcfFVyeFf6yCEwUY
 2lchH8qq7Bgh5zrBufg3z5dQpHIEhzB/RcB1AxKALHzwFGbmbckWP5Zz576cwf7E1oqWCv8O5
 SzHWlOW/0BJTJnhOcdLuRW+aTH67Lon2omdg+mwdkqVVVD9JTYtCx/YmMWtD12Xz/kK4hEGv1
 kB2PhXpfFSBG7xuM9iVG1ZUrBo6DhGCG8/ElziE0jAN1T3hvUIQd9V3jS24I/RDjADbmESDg4
 y2PifBxfw1ApXRovaOLr3SQmhE9jnu2mN7YxHKQKyAkdRml8tm0+7UnEPxkKmfLEKQkh5yuG1
 bUbvM9o6/YZ48+ElFbyeRaJyg0QTpG29JwtpnB4l970JN+ZYkDkuiZ9idj43yECipo73uhPOU
 Wk6pbEmPRV4sNJsYAA/sTpZhpkaFOdrWEhIKfcwmL/YuuzjP4HEJxTwKgK0ydv/BcEc8JJM6n
 qtntvqVGx1gVniDv2g891I8CGlM0UntZBawl/L5jcO4t1P418Ho4uZIEceBL42s2OyOVrnYOd
 7BwchrxXiTDDYCUEfkTh6L993j9Sp4Vf+rfyulGwf4wfdwkS4uHJY4eM5I3nvtTX3QWlwTjLV
 Ybz7bfg+opXOT/91sLbAsR23P6eVV7vwzpiVeRlZu7O0arBA9GxIDD/CHIQhGCJRfYX913Pa6
 5EvaGHDcWEbPb38EhYgxKGJGHmQnzHGI22r+dBf8c4dJfobUfLJa20tIYElNjcqRqCA6Qw4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The functionality is now implemented as `git replace
--convert-graft-file`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/convert-grafts-to-replace-refs.sh | 28 -----------------------
 1 file changed, 28 deletions(-)
 delete mode 100755 contrib/convert-grafts-to-replace-refs.sh

diff --git a/contrib/convert-grafts-to-replace-refs.sh b/contrib/convert-grafts-to-replace-refs.sh
deleted file mode 100755
index 0cbc917b8cf..00000000000
--- a/contrib/convert-grafts-to-replace-refs.sh
+++ /dev/null
@@ -1,28 +0,0 @@
-#!/bin/sh
-
-# You should execute this script in the repository where you
-# want to convert grafts to replace refs.
-
-GRAFTS_FILE="${GIT_DIR:-.git}/info/grafts"
-
-. $(git --exec-path)/git-sh-setup
-
-test -f "$GRAFTS_FILE" || die "Could not find graft file: '$GRAFTS_FILE'"
-
-grep '^[^# ]' "$GRAFTS_FILE" |
-while read definition
-do
-	if test -n "$definition"
-	then
-		echo "Converting: $definition"
-		git replace --graft $definition ||
-			die "Conversion failed for: $definition"
-	fi
-done
-
-mv "$GRAFTS_FILE" "$GRAFTS_FILE.bak" ||
-	die "Could not rename '$GRAFTS_FILE' to '$GRAFTS_FILE.bak'"
-
-echo "Success!"
-echo "All the grafts in '$GRAFTS_FILE' have been converted to replace refs!"
-echo "The grafts file '$GRAFTS_FILE' has been renamed: '$GRAFTS_FILE.bak'"
-- 
2.17.0.windows.1.33.gfcbb1fa0445
