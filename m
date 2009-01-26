From: jidanni@jidanni.org
Subject: [PATCH] git-bundle(1): add no references required simplest case
Date: Tue, 27 Jan 2009 03:02:08 +0800
Message-ID: <87d4e97uxb.fsf_-_@jidanni.org>
References: <87zlirc49l.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, git@vger.kernel.org
To: mdl123@verizon.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 26 20:07:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRWkh-0004pu-Ar
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbZAZTCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbZAZTCQ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:02:16 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:60690 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753026AbZAZTCP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2009 14:02:15 -0500
Received: from jidanni.org (122-127-37-230.dynamic.hinet.net [122.127.37.230])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 7C2ED119E3B;
	Mon, 26 Jan 2009 11:02:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107248>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
See http://article.gmane.org/gmane.comp.version-control.git/103576
 Documentation/git-bundle.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 1b66ab7..7c1e990 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -164,6 +164,13 @@ $ git pull bundle
 would treat it as if it is talking with a remote side over the
 network.
 
+If a bundle requires no references, one may simply use:
+
+------------
+$ git init
+$ git pull bundle.bdl master
+------------
+
 Author
 ------
 Written by Mark Levedahl <mdl123@verizon.net>
-- 
1.6.0.6
