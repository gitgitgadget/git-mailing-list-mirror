Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E9C1F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbeD1Wp3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:45:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:56543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752307AbeD1Wp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:45:28 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LpKY5-1egmYA3as9-00fARH; Sun, 29 Apr 2018 00:45:24 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v7 12/12] Remove obsolete script to convert grafts to replace refs
Date:   Sun, 29 Apr 2018 00:45:22 +0200
Message-Id: <1072d92b32464c29e95eb975a902a86b3603ad58.1524955439.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
MIME-Version: 1.0
In-Reply-To: <cover.1524955439.git.johannes.schindelin@gmx.de>
References: <cover.1524865158.git.johannes.schindelin@gmx.de> <cover.1524955439.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:OatUJfXV2oIC1EhSAgiiJP7wqLjXL5VOUa2kLLH4+xuuSEc6X4R
 Ao9ZAJZDEic1ZvMKNOR6MUY8vkRHDlygbychnko994X3oQeKqTqZZnvvDya9WYNJGK4mJ/1
 9QX1MJnkR0Bol14KdLzW2cesrOFMHLQ5fZMuQ0rjL7JVnyt1Bb6CdlBGaCcSDwr+94XgaK/
 ZB1Kb/krD4BDxjkDbpg3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ojUWBCiMf8I=:+wn53LdsDpvafLqnK6Djhn
 hNlvixsVf5RFCvk3R6oL1/2nQkU67L78O819gXn/KZYjVgUtEGS/WKM1nGDF7BUmvUOwnf7Cg
 AVX6pzhjbi2cyL9mO+Cly2DjaC3XJ3hOFyC40XRY8iyeTKnt+qKPYry9k6cSjQa6rdgmRcRRi
 av38h6XH9/p/YfDbM5JPQj7HMVcs3XUWRxwz/IDZMqbid19i6KWowSaL8qcEu5yKcG1BfNHHY
 VhmOi0A6YdUhGT9uSSjyaLeRcinDfPPVI7uDWT5nBC1a/5fcGGKZWNQ87CyiuSltKk2Etr4Yn
 k5e7G6/mh1Yc7wr/WNRw9Mf59vFWtCmYMiXKZd0eYuJHOO9NEf76l0ZtJlZglSo1upjg0eu8o
 lTQ8/D+9czSZBJFp+DfdTqZm0EYm6QhSrHRwRUbR28aVy7AOAcJO21jPYeOVysCqtPe3u51Bt
 Y59G87rSnT0Cl+b7bqM7Dfw6DWhgr9UvIl8ZdOpDfG71VkxETLVa4XLZ2kcfQ9nZ6KX/0O40t
 sRJq0enKlqJ3OVFzn3a1TFFAgt4qfEgUhDCxCJGYBDNfyQq4tVrICsKj4GyLNRi+KCWMRtzUR
 qtBrEDNcYyBK6Fg4DwWtbpDD5yimuCV6yABoXEZd62pPoXvFsIxx7qHv80YPyh5N/o9r+zNEP
 Q6Kyn5Q6DJ196zPqZBdJR5JfbX63eJ1NE4ZBzBz7HkSEu3JZtyznEBo/Wsmv8wgI0s8G+BaeL
 QBL4eR9idhL6X5kkndkKNlVk23u8KbCAgTK2Gr54OKq1ap54luo2cXHbB3JY5+u3y0BfBWkGK
 SMXYJbr
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
2.17.0.windows.1.36.gdf4ca5fb72a
