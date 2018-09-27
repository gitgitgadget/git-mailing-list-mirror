Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C2F1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 05:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeI0MHF (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 08:07:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44692 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeI0MHE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 08:07:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id g24-v6so1077731lfb.11
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 22:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jp1+PRvPStqA5meBQXBrIjMaU1kO/LN/cGoqIN24ixk=;
        b=ax/YM9D75VswxCRpw07KAWfGlnN03eeuQcrPiABeGSECK9gaZJpnZ40qk7cj+uPIg5
         3MypymJX4SuGih9kG2grs4qSmvdQO5az5+VC5vVSN/c5J330sF4+gBhWtMuDIk1IF3Jq
         NF21KPStIErMUmM6Q9eHegMR/N0YakUad645eITPd29RD4swvcOQ4Sd72cMyxYJd7P00
         x83c7r2igNvskI3U0wIZiPkCgbClEVnuYkmnNWxS5F5zEsgZ7h+uf3cj+qOtH21qx3G9
         BfkscPxtqvz/LC42Uq/5TZmEZkWBhgzwCkdOJ7I9zAlLXedCrQv1VOiN8Ui8RuJ6sCc8
         4N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jp1+PRvPStqA5meBQXBrIjMaU1kO/LN/cGoqIN24ixk=;
        b=YuLVHzlbqEsln3iazyiec2p/cPZG/+Ib9BmGn5Mqk/xkOU/5aISg4NRldFno4HMrky
         AkYZCCd8/KoGZ5a4TlMpgQD3SI8g+IHibQBw5GBbmqKOBwKG9uTXNOGGqjM2IVFAYXrk
         dREuwq06mAuuFxTKIQA/yJbmuKzDAQ+wpb5kzCje6DIzFMLDOhcfYReUaGmSzNPOg5Hy
         YuXSq14IC0I5eXrKJXkXxSrXT97dVERTALBrk+XJhgEnytbbXR4ccXb3drcZNBa4i03B
         QHSKpslqkoN2JTf64xI684TPrhcjPu12ocCGb+UC4I0P2EBtsv3Pod4XemFV0rugPmCs
         rGLw==
X-Gm-Message-State: ABuFfoiwHda17esDxW7mZSBImR+OrykD+w+amQBcvmuLjSZidcBrtiEJ
        twfIg5twMkz3YrT7vK2wqW65UKYM
X-Google-Smtp-Source: ACcGV60Tw/SfmwdIjXk4o3EfokorZDcjBFjhveAWyk2jw6kzsY0FYH0m9sfCLkfTZNr/kX1SX0lRuA==
X-Received: by 2002:a19:cb09:: with SMTP id b9-v6mr5943701lfg.117.1538027432502;
        Wed, 26 Sep 2018 22:50:32 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id t22-v6sm212480ljc.82.2018.09.26.22.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Sep 2018 22:50:31 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] git.txt: mention mailing list archive
Date:   Thu, 27 Sep 2018 07:50:18 +0200
Message-Id: <20180927055018.6683-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
In-Reply-To: <20180926134717.GC25697@syl>
References: <20180926134717.GC25697@syl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the "Reporting Bugs" section of git(1), we refer to the mailing list,
but we do not give any hint about where the archives might be found. Of
course, any web search engine can be used to try to hunt down whether an
issue is already known. But we can do better by mentioning the archive
at public-inbox. Make sure to phrase this in a way that avoids raising
the bar for reporting.

public-inbox.org/git/ is usually our preferred archive, since it uses
message ids in its permalinks. But it also has a search function right
at the top of each page, and searching gives the most recent hits first.
Searching for some keyword about a bug or regression should pretty
easily reveal whether it has been recently reported.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Thanks Junio and Taylor for thoughts on this. I agree we do not want
 to scare anyone away. I hope this does the trick.

 Documentation/git.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 74a9d7edb4..68393f3235 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -859,6 +859,9 @@ Reporting Bugs
 Report bugs to the Git mailing list <git@vger.kernel.org> where the
 development and maintenance is primarily done.  You do not have to be
 subscribed to the list to send a message there.
+If you want to check to see if the issue has
+been reported already, the list archive can be found at
+<https://public-inbox.org/git/> and other places.
 
 Issues which are security relevant should be disclosed privately to
 the Git Security mailing list <git-security@googlegroups.com>.
-- 
2.19.0.216.g2d3b1c576c

