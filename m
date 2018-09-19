Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3CC1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 20:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbeITCYA (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 22:24:00 -0400
Received: from ICGRIDDB04.SEAS.UPENN.EDU ([158.130.57.72]:44786 "EHLO
        ICGRIDDB04.SEAS.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeITCYA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 22:24:00 -0400
X-Greylist: delayed 1889 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Sep 2018 22:24:00 EDT
Received: from [10.13.0.14] (helo=ofb.net)
        by ICGRIDDB04.SEAS.upenn.edu with esmtp (Exim 4.89)
        (envelope-from <frederik@ofb.net>)
        id 1g2iqP-0001yh-Le; Wed, 19 Sep 2018 16:13:05 -0400
Received: from amenhotep (unknown [173.239.75.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ofb.net (Postfix) with ESMTPSA id 71D303EE59;
        Wed, 19 Sep 2018 13:13:00 -0700 (PDT)
Received: from frederik by amenhotep with local (Exim 4.91)
        (envelope-from <frederik@amenhotep>)
        id 1g2iqJ-0000Ag-VJ; Wed, 19 Sep 2018 20:12:59 +0000
From:   Frederick Eaton <frederik@ofb.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Frederick Eaton <frederik@ofb.net>
Subject: [PATCH 1/3] git-archimport.1: specify what kind of Arch we're talking about
Date:   Wed, 19 Sep 2018 13:12:29 -0700
Message-Id: <20180919201231.609-2-frederik@ofb.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180919201231.609-1-frederik@ofb.net>
References: <20180919201231.609-1-frederik@ofb.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is it a CPU architecture? Is it Arch Linux? If you search for "arch
repository", nothing relevant comes up. Let's call it GNU Arch so
people can find it with search engines.

Signed-off-by: Frederick Eaton <frederik@ofb.net>
---
 Documentation/git-archimport.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index ea7065336..a595a0ffe 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -3,7 +3,7 @@ git-archimport(1)
 
 NAME
 ----
-git-archimport - Import an Arch repository into Git
+git-archimport - Import a GNU Arch repository into Git
 
 
 SYNOPSIS
@@ -14,7 +14,8 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Imports a project from one or more Arch repositories. It will follow branches
+Imports a project from one or more GNU Arch repositories.
+It will follow branches
 and repositories within the namespaces defined by the <archive/branch>
 parameters supplied. If it cannot find the remote branch a merge comes from
 it will just import it as a regular commit. If it can find it, it will mark it
-- 
2.19.0

