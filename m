From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] gitk: use UTF-8 encoding
Date: Wed, 05 Oct 2005 22:12:48 -0400
Message-ID: <1128564768.32103.18.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 06 04:14:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENLFo-0001EB-RH
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 04:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVJFCMu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 22:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVJFCMu
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 22:12:50 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:53213 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750709AbVJFCMu
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 22:12:50 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1ENLFZ-0004CC-6K
	for git@vger.kernel.org; Wed, 05 Oct 2005 22:12:49 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1ENLFY-0001b7-7R; Wed, 05 Oct 2005 22:12:48 -0400
To: git <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9756>

gitk should try to use UTF-8 encoding for system operations, such as
reading and writing files and git output.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -3726,6 +3726,7 @@ set colors {green red blue magenta darkg
 
 catch {source ~/.gitk}
 
+catch {encoding system utf-8}
 set namefont $mainfont
 if {$boldnames} {
     lappend namefont bold


-- 
Regards,
Pavel Roskin
