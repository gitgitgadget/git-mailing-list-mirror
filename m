Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ACA21FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 21:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbdALVc7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 16:32:59 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:15882 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdALVc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 16:32:57 -0500
Received: from localhost.localdomain ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id RmzJcW0LO0KuvRmzLcL1f8; Thu, 12 Jan 2017 21:32:51 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=xtxXYLxNAAAA:8 a=oAYF_C9AAAAA:8
 a=FP58Ms26AAAA:8 a=Csg6D8IlV9FiwDgi3KcA:9 a=xts0dhWdiJbonKbuqhAr:22
 a=qaKyCUGJxuDmXQJvZgRi:22 a=6LVbBl2NLSWPyIBDCKCu:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Shawn O . Pearce" <spearce@spearce.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 3/3] doc: git-gui browser does not default to HEAD
Date:   Thu, 12 Jan 2017 21:32:40 +0000
Message-Id: <20170112213240.7972-4-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1.323.g0305acf
In-Reply-To: <20170112213240.7972-1-philipoakley@iee.org>
References: <20170112213240.7972-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfJq661CK5rzFtxf/HNxdnR+uJHxznZCS8i9amgf0TX0QVowY3zC3OgbkJToJedW1gAseHBXSTkv2VIf94NFswGgcOzKAIPvQSk3fb4S5XaUcocB2AA7u
 eacLwmq34InnDMYsoeyx5NW0jofcrq6jv+Rvbo0oDPtMeB66t8O8Ndk2x7FE/gxCByCZCJzcAVEQB+9uPjd7Fpzztqs141psENzhRhOac6rPBBj49hfXAqoN
 fQzuykLhXipDjkmyEBcXXn8/nnom1dzznMlCt5sVSCHKu9JeP/nLXEAA6ug2m711
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

37cd4f7 ("Document git-gui, git-citool as mainporcelain manual pages",
2007-06-21) documented the default, but was shortly followed by c52c945
("git-gui: Allow blame/browser subcommands on bare repositories",
2007-07-17) which, it would appear, as a side effect, removed that default.

Finally document that change.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
cc: Shawn O. Pearce <spearce@spearce.org>
cc: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 Documentation/git-gui.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index c1a3e8b..5f93f80 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -35,7 +35,7 @@ blame::
 
 browser::
 	Start a tree browser showing all files in the specified
-	commit (or `HEAD` by default).  Files selected through the
+	commit.  Files selected through the
 	browser are opened in the blame viewer.
 
 citool::
-- 
2.9.0.windows.1.323.g0305acf

