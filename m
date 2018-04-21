Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABEE01F424
	for <e@80x24.org>; Sat, 21 Apr 2018 09:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeDUJ5H (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 05:57:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:45945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751282AbeDUJ5G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 05:57:06 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZ8fw-1erBuk38DU-00L29M; Sat, 21
 Apr 2018 11:57:02 +0200
Date:   Sat, 21 Apr 2018 11:56:47 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 11/11] Remove obsolete script to convert grafts to replace
 refs
In-Reply-To: <cover.1524303776.git.johannes.schindelin@gmx.de>
Message-ID: <1b4e085ceed9ed5125b2fec2b297a970739c175f.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PeKBGTRKjQlaWTJqBDtbfqocz2wAYq6zrhHjnDEewm6hKWeJVhg
 Y/0mKHes1DgMb8Kdyo5viaXe91+n3T3XvqIxIohKdxw9VJmJiH1p7s8aufwOjrSBDtuVjBT
 AKHEUe9rDThmXenmE61ajkBZAh3pCDNBHq2dl6MWC7KCmXckvyzQBR1o41/Mr4BiS4GALYd
 daB0uE1jtRvvj05i1qzKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fl7inb6SZ1M=:NI6SekZhq2lKtcy2f3jIAo
 t2qnrVLLC59TlnOFRPxwXYDYK4CGVQDqeKEnJDYt8MPbGX7u8asMuccCdsLSOs3+msZ8mqj1e
 nWPtbfR7J9Mz0u+45yHnhu8Nu986iyo6MJ9SFc9jBac8muCZMnYRNE7YBrYRTGJIppFqF3Nhv
 xpjbFWyahXIHuCncqOplD4n6GmTxCF96PggUNm5NGxZ5vDYyoTs9HVxvLk3Glnp0bQsBhV5AF
 i2ozAYv0C5XJRT02ddqGVakQXUDPD/6H/MTMycIdGFzqQKwA6N48a0s/lRki6dUiWM6lOAuVt
 +wwfJr6rUE/bKI1ZnpgG+wEYgugfiUP+i+tBA9vedB9PA66EucT9SNlDxFRF75nCh2Kjt/ihq
 /pAbBih/QjOJY6kOJUlpWFedN3yWcJPr1yChEOtLQPRspZY7uARjPNSHuT1gwS1wbWRKYvtMj
 gH9tv3KGLO6yhLZGnbNelQfzidLxUX0KIphCF9fI4kpreV8pYKR80wAYV5x2qxxoBMcEzSUiZ
 nbN+P98NihGpFJT6Thc6zLpgtzvPOnB34TO/6MpTZPMQOZ4Hn3+CG86EVKUgUjjY2iZnSdtP1
 s9k6w5i/MmLrv2i0FFNrVzBPaAtZqaJ2DE6cN+i6W0mjc3x/KU+b5CixbK10tegJEoH1E89uK
 vJCO2j929NIZwpGFUqJlQJ/VK2nkhriScDwZDmsgpgQD3q9g7G0eiAp48QfNAFaz0TVdofCaC
 P/ysN3BWr481xITxtkoAlR0yZd4AKb61oKFyFbk9rAX4L2WGs92377AGctMZDWx84wP46celM
 H0I0Xgbk++g6y23/Ha1tXlsHBOqj2mwBOBcVS412CBeL0Wo04s=
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
