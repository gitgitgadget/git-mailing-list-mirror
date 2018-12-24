Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8991320A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 22:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbeLXW4H (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 17:56:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38345 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLXW4G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 17:56:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so10804383ede.5
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 14:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ysrGNt4wptIdVUX2D1sqj5wCpqMiFh/X/8BFzg3m0ro=;
        b=L3EAk4g/MsZ6f+QjGI1m4Gt7AcFCEeVzyngLGxEGo3B1oJOsQ0ITkRRqex0kT/+KET
         /QVlw82FRtaMEcxauob8mO6ppVkaaMGpDInmBxEbfB6r679Zuy0/egt+eRpyPlaFq0cl
         fGwWEMxkv0sxXo/2t+dcAkDW2JMnPyvG3ItB1AOInGhJDyyEszwwQalEL/dpyzRWw0Vo
         zvQ5tIiGd2wyap44Ammib0sb4RiY4jzKGVnmO3vMQxoJDCO2LCiQ6Xx3w8J3+yJfSoxk
         5qkbeDc90VFHkaC7i85bvWpYpBV3wc/wy8Dx8Oe/bEqfY6lvWcrPRVzCjnFJT3VYM+iq
         NrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ysrGNt4wptIdVUX2D1sqj5wCpqMiFh/X/8BFzg3m0ro=;
        b=VVux1EBFpK3ri2ymkyCJyr4MP6FiC/Ga3nCwX9yssgXpFAHAPQL3W3QVDuuHEBBZHB
         WQdX7stpDshrHyYJUEq5DzpZ93wIt043en/mpPcGjMRcsJB5pVZN1x5C1wRsGhFh2pTW
         vdl3VeDOzAsyoyQAnER3wiv2ODoGqEHGNXLbtkY1dgvX7p6KI7eicuU+XrvScZDlHlyg
         l8n02X8uFmq5Ba/X8DXs1NHzLlderHWWbaGI/Xa7PPWTyCNptvkg3iNtWZpJAlFbUV09
         qyVQ6Q2t9bWa9Iq5fXWwT1Xl4UF73+mjXm6oSSeUV2vbUIWOAtP8PFnRPVC292J40pbk
         v92g==
X-Gm-Message-State: AA+aEWbxQOwGNBPJEJjCh8UNrUsoOuJGV6ddWbJz7JpA0h0oHczK+qVk
        bT960h5KynLu6sEEflWBNlGP7HUF
X-Google-Smtp-Source: AFSGD/U82NWIM4HTplF4FoxuHYocWXASOv/2Erapc6Iw+A7cPH7e6C9C4D6TJtKiRIskU/gX3HSJJg==
X-Received: by 2002:aa7:da57:: with SMTP id w23mr11615534eds.7.1545692164637;
        Mon, 24 Dec 2018 14:56:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm9549004edm.29.2018.12.24.14.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 14:56:04 -0800 (PST)
Date:   Mon, 24 Dec 2018 14:56:04 -0800 (PST)
X-Google-Original-Date: Mon, 24 Dec 2018 22:56:02 GMT
Message-Id: <b935e11d21fc2a34953d1fc651ea09f1a4c1a769.1545692162.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.104.v3.git.gitgitgadget@gmail.com>
References: <pull.104.v2.git.gitgitgadget@gmail.com>
        <pull.104.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/1] abspath_part_inside_repo: respect core.fileMode
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

If the file system is case-insensitive, we really must be careful to
ignore differences in case only.

This fixes https://github.com/git-for-windows/git/issues/735

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c        | 6 +++---
 t/t3700-add.sh | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 1be5037f12..291bfb2128 100644
--- a/setup.c
+++ b/setup.c
@@ -39,7 +39,7 @@ static int abspath_part_inside_repo(char *path)
 	off = offset_1st_component(path);
 
 	/* check if work tree is already the prefix */
-	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
+	if (wtlen <= len && !fspathncmp(path, work_tree, wtlen)) {
 		if (path[wtlen] == '/') {
 			memmove(path, path + wtlen + 1, len - wtlen);
 			return 0;
@@ -59,7 +59,7 @@ static int abspath_part_inside_repo(char *path)
 		path++;
 		if (*path == '/') {
 			*path = '\0';
-			if (strcmp(real_path(path0), work_tree) == 0) {
+			if (fspathcmp(real_path(path0), work_tree) == 0) {
 				memmove(path0, path + 1, len - (path - path0));
 				return 0;
 			}
@@ -68,7 +68,7 @@ static int abspath_part_inside_repo(char *path)
 	}
 
 	/* check whole path */
-	if (strcmp(real_path(path0), work_tree) == 0) {
+	if (fspathcmp(real_path(path0), work_tree) == 0) {
 		*path0 = '\0';
 		return 0;
 	}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 37729ba258..be582a513b 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -402,4 +402,11 @@ test_expect_success 'all statuses changed in folder if . is given' '
 	test $(git ls-files --stage | grep ^100755 | wc -l) -eq 0
 '
 
+test_expect_success CASE_INSENSITIVE_FS 'path is case-insensitive' '
+	path="$(pwd)/BLUB" &&
+	touch "$path" &&
+	downcased="$(echo "$path" | tr A-Z a-z)" &&
+	git add "$downcased"
+'
+
 test_done
-- 
gitgitgadget
