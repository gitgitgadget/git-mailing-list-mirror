From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Add test results directory to t/.gitignore
Date: Sun, 29 Jun 2008 16:47:56 -0400
Message-ID: <20080629204756.GA40329@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 23:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD45m-0006SE-IZ
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 23:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbYF2VEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 17:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbYF2VEK
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 17:04:10 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:54670 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYF2VEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 17:04:07 -0400
Received: from localhost.localdomain (c-75-75-94-94.hsd1.va.comcast.net [75.75.94.94])
	by silverinsanity.com (Postfix) with ESMTP id CFC881FFC023
	for <git@vger.kernel.org>; Sun, 29 Jun 2008 20:47:51 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86833>

We don't need test results to be committed if we're fixing a test.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 t/.gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/.gitignore b/t/.gitignore
index 11ffd91..b27e280 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -1 +1,2 @@
 /trash directory
+/test-results
-- 
1.5.6.105.g6f4b
