From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 0/2] Update 'git remote set-head' doc and uasage
Date: Sat, 21 Sep 2013 16:51:44 +0100
Message-ID: <1379778706-5664-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 21 17:51:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNPSn-0000AV-Qq
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 17:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329Ab3IUPur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 11:50:47 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:27069 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751929Ab3IUPuq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Sep 2013 11:50:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsGAH6/PVJOl3GZ/2dsb2JhbABbgwcBrlaMb4cjgRoXdIMCIxiBAiSIHLpgj2WEJQOpc4MlOw
X-IPAS-Result: AvsGAH6/PVJOl3GZ/2dsb2JhbABbgwcBrlaMb4cjgRoXdIMCIxiBAiSIHLpgj2WEJQOpc4MlOw
X-IronPort-AV: E=Sophos;i="4.90,953,1371078000"; 
   d="scan'208";a="437596664"
Received: from host-78-151-113-153.as13285.net (HELO localhost) ([78.151.113.153])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 21 Sep 2013 16:50:44 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235127>

In Junio's recent patch series ([PATCH v3 0/7] Removing the guesswork
of HEAD in "clone" $gmane/234950), his first patch updated t5505: 'fix
"set-head --auto with ambiguous HEAD" test'.

A quick look at the git remote man page showed that --auto was not
documented, nor listed in usage stings.

This two patch series fixes the documentation and the usage strings.

Philip Oakley (2):
  Doc: remote set-head long options
  remote set-head: show long options in usage

 Documentation/git-remote.txt | 6 +++---
 builtin/remote.c             | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.8.1.msysgit.1
