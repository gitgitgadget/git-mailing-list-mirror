Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11EC31F404
	for <e@80x24.org>; Fri, 20 Apr 2018 22:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeDTW1X (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 18:27:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:34935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752489AbeDTW1W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 18:27:22 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJSuF-1f7Aas3k1j-0038fO; Sat, 21
 Apr 2018 00:27:18 +0200
Date:   Sat, 21 Apr 2018 00:27:02 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 11/11] Remove obsolete script to convert grafts to replace
 refs
In-Reply-To: <cover.1524262793.git.johannes.schindelin@gmx.de>
Message-ID: <6c351dbd2391715a2737533af41dbea846ba294c.1524262793.git.johannes.schindelin@gmx.de>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8Lqey8vn9PuydcfQLV0EPBlHm9LSyC/BKsxtiro02uaJGaMaJKd
 XTb/YbGHktTmnKhImr8l6j1VZ50WqnGMerX9nOTyeKetKJf0+bMOzf5kMIcRWTuZEuE1VLT
 dANAGqDMMztPEsXCpg14UTIQdCY4borXN+HiS8RA9r4MEzvZ5Jys8OAtfYO+HUeX9JWPmim
 rOx6KcQ8OYJlJqGWoRnRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G0AIzW0T7yk=:XaLwFuzzfLmkM/FAE6bNmn
 tAgkR+yZF4DUQo2X1Q2E2TpZ9mq2q4Rprzg+LGc9qkyNXCtPJX3o6bei4skWK07oUfxUpbohj
 yAu2Ym5Tiwi2CqsH/sHT3qhkPD1sU2E0qbf5jA4k0gwj5ZqXZt2REUcZ7xWfMWyq5TXPG0nGq
 lAFkL0YC/SfNthX3vjjpQ+ZOidYuFzeDhMGtIYF72e9gDvLO3ufXt/Glh/kCVZBNvCj7E76ha
 UFMg8s6WRirIS3jXiknvoLPBn0cynqXXJ5K4DAxY5AYknDGQjwj6G6sy1MgfdnDvLeuwDesTO
 02GQI+OM/ADA81zlW9B53ErkDu5q7J+kGtikeYbRCQWI+dN8M6HHp4R8sQq1dPYd+7n2KnsVn
 FXehZHiognnP2JRxmNnrXh6VgWIIGIibuI2ucdgACeeujm/I4aGaDFWAnjaLIOlfFzCke9wPM
 LxnOXwXErvLHm/OfmdHHcOBeSPZM+DKOM5wag52SWiRZLtheXwQcJdPbgSeWOWKPCIVcKR36Y
 EDhHWgF8BnQdCf3U50eoj5eQZ7kBO+zlW3laT2/GqQsXezISYRTZ97pZvUOsbnYnC4pJXsx6n
 z9fz8wSlxSm+psDRihb4wNULKFimc5UIZQSDH1Dk5Ltm45IYOB7E4nQ5N0onWuXgur23yOexz
 +Oq/bWZAhxFeA+KjRXlWXdQwjo/BBFNLC5K5M1hV+z4jWLfdbknJ4LC3G+taSYyH/VLxIDOde
 zGeSut7zhxVu1NEwtPMJjj6paSfpP2MeAJkqza9akEMkZZXB7PVQl9CfTtRuMKv3CqZML6dCG
 HjJbrZFmxA9HVthxcZeUSyXCpNbiYTiqayjM2taFJvFSdaKg58=
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
2.17.0.windows.1.15.gaa56ade3205
