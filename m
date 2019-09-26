Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6FA1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 17:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfIZRn3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 13:43:29 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:36045 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfIZRn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 13:43:29 -0400
Received: by mail-lf1-f52.google.com with SMTP id x80so2351362lff.3
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kxAvL6fAdIVqe+eML6jlCMcvOAtJLXip7Hq8rzYR134=;
        b=EHNwFMZemd4AZIWNk0eds+gaUc89r5zjkEYtF8rEhSH5IloIkxphdLVjjYUzMGZNiT
         rFdywsihjfuawAvX/HNBldORsl1R16oXPZ6qOeSWp4HOQTVaVnFlXfIycIJ0LfG2SUua
         zgqGyERhudUnlfP3jWS40wiA3T54f2BFB8xgcP6qOA1DDkNzfWBKY1+vqye26zRlwWBh
         QaN7kgO904QLhFqhhXZJQZaT1f317I6RGPjyc8tLni7J3Fj8B2TvTh8T7vNpn5y/PuN/
         y6lmoqqAGYxgGy1BnqCbx3Y9pyTQGb4v8D0iSU/iTp32q7bO13sQHn4b4X9cjKwwOKDp
         gzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kxAvL6fAdIVqe+eML6jlCMcvOAtJLXip7Hq8rzYR134=;
        b=H3TugvseGuW1hEtSsdCbJPn2qXHK+e5CMWgEUvpmgxOEXXcY+wIIukmoLtxIXTT3XQ
         HEnN0pADTJVmNDzD3KRqbgVPqKmHmf+GvzVbm4dWGN7K1aMBFr+hiC9QERzEQLBNW1X1
         4GbCM0blHJPscTjiNdEVUaQcwMPDvY98jOi7Rec6YkWGMyJJIzyZeSWs6JsO4imjOtio
         ym/3rBITcj7eW8RIMwB+GRRuBdl04gv3ZWuWWjwFxIX+XU5ySAHJuoFsEzOOXlbis02a
         k7O8AXwNjqkshR9UVrgISeeGhd39HECRkqVcXPLGdt9h1qH+B2CDbUPFEFNoKpibA4v7
         Z0Pg==
X-Gm-Message-State: APjAAAWVk3UwjTDCq6psEpfRKjkSaYieyQ1CYKKEuI9pLul17SWmJB9F
        MCvzHXNuQwlopF3csVG91tjWvaAk
X-Google-Smtp-Source: APXvYqzoRurjR7G2e4Jy52DRRFTLn9ugoB7VIwkUI+GmL0SeSiGiz6pMNZsL2ceToXqEAGxyoxQOhA==
X-Received: by 2002:ac2:4853:: with SMTP id 19mr2937663lfy.69.1569519807106;
        Thu, 26 Sep 2019 10:43:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm629410ljh.35.2019.09.26.10.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 10:43:26 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:43:26 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 17:43:24 GMT
Message-Id: <02ec6c5bde2f15c51e946c6806d8231fb5abffe5.1569519804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.359.git.gitgitgadget@gmail.com>
References: <pull.359.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] git gui: fix staging a second line to a 1-line file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a 1-line file is augmented by a second line, and the user tries to
stage that single line via the "Stage Line" context menu item, we do not
want to see "apply: corrupt patch at line 5".

The reason for this error was that the hunk header looks like this:

	@@ -1 +1,2 @@

but the existing code expects the original range always to contain a
comma. This problem is easily fixed by cutting the string "1 +1,2"
(that Git GUI formerly mistook for the starting line) at the space.

This fixes https://github.com/git-for-windows/git/issues/515

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 lib/diff.tcl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 4cae10a4c7..68c4a6c736 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -698,6 +698,7 @@ proc apply_range_or_line {x y} {
 		set hh [$ui_diff get $i_l "$i_l + 1 lines"]
 		set hh [lindex [split $hh ,] 0]
 		set hln [lindex [split $hh -] 1]
+		set hln [lindex [split $hln " "] 0]
 
 		# There is a special situation to take care of. Consider this
 		# hunk:
-- 
gitgitgadget
