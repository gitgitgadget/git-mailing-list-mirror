From: Lars Noschinski <lars@public.noschinski.de>
Subject: Some cvs related fixes and enhancements v2
Date: Thu, 17 Jul 2008 19:00:25 +0200
Message-ID: <1216314030-10887-1-git-send-email-lars@public.noschinski.de>
Cc: lars@public.noschinski.de, fabian.emmes@rwth-aachen.de
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 17 19:02:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJWrh-0000Xh-DH
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 19:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757424AbYGQRAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 13:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757474AbYGQRAp
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 13:00:45 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:59523 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757424AbYGQRAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 13:00:38 -0400
Received: from [137.226.194.201] (helo=localhost.localdomain)
	by smtprelay09.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1KJWqK-0007Q9-4U; Thu, 17 Jul 2008 19:00:36 +0200
X-Mailer: git-send-email 1.5.6.2
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88885>


This patch series

    - fixes a small bug in the cvsimport testsuite
    - adds support for packed-refs to cvsserver
    - adds basic support cvs co -c to cvsserver

Changes to v1:

    - do not change output format of req_up (noticed by Johannes Schindelxein)
    - test output of the cvs client instead of raw server output
    - remove superfluous line from the "cvs co -c" patch

---
 git-cvsserver.perl              |   34 ++++++++++++++++++++--------------
 t/t9400-git-cvsserver-server.sh |   18 ++++++++++++++++++
 t/t9600-cvsimport.sh            |    1 +
 3 files changed, 39 insertions(+), 14 deletions(-)
