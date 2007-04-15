From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Document -g (--walk-reflogs) option of git-log
Date: Mon, 16 Apr 2007 00:36:06 +0200
Message-ID: <20070415223606.GB4417@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 00:36:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdDKj-0001vn-5S
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 00:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbXDOWgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 18:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754026AbXDOWgK
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 18:36:10 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:53075 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbXDOWgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 18:36:09 -0400
Received: from tigra.home (Fcb1d.f.strato-dslnet.de [195.4.203.29])
	by post.webmailer.de (klopstock mo8) (RZmta 5.5)
	with ESMTP id S022ffj3FJEvi5 ; Mon, 16 Apr 2007 00:36:06 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D221A277BD;
	Mon, 16 Apr 2007 00:36:06 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id AB7A4D439; Mon, 16 Apr 2007 00:36:06 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg2oA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44534>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Complained about on IRC. Thanks DrNick for proofreading and Gitster
for patience.

 Documentation/git-log.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 030edaf..96e8a3f 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -46,6 +46,11 @@ include::pretty-formats.txt[]
 -p::
 	Show the change the commit introduces in a patch form.
 
+-g, \--walk-reflogs::
+	Show commits as they were recorded in the reflog. The log contains
+	a record about how the tip of a reference was changed.
+	See also gitlink:git-ref-log[1].
+
 <paths>...::
 	Show only commits that affect the specified paths.
 
-- 
1.5.1.1.819.gcfdd2
