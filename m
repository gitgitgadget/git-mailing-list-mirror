From: Csaba Kiraly <kiraly@disi.unitn.it>
Subject: [PATCH 2/2] git-gui: improve gui.maxfilesdisplayed popup message
Date: Thu, 23 Oct 2014 15:39:25 +0200
Message-ID: <5449050D.9010503@disi.unitn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Dan Zwell <dzwell@zwell.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Csaba Kiraly <kiraly@fbk.eu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 15:44:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhIge-00049X-HF
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 15:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbaJWNoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 09:44:06 -0400
Received: from mail3.unitn.it ([193.205.206.24]:52453 "EHLO mail3.unitn.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbaJWNoD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 09:44:03 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Oct 2014 09:44:03 EDT
Received: from mail3.unitn.it (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id E7406C066B_4490510B;
	Thu, 23 Oct 2014 13:39:28 +0000 (GMT)
Received: from mailhub1.unitn.it (mailhub1.unitn.it [192.168.206.46])
	by mail3.unitn.it (Sophos Email Appliance) with ESMTP id 8179DBBDFD_4490510F;
	Thu, 23 Oct 2014 13:39:28 +0000 (GMT)
Received: from disi.unitn.it (brenta.dit.unitn.it [193.205.194.4])
	by mailhub1.unitn.it (Postfix) with ESMTP id 647B6AE5468;
	Thu, 23 Oct 2014 15:39:28 +0200 (CEST)
Received: by disi.unitn.it  with ESMTP id s9NDdQb5012922;Thu, 23 Oct 2014 15:39:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Csaba Kiraly <kiraly@disi.unitn.it>
---
 git-gui.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index f86a948..211f57f 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1977,7 +1977,7 @@ proc display_all_files {} {
 			if {!$files_warning} {
 				# do not repeatedly warn:
 				set files_warning 1
-				info_popup [mc "Displaying only %s of %s files." \
+				info_popup [mc "Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files." \
 					$display_limit [llength $to_display]]
 			}
 			continue
-- 
1.9.1
