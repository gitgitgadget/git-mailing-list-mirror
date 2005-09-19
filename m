From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH][COGITO] Update Debian control file
Date: Mon, 19 Sep 2005 15:54:13 +0300
Message-ID: <20050919125413.GB5048@igloo.ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 19 14:58:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHLCq-0008A0-MY
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 14:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVISM47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 08:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVISM47
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 08:56:59 -0400
Received: from mail1.imul.com ([217.113.72.31]:24155 "EHLO mail1.infocom.co.ug")
	by vger.kernel.org with ESMTP id S932301AbVISM46 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 08:56:58 -0400
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Mon, 19 Sep 2005 15:56:41 +0300
  id 000E9CE8.432EB589.00001617
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 923D6514A
	for <git@vger.kernel.org>; Mon, 19 Sep 2005 15:57:58 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.52)
	id 1EHL9x-0002ON-UE
	for git@vger.kernel.org; Mon, 19 Sep 2005 15:54:13 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8857>

Update Debian control file

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---
diff --git a/debian/changelog b/debian/changelog
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,15 @@
+cogito (0.15-1) stable; urgency=low
+
+  * New Version
+  * Now depends on git-core-0.99.7
+  * cg-pull is now called cg-fetch
+  * cg-update will become cg-pull in a future release
+  * the *-id scriptlets renamed to cg-*-id
+  * cg-init respects the ignore rules
+  * cg-add now support directories (-r)
+
+ -- Martin Atukunda <matlads@dsmagic.com>  Mon, 19 Sep 2005 10:01:40 +0300
+
 cogito (0.13-1) stable; urgency=low
 
   * New version.
