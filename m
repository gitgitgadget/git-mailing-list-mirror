From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] proper C syntax (inline has to be placed before the return type).
Date: Wed, 23 Aug 2006 04:41:09 +0200
Message-ID: <11563008693465-git-send-email-madcoder@debian.org>
Reply-To: Pierre Habouzit <madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Aug 23 04:41:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFig6-0007TY-UG
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 04:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWHWClM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 22:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWHWClM
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 22:41:12 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:54737 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932306AbWHWClL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 22:41:11 -0400
Received: from olympe.madism.org (olympe.madism.org [82.243.245.108])
	by smtp3-g19.free.fr (Postfix) with ESMTP id AA7CA47F89;
	Wed, 23 Aug 2006 04:41:09 +0200 (CEST)
Received: from olympe.madism.org (localhost [127.0.0.1])
	by olympe.madism.org (Postfix) with ESMTP id 75D16BC7B0;
	Wed, 23 Aug 2006 04:41:09 +0200 (CEST)
Received: from hades.madism.org (hades.madism.org [192.168.0.10])
	by olympe.madism.org (Postfix) with ESMTP id 56F4CBC7AE;
	Wed, 23 Aug 2006 04:41:09 +0200 (CEST)
Received: by hades.madism.org (Postfix, from userid 1000)
	id 47DCE62126; Wed, 23 Aug 2006 04:41:09 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.1
X-Virus-Scanned: by ClamAV (using ClamSMTP) at hermes.madism.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25890>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 strbuf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 9d9d8be..c8174b4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -13,7 +13,7 @@ static void strbuf_begin(struct strbuf *
 	strbuf_init(sb);
 }
 
-static void inline strbuf_add(struct strbuf *sb, int ch) {
+static inline void strbuf_add(struct strbuf *sb, int ch) {
 	if (sb->alloc <= sb->len) {
 		sb->alloc = sb->alloc * 3 / 2 + 16;
 		sb->buf = xrealloc(sb->buf, sb->alloc);
-- 
1.4.1.1
