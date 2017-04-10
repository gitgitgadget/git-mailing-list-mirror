Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08A6520970
	for <e@80x24.org>; Mon, 10 Apr 2017 10:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbdDJK7m (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 06:59:42 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34339 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753206AbdDJK7l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 06:59:41 -0400
Received: by mail-wr0-f195.google.com with SMTP id u18so20670216wrc.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 03:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lx85amfsAZizvufLAn2jmEs7Gz28Ta+aEOC2QtUCLMY=;
        b=fgVQLqflZp8JteWh8pzMigq4eJ7u8FqfFXWzXg0JqxzGyvXVkPAVES+XJcDiUK9xTR
         koczNCQ//eji4+dRCze+HMQHLVeLMnM8xep3vPYuiokrCrdPRByaF/I+ogL9cxHvP3Vc
         z2l5SiQHrpqw+HcGOvBGHviZshPRPA9eZdnkNRksEm8hDaoYuOf1Uon00BpMHz8Ro57A
         j2UK3odD+EQpnNFFNTNowdTQbB/LEmIDWLapBe/FkFSlEldEViaMZ9L7SVRBok+OeiD4
         W5R5tcgwevxMNFt9/0wb/7sT7LNZB8j6yyJt3aoBkrw9xF8QYmRoKlR46tBoY01XMJkk
         zYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lx85amfsAZizvufLAn2jmEs7Gz28Ta+aEOC2QtUCLMY=;
        b=OV73F5fqoB4Z8sNFAU2mFyQ7InuVZex5WXrfE7s9WzjhHTbik5xqlxTtxRa5qwD0b/
         kM2afHKlOj8xcMl+5Zu3k4WeXTQoYObCYuYTN8EpJsCSfThNFqgM/zeJ3V9h3WhMtwWz
         MkZcjv1JYC/fIlv1mBCkz5fgLHlMXkYYIJ/vRk8txJRIFTh9/R7xGuIrT1BN+aTmP4UX
         41JE9ZHhhof0ghBlhZLxZDr3LVGJqsOZYph6uHYpgeIEn9M9IppFGR52dgN6apOzyfTS
         a8nW6MBuW5MyGe4kJaB3vRNQP77ShrM/vnjYiLnHW9KSDR7Y5bbJ8uT6/R+9buj5T4Jp
         khJA==
X-Gm-Message-State: AN3rC/6PGKmNxc0NTBlCHOy8rKxCXlj0NP+H+5DcZdGwk+akgu2h0imuH6buECriZnEV0Q==
X-Received: by 10.223.182.155 with SMTP id j27mr8511186wre.152.1491821979742;
        Mon, 10 Apr 2017 03:59:39 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:10f4:fe01:e1fb:dfb2:f303:d2fb])
        by smtp.gmail.com with ESMTPSA id d17sm9817175wmi.21.2017.04.10.03.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 03:59:38 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH v1] Docs: Add some missing options to git-diff.txt
Date:   Mon, 10 Apr 2017 12:59:07 +0200
Message-Id: <20170410105907.12045-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <1490903375-2115-1-git-send-email-asheiduk@gmail.com>
References: <1490903375-2115-1-git-send-email-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Well, this wording picks up your points but I won't call it "stress
it" :-) However this should do the job.

--8<------>8------
git-diff understands "--ours", "--theirs" and "--base" for files with
conflicts. But so far they were not documented for the central diff
command but only for diff-files.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-diff.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index bbab35fca..2bccf4505 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -97,6 +97,21 @@ OPTIONS
 :git-diff: 1
 include::diff-options.txt[]
 
+-1 --base::
+-2 --ours::
+-3 --theirs::
+	Compare the working tree with the "base" version (stage #1),
+	"our branch" (stage #2) or "their branch" (stage #3). The
+	index contains these stages only for unmerged entries i.e.
+	while resolving conflicts.  See linkgit:git-read-tree[1]
+	section "3-Way Merge" for more information.
+
+-0::
+	Omit diff output for unmerged entries and just show
+	"Unmerged". Can be used only when comparing the working tree
+	with the index
+
+
 <path>...::
 	The <paths> parameters, when given, are used to limit
 	the diff to the named paths (you can give directory
-- 
2.12.2

