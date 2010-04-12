From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 1/5] tag.c: Correct indentation
Date: Mon, 12 Apr 2010 16:25:25 -0700
Message-ID: <1271114729-18166-1-git-send-email-spearce@spearce.org>
References: <20100411024008.GC23075@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 01:25:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1T0d-0007Q8-RQ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 01:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab0DLXZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 19:25:34 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:36075 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab0DLXZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 19:25:32 -0400
Received: by gxk9 with SMTP id 9so3696677gxk.8
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 16:25:31 -0700 (PDT)
Received: by 10.101.139.6 with SMTP id r6mr3168177ann.14.1271114731536;
        Mon, 12 Apr 2010 16:25:31 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 35sm1209081yxh.15.2010.04.12.16.25.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 16:25:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.246.g978a8
In-Reply-To: <20100411024008.GC23075@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144773>

These lines were incorrectly indented with spaces, violating our
coding style.  Its annoying to read with 4 position tab stops, so
fix the indentation to be correct.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Respin of the stable describe stuff, this time pushing the date
 parsing into tag.c and the struct tag member.

 tag.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tag.c b/tag.c
index 4470d2b..52d71bb 100644
--- a/tag.c
+++ b/tag.c
@@ -44,9 +44,9 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 	char type[20];
 	const char *start = data;
 
-        if (item->object.parsed)
-                return 0;
-        item->object.parsed = 1;
+	if (item->object.parsed)
+		return 0;
+	item->object.parsed = 1;
 
 	if (size < 64)
 		return -1;
-- 
1.7.1.rc1.246.g978a8
