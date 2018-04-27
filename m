Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 690371F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759378AbeD0VlF (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:41:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:56595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759343AbeD0VlE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:41:04 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MSHax-1enFh90J4d-00TSe7; Fri, 27 Apr 2018 23:41:00 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v6 11/11] Remove obsolete script to convert grafts to replace refs
Date:   Fri, 27 Apr 2018 23:40:54 +0200
Message-Id: <b321979f88589e7b006466159c470800db948d66.1524865158.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524865158.git.johannes.schindelin@gmx.de>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:7XYLFY3YdjyGRu/jQJdxuV46h8RkchyHi6/Obr2FxKfg6hCRlh/
 vji40xtHK6/1ODwY+tPgUFasoHQebWxualQD1Nb4CAUpmY7jASPpZQBlhJnMgOX9xTKdKzX
 ESLebHtXTf9Yq916rSdrVA3FDkRwd6nzy9topv9qngLVvWvQ+IarjQgGPssExrYZkDbQRul
 c7Hgi+gR3ueNYc9+V809g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WhLqA8LnksY=:Kp+CfD1STdTA9lT+aa5QcT
 zLTu/N2Qhj8G/8sels9cX1cazlQqQCB6KDwecPgBIJyD6pat1nXloumHuBwAJEHt4aVSgZWPM
 x3FZ+r0rMp+hOGvwiEJAdMWWf4OE1UX0HvG1WU3cX/urAeNOkwr2708/4Sq0YbELFvEFx7dht
 gSgxCUDk8Od2WlgHXd7J4w7YdfVf/QUXlhMsxm6AvTKjxLgMsHujLBocjvBm0yb1s8pD4etiM
 7+MoMAmyYcUsy5o2Ht7f8ZlUpYfPi/67AB7/X6ma2ZYTMkYa6WumnDyQXpi5ME7Zh3ownQvuM
 N5mrG0ycvQZHpngCnANw8exh+42BX3MvlnIWPLjyTjXMJLE0RlXD5sd6SaLTV5V4mt9k0FrzW
 RX3dpk/MJZFk+37uR5FIgZ/q/vql8IzjzG5JEavOE+p0nDPyNGrioquMA74CrP1hOyyzMTdCk
 oD5J9OdM+5+nckkPftOH02IpT55HGlg8dSwprhIffLmfwWti1mLyE/BvXA6T3zIc+LV/7fA/H
 peOBhtwvvD+gNXihugFknbcWdd4dskgtbnv1DYYGR7ps75z3laCROIWx8EPNdCGOdAIZJITn1
 B+lfihciPbm/X99a6iJPnNGueS0zLm+m5IyUc0eejqrcovl5Zo86TrZYcXu3xrtdlkxxpHYyd
 VnEyU296LViNKNULLWywgRKoVTm8VRPNkOf8eBfGCuN2rc7vVAKqOoTvNmEH+iSQU6gt7IGEH
 wWCFhRyprw7YlJlgTXtISsk94tGICV7g12DKEGb0gPlybgPEGEcMHApogrLxXL/1gew9ykuVt
 f/DHDQG
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
