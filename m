From: Dirk Suesserott <newsletter@dirk.my1.cc>
Subject: [PATCH] gitk: Added option 'Simple history' to the options menu
Date: Thu,  7 May 2009 20:50:59 +0200
Message-ID: <12417222593716-git-send-email-newsletter@dirk.my1.cc>
Cc: Dirk Suesserott <newsletter@dirk.my1.cc>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 07 20:57:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M28mY-0004PN-FE
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 20:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346AbZEGS5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 14:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755741AbZEGS5N
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 14:57:13 -0400
Received: from smtprelay11.ispgateway.de ([80.67.31.45]:58152 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbZEGS5M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 14:57:12 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2009 14:57:12 EDT
Received: from [84.176.104.76] (helo=wurst.suesserott.de)
	by smtprelay11.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1M28gR-000304-6F; Thu, 07 May 2009 20:51:03 +0200
X-Mailer: git-send-email 1.5.3.mingw.1.142.g63611
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118504>

When clicked, the option --simplify-by-decoration is added to gitk/git log.
This yields to a simplified history where only decorated commits are shown,
i.e. those with a yellow tag or a green branch flag.

Signed-off-by: Dirk Suesserott <newsletter@dirk.my1.cc>
---
 gitk-git/gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1a7887b..f65cf2c 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3676,6 +3676,7 @@ set known_view_options {
     {all     b    * "--all"          {mc "Use all refs"}}
     {dorder  b    . {"--date-order" "-d"}      {mc "Strictly sort by date"}}
     {lright  b    . "--left-right"   {mc "Mark branch sides"}}
+    {smplhst b    . "--simplify-by-decoration"   {mc "Simple history"}}
     {since   t15  + {"--since=*" "--after=*"}  {mc "Since date:"}}
     {until   t15  . {"--until=*" "--before=*"} {mc "Until date:"}}
     {limit   t10  + "--max-count=*"  {mc "Max count:"}}
-- 
1.6.1.9.g97c34
