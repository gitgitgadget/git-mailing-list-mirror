From: mhagger@alum.mit.edu
Subject: [RFC 10/13] strbuf_check_tag_ref(): the refname is full, so use REFNAME_FULL option
Date: Wed, 19 Oct 2011 22:55:13 +0200
Message-ID: <1319057716-28094-11-git-send-email-mhagger@alum.mit.edu>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:00:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdF4-0005cB-SN
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab1JSU77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 16:59:59 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:32769 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab1JSU76 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 16:59:58 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4e-000423-VE; Wed, 19 Oct 2011 22:49:17 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183958>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/tag.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 9b6fd95..abf3cb0 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -412,7 +412,7 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 	strbuf_reset(sb);
 	strbuf_addf(sb, "refs/tags/%s", name);
 
-	return check_refname_format(sb->buf, 0);
+	return check_refname_format(sb->buf, REFNAME_FULL);
 }
 
 int cmd_tag(int argc, const char **argv, const char *prefix)
-- 
1.7.7
