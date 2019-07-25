Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E39031F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbfGYKL2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:11:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40364 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388724AbfGYKLY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:11:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so50109320wrl.7
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/O2s2QmVE2pCrDqftaWxp9ULgojs/bvEB6pHGy1iFh8=;
        b=DurkFjk/E6eJ70K3BEDFvAtXA5n/6nQWs9jl/RCJTLrXnTBBAsV5KsE9087LtYWYgz
         oXihFj1t9TswPe3CNfyCrYX3OTeEYl8r94aVjlKWfVjlTvbs8JHD25w2HCAr+PeFvy/P
         gEkab2RZSvMJPo9Hz8mlxIVylMilquS9S+vzbkD/9ZvJYhiXfie3Ow/d/RmHiWTSJrVc
         9iBzFdtCXaRgDIQK+9olBUeAk8AQ4MQ8m2sBxvF5DR4PrpU7S6/ZncHFjM33zA+LCnM/
         QNVPN+HiVXUJqgbF95jIhW5WJkpPPc8F0XfzOxLucKxRWMu+kMkmHi3jBR2E3XgS3Yf6
         5sSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/O2s2QmVE2pCrDqftaWxp9ULgojs/bvEB6pHGy1iFh8=;
        b=POkI/f7YKanuwuPYUmEnBxwzRT3uRUr15epoLUcXaYFbcgPuXlOZm3tSNpN/fqdC/n
         5OfqqpoLuFOXoPO3WqJ/wMp3rwAOEZJLEXrK/8e7DLTujBmSbtT1NwqxLqE/djbG9vpF
         uPrOa4CzTG+0l8GNV5NW0N+oEU/SEjKjy87iIzNrqJlret8CWTNBjsHBhJvzJ4CrnHmr
         shCwoOU8CW6XClOp8bhBMHaMV5KqQwmm7oGSkitLqCeH0Y/+nCvphBqKekwRWWHiTrxI
         eDTq9djDR7GSsT5n9rQWbiej8Jl3FNm2hT1kXWWx35EXk0ONy+qit2i+mo0p0By7njdf
         TLKQ==
X-Gm-Message-State: APjAAAViAYz2QiWuHy+RVv+2pkbk2GXLkM68y1yzZusJLXix7gh38rBY
        MqbIDIY87kicU8RLvoF0M/gqgxpk
X-Google-Smtp-Source: APXvYqwQedtKQaPcv1VJ1KYa8BbW5U7188j/gwQDLynofPzi1QyxPuBl3bCGLFQrvcA/bBdQm77hmg==
X-Received: by 2002:adf:8bc2:: with SMTP id w2mr10929882wra.7.1564049482798;
        Thu, 25 Jul 2019 03:11:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g17sm36168164wrm.7.2019.07.25.03.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:11:22 -0700 (PDT)
Date:   Thu, 25 Jul 2019 03:11:22 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 10:11:11 GMT
Message-Id: <ae9e72b73bf2da0de3a5369748ebd358656588d9.1564049474.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 10/12] t/lib-rebase: prepare for testing `git rebase
 --rebase-merges`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The format of the todo list is quite a bit different in the
`--rebase-merges` mode; Let's prepare the fake editor to handle those
todo lists properly, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-rebase.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 7ea30e5006..662a958575 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -44,10 +44,10 @@ set_fake_editor () {
 	rm -f "$1"
 	echo 'rebase -i script before editing:'
 	cat "$1".tmp
-	action=pick
+	action=\&
 	for line in $FAKE_LINES; do
 		case $line in
-		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d)
+		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|r|merge|m)
 			action="$line";;
 		exec_*|x_*|break|b)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
@@ -61,8 +61,8 @@ set_fake_editor () {
 			echo "$action XXXXXXX False commit" >> "$1"
 			action=pick;;
 		*)
-			sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
-			action=pick;;
+			sed -n "${line}s/^[a-z][a-z]*/$action/p" < "$1".tmp >> "$1"
+			action=\&;;
 		esac
 	done
 	echo 'rebase -i script after editing:'
-- 
gitgitgadget

