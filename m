From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/4] Trivial compile fix for cache.c
Date: Tue, 13 Jun 2006 00:32:29 -0400
Message-ID: <20060613043229.16681.52113.stgit@dv.roinet.com>
References: <20060613043224.16681.98358.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Jun 13 06:32:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq0a0-0005Mg-Dd
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 06:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbWFMEce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 00:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932870AbWFMEce
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 00:32:34 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:45454 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932866AbWFMEce
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 00:32:34 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fq0Zt-0003S3-Ei
	for git@vger.kernel.org; Tue, 13 Jun 2006 00:32:33 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1Fq0Zp-0004LH-8g; Tue, 13 Jun 2006 00:32:29 -0400
To: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org,
	cvsps@dm.cobite.com
In-Reply-To: <20060613043224.16681.98358.stgit@dv.roinet.com>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21764>

From: Pavel Roskin <proski@gnu.org>

"tagnames" was renamed to "link", fix the last occurrence of "tagnames".

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cache.c b/cache.c
index 409392d..07e5d02 100644
--- a/cache.c
+++ b/cache.c
@@ -501,7 +501,7 @@ static void dump_patch_set(FILE * fp, Pa
 	struct list_head * tag;
 	for (tag = ps->tags.next; tag != &ps->tags; tag = tag->next)
 	{
-            TagName* tagname = list_entry (tag, TagName, tagnames);
+            TagName* tagname = list_entry (tag, TagName, link);
 
 	    fprintf(fp, " %s %d%s", tagname->name, tagname->flags,
 		    (tag->next == &ps->tags) ? "" : ",");
