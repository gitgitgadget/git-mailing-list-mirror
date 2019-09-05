Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5D91F461
	for <e@80x24.org>; Thu,  5 Sep 2019 15:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbfIEPrp (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 11:47:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44465 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbfIEPro (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 11:47:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so1998967pfn.11
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6eq2D1nJ3iJDBDg4gYBG0olHIE7ty7CnHn5jwT0Ql4=;
        b=qqc2nPK+DVB5NWi9vl05YCs7r84YyVA4VsP/VCJe6Cx3fhdtURX23FxrzFt/RKwCpu
         K8/2sa4MgHFHFfZKZt6lJ47KT7teTlfj+Fwoh29cfHqoesNDPVpINtze9WI20oQxK+Ys
         c0nRlGtpMgVsiVoWXh9zAf+5qFFhml0pTFZ9rY22gho0KSkfjZ4BgeyB46slOufY65IZ
         /YBV/zXsaqDuhQAEe/0U3mrT4Fn8LmMMZEGXp38nZmyhQjzjOBULt8ZMsUW3YBwDLEGW
         k1RKPe0kQ+T1VRaCVNa0iVWhFYFIuACzwsrW/2r0F/+Ec6+39NbmTnRZnDHGkOOROmdY
         F+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6eq2D1nJ3iJDBDg4gYBG0olHIE7ty7CnHn5jwT0Ql4=;
        b=HdNZPMWLWHzvYSZH6CbPP6ev3hCup0gqoD1+SmhAwWg7Kbf1TASIShvTFbLho4hlDy
         lrRqDXyi7autUqQxKa+Qw+8fxm7y6vkl9FZ4Vk9cTndv47bEpYbYfuc2evA84E7UKYdB
         InX8fZ9T+ezDYkZhW1/OYq1cVhuS4iDNMdpB94rd7jIDMYbRbMREA8dP6PInUyMrsD7/
         NZs5dZT6iCGBSiN61d3gbQLhsfjjY4VL86KK+lElOPVxX74TdcgZaJflosXaQSyJm1Qe
         KAcjNipnczsgL4FJJXOj4aISbmgZz/uJ51NHYvyWHM0xKAjLEnixUK8Gk8pv/jKrk/zd
         p5+Q==
X-Gm-Message-State: APjAAAUD7cZlB2l8TYjc1LJESy8gQ7t/HQ3YFtBtJclbE8S5ZB8Mh5p4
        bCy3dU+lt6V+aixNrUqG4Jm7UHdM
X-Google-Smtp-Source: APXvYqzkIfy5PNRhLKAlMnW3087BYqToX3OnuItKHENnQtBYMikAuTBgxDXWYb+xY1LLYyTXtWf3dg==
X-Received: by 2002:a62:8246:: with SMTP id w67mr4789184pfd.226.1567698463295;
        Thu, 05 Sep 2019 08:47:43 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id x16sm2339867pjn.12.2019.09.05.08.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 08:47:42 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 02/12] dir: fix typo in comment
Date:   Thu,  5 Sep 2019 08:47:25 -0700
Message-Id: <20190905154735.29784-3-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.11.g45a39ee867
In-Reply-To: <20190905154735.29784-1-newren@gmail.com>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index d021c908e5..a9168bed96 100644
--- a/dir.c
+++ b/dir.c
@@ -139,7 +139,7 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
 	 * ":(icase)path" is treated as a pathspec full of
 	 * wildcard. In other words, only prefix is considered common
 	 * prefix. If the pathspec is abc/foo abc/bar, running in
-	 * subdir xyz, the common prefix is still xyz, not xuz/abc as
+	 * subdir xyz, the common prefix is still xyz, not xyz/abc as
 	 * in non-:(icase).
 	 */
 	GUARD_PATHSPEC(pathspec,
-- 
2.22.1.11.g45a39ee867

