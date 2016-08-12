Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01CEA203BD
	for <e@80x24.org>; Fri, 12 Aug 2016 07:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbcHLHJ3 (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:09:29 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:5935 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbcHLHIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:08:49 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Y6ZUbGDs4xR4bY6ZYbadhX; Fri, 12 Aug 2016 08:08:04 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=xtxXYLxNAAAA:8 a=6EjUVN6auzbEHZ3uzrkA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 07/12] doc: gitrevisions - use 'reachable' in page description
Date:	Fri, 12 Aug 2016 08:07:44 +0100
Message-Id: <20160812070749.2920-8-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160812070749.2920-1-philipoakley@iee.org>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfPObPgyNO4HCAUwKY/xJP9VCAEqA9oERYsGZV30EKRKQrH8FnBkGioWArB53i/xUeLI7co9SdG1lRgSBSop3JbRgUc8+RixfP4+WRE/VQW9UqW173IID
 vLMuTAVFsgqG68h3kMEipqOwpJru9axgINylYYmZK8/vTmP0joea4t51E0uCxVqwu0O3JQxYcP19NmqtTfREgut72BhCIyY3wCE=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
unchanged
---
 Documentation/gitrevisions.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitrevisions.txt b/Documentation/gitrevisions.txt
index e903eb7..33039c6 100644
--- a/Documentation/gitrevisions.txt
+++ b/Documentation/gitrevisions.txt
@@ -15,8 +15,8 @@ DESCRIPTION
 
 Many Git commands take revision parameters as arguments. Depending on
 the command, they denote a specific commit or, for commands which
-walk the revision graph (such as linkgit:git-log[1]), all commits which can
-be reached from that commit. In the latter case one can also specify a
+walk the revision graph (such as linkgit:git-log[1]), all commits which are
+reachable from that commit. In the latter case one can also specify a
 range of revisions explicitly.
 
 In addition, some Git commands (such as linkgit:git-show[1]) also take
-- 
2.9.0.windows.1

