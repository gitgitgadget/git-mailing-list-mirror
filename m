Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC7B1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 23:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbfBMX5Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 18:57:16 -0500
Received: from emiliocobos.net ([178.62.105.89]:43986 "EHLO emiliocobos.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729495AbfBMX5P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 18:57:15 -0500
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2019 18:57:15 EST
From:   =?UTF-8?q?Emilio=20Cobos=20=C3=81lvarez?= <emilio@crisal.io>
Authentication-Results: mail.emiliocobos.net; dmarc=none (p=none dis=none) header.from=crisal.io
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Emilio=20Cobos=20=C3=81lvarez?= <emilio@crisal.io>
Subject: [PATCH] docs/git-rebase: Remove redundant entry in incompatible options list.
Date:   Thu, 14 Feb 2019 00:44:33 +0100
Message-Id: <20190213234433.31597-1-emilio@crisal.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --autosquash option is implied by the earlier --[no-]autosquash
entry in the list.

Signed-off-by: Emilio Cobos Álvarez <emilio@crisal.io>
---
 Documentation/git-rebase.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index daa16403ec..daeaa1d0c7 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -529,7 +529,6 @@ are incompatible with the following options:
  * --interactive
  * --exec
  * --keep-empty
- * --autosquash
  * --edit-todo
  * --root when used in combination with --onto
 
-- 
2.20.1

