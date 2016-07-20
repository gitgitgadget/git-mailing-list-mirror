Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A11D202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 21:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284AbcGTVKo (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:10:44 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:64473 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950AbcGTVKT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 17:10:19 -0400
Received: from localhost.localdomain ([92.22.79.77])
	by smtp.talktalk.net with SMTP
	id PykwbXvjRHGLwPyl0bEmcz; Wed, 20 Jul 2016 22:10:19 +0100
X-Originating-IP: [92.22.79.77]
X-Spam:	0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=YfJyJ16zsu2qLTmLoX9DvA==:117
 a=YfJyJ16zsu2qLTmLoX9DvA==:17 a=xtxXYLxNAAAA:8 a=6EjUVN6auzbEHZ3uzrkA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 5/8] doc: gitrevisions - use 'reachable' in page description
Date:	Wed, 20 Jul 2016 22:10:04 +0100
Message-Id: <20160720211007.5520-6-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160720211007.5520-1-philipoakley@iee.org>
References: <20160711202518.532-1-philipoakley@iee.org>
 <20160720211007.5520-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfOJDnjLIjk7vIoV/OihA2z9gqFMq8XXqPEWK3YYIw5oGi+KrPVDMho+cMYrRYytgvMpFJtCnRdY3WUxiS/hib3xQeaBHWIGwlNTGlDEd4g4tg+8hafgD
 Ep3TgH/PmgFN5ZuVmCCf2IWWVbzeZZa6Irz2AP5kXJ0zubZy9xYgTDbAjyLfWIWtw/kuG6mVLb+ny0ggHe4UMuxJzzad6eIEAl8833axTDSTUEL9giA83woK
 x/RFxNGzi4uYrbNDy+GLK+/PjyS/+rvj1c2vruSaqmymjYJfDyPW9CC7mYD6vXZ/
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Philip Oakley <philipoakley@iee.org>
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

