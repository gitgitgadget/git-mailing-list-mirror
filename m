From: Tony Finch <dot@dotat.at>
Subject: [PATCH 0/5] gitweb: improve directory hierarchy handling
Date: Thu, 31 Jul 2014 13:53:32 +0100
Message-ID: <alpine.LSU.2.00.1407311349190.23775@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 14:53:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCprW-0006s5-TX
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 14:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbaGaMxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 08:53:34 -0400
Received: from ppsw-40.csi.cam.ac.uk ([131.111.8.140]:43522 "EHLO
	ppsw-40.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaGaMxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 08:53:34 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:39071)
	by ppsw-40.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XCprR-00050w-jG (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 13:53:33 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XCprQ-0005iU-UG (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 13:53:32 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254564>

There are two main things in this little seris:

The second and third patches improve gitweb's project filter feature,
which is for listing just the projects in a subdirectory.

The fourth and fifth allow the admin to use a directory hierarchy
to automatically categorize projects in gitweb.

Tony Finch (5):
  gitweb: fix typo in man page
  gitweb: if the PATH_INFO is incomplete, use it as a project_filter
  gitweb: add a link under the search box to clear a project filter
  gitweb: optionally set project category from its pathname
  gitweb: make category headings into links when they are directories

 Documentation/gitweb.conf.txt |  8 +++++-
 gitweb/gitweb.perl            | 62 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 59 insertions(+), 11 deletions(-)

-- 
2.1.0.rc0.229.gaee38de
