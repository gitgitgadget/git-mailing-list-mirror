From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/2] sparse: Fix an "Using plain integer as NULL pointer"
 warning
Date: Sun, 11 Sep 2011 20:25:48 +0100
Message-ID: <4E6D0B3C.4050402@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 21:44:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2pwn-0004wR-SJ
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 21:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760393Ab1IKTns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 15:43:48 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:36290 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760370Ab1IKTnr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2011 15:43:47 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1R2pvx-0003gg-e6; Sun, 11 Sep 2011 19:43:46 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181184>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 kwset.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kwset.c b/kwset.c
index 956ae72..51b2ab6 100644
--- a/kwset.c
+++ b/kwset.c
@@ -674,7 +674,7 @@ cwexec (kwset_t kws, char const *text, size_t len, struct kwsmatch *kwsmatch)
      copy of the preceding main search loops. */
   if (lim - mch > kwset->maxd)
     lim = mch + kwset->maxd;
-  lmch = 0;
+  lmch = NULL;
   d = 1;
   while (lim - end >= d)
     {
-- 
1.7.6
