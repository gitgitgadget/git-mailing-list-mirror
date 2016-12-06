Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F901FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbcLFVxf (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:35 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34040 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbcLFVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:13 -0500
Received: by mail-pg0-f53.google.com with SMTP id x23so153561238pgx.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WpuWIpe4DxjycFg/RZlepuIBmMRUWBFqxeHrgnKy3C4=;
        b=Wd2puujqwMp8dNqIukLlTbpHN3tiBFhIPmhBYT2xVjns0XOftQO7Rnf3RcpwI48oca
         2uBu6OHf95Zj25FbSqx3q6z32KwPcRpPhe4qqBlRH8yEg2QII62mgg+n5oHnD1Z334Ta
         sdcQ2k4jvCqqfgGacj7l2CnrlR8/gb9QJQeJuA7UGnWjObGEJLeGuYNm1k7AFQ4TCfOg
         bqppFaZc1U9JoBpePNkoVsJEunJP8JBxtsagBkqF/8LaVzK3Ehm0QnNvBJO1764CKV9T
         mh6K0xpqtlNkcWIJOir7CXrNLIpJkmrkS7IFhE2ah+djW9gbexMp6LUQsCf+rwXW+gKw
         63tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WpuWIpe4DxjycFg/RZlepuIBmMRUWBFqxeHrgnKy3C4=;
        b=Uk1VwVH98Gf5oX2H7RBp0vCcVPreABpRdB3U3K3Pnq0G/gK+QPYcQSedBiHoVSr3CB
         KQ0oywsu/+zq3hYL0elvfxT6GuZpd3lEV7mpS9yN5qEr/hys8hc5wssxt8IEFc0+fyx6
         JuJLBP08edn+c+psOHfgfj1VvYdUXwwv4Ccu4V55EqqorIM4obnOeVgC+jWwcEyAgMlB
         baJwFUgK+rBLYbApu4KrVRLx3IcaUkAWgTgJ6dXnTOGqgVYHsBlGj3tN+wcxAMFqF+CN
         GNJNI+I4NyN1MbVizCg5U7ujzko+ehtD2PgO3X8R1M8BuUOPsudOhBfLb85pDucZMa8p
         sZZg==
X-Gm-Message-State: AKaTC02IGdutUC9SFOjGJ+7f0OkGl+aAQziqXkJAarWD/y0SVz5pNw09dS7mG/LPgFnGbCMx
X-Received: by 10.98.72.129 with SMTP id q1mr65013627pfi.169.1481061158225;
        Tue, 06 Dec 2016 13:52:38 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:37 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 16/17] pathspec: small readability changes
Date:   Tue,  6 Dec 2016 13:51:45 -0800
Message-Id: <1481061106-117775-17-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few small changes to improve readability.  This is done by grouping related
assignments, adding blank lines, ensuring lines are <80 characters, etc.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 41aa213..8a07b02 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -334,6 +334,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	if ((magic & PATHSPEC_LITERAL) && (magic & PATHSPEC_GLOB))
 		die(_("%s: 'literal' and 'glob' are incompatible"), elt);
 
+	/* Create match string which will be used for pathspec matching */
 	if (pathspec_prefix >= 0) {
 		match = xstrdup(copyfrom);
 		prefixlen = pathspec_prefix;
@@ -341,11 +342,16 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 		match = xstrdup(copyfrom);
 		prefixlen = 0;
 	} else {
-		match = prefix_path_gently(prefix, prefixlen, &prefixlen, copyfrom);
+		match = prefix_path_gently(prefix, prefixlen,
+					   &prefixlen, copyfrom);
 		if (!match)
 			die(_("%s: '%s' is outside repository"), elt, copyfrom);
 	}
+
 	item->match = match;
+	item->len = strlen(item->match);
+	item->prefix = prefixlen;
+
 	/*
 	 * Prefix the pathspec (keep all magic) and assign to
 	 * original. Useful for passing to another command.
@@ -362,8 +368,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	} else {
 		item->original = xstrdup(elt);
 	}
-	item->len = strlen(item->match);
-	item->prefix = prefixlen;
 
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP)
 	    strip_submodule_slash_cheap(item);
@@ -371,13 +375,14 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
 	    strip_submodule_slash_expensive(item);
 
-	if (magic & PATHSPEC_LITERAL)
+	if (magic & PATHSPEC_LITERAL) {
 		item->nowildcard_len = item->len;
-	else {
+	} else {
 		item->nowildcard_len = simple_length(item->match);
 		if (item->nowildcard_len < prefixlen)
 			item->nowildcard_len = prefixlen;
 	}
+
 	item->flags = 0;
 	if (magic & PATHSPEC_GLOB) {
 		/*
-- 
2.8.0.rc3.226.g39d4020

