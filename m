Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106612022A
	for <e@80x24.org>; Fri, 28 Oct 2016 11:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760158AbcJ1LO7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 07:14:59 -0400
Received: from happy.seestieto.com ([176.58.110.22]:56891 "EHLO
        happy.seestieto.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756527AbcJ1LO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 07:14:56 -0400
X-Greylist: delayed 1655 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Oct 2016 07:14:56 EDT
Received: from pablo by happy.seestieto.com with local (Exim 4.84_2)
        (envelope-from <pablo@seestieto.com>)
        id 1c04gx-00030a-9T; Fri, 28 Oct 2016 13:47:19 +0300
From:   Henrik Ahlgren <pablo@seestieto.com>
To:     git@vger.kernel.org
Cc:     Henrik Ahlgren <pablo@seestieto.com>
Subject: [PATCH] Fix typo in 2.11.0 RelNotes
Date:   Fri, 28 Oct 2016 13:47:19 +0300
Message-Id: <1477651639-11529-1-git-send-email-pablo@seestieto.com>
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Henrik Ahlgren <pablo@seestieto.com>
---
 Documentation/RelNotes/2.11.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.11.0.txt b/Documentation/RelNotes/2.11.0.txt
index 3590620..1d3a07d 100644
--- a/Documentation/RelNotes/2.11.0.txt
+++ b/Documentation/RelNotes/2.11.0.txt
@@ -5,7 +5,7 @@ Backward compatibility notes.
 
  * An empty string used as a pathspec element has always meant
    'everything matches', but it is too easy to write a script that
-   finds a path to remove in $path and run 'git rm "$paht"', which
+   finds a path to remove in $path and run 'git rm "$path"', which
    ends up removing everything.  This release starts warning about the
    use of an empty string that is used for 'everything matches' and
    asks users to use a more explicit '.' for that instead.
-- 
2.1.4

