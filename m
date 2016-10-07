Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2481F4F8
	for <e@80x24.org>; Fri,  7 Oct 2016 09:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbcJGJ4q (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 05:56:46 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:41278 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbcJGJ4p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 05:56:45 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bsRtQ-000169-S9; Fri, 07 Oct 2016 11:56:40 +0200
Date:   Fri, 7 Oct 2016 11:56:38 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] clean up confusing suggestion for commit references
Message-ID: <20161007095638.GA55445@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description for referencing commits looks as if it is contradicting
the example, since it is itself enclosed in double quotes. Lets use
single quotes around the description and include the double quotes in
the description so it matches the example.
---
Sorry for opening this up again but I just looked up the format and was
like: "Umm, which one is now the correct one..."

For this makes more sense. What do others think?

Cheers Heiko

 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 08352de..692f4ce 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -122,7 +122,7 @@ without external resources. Instead of giving a URL to a mailing list
 archive, summarize the relevant points of the discussion.
 
 If you want to reference a previous commit in the history of a stable
-branch, use the format "abbreviated sha1 (subject, date)",
+branch, use the format 'abbreviated sha1 ("subject", date)',
 with the subject enclosed in a pair of double-quotes, like this:
 
     Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
-- 
2.10.0.645.g54f1e86

