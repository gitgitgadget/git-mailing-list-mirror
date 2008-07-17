From: Lars Noschinski <lars@public.noschinski.de>
Subject: Some cvs related fixes and enhancements
Date: Thu, 17 Jul 2008 12:01:12 +0200
Message-ID: <1216288877-12140-1-git-send-email-lars@public.noschinski.de>
Cc: fabian.emmes@rwth-aachen.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 12:11:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJQSP-00074m-KI
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 12:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839AbYGQKK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 06:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755843AbYGQKK1
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 06:10:27 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:47625 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbYGQKK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 06:10:26 -0400
Received: from [137.226.194.201] (helo=localhost.localdomain)
	by smtprelay11.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1KJQIb-0007y9-Io; Thu, 17 Jul 2008 12:01:21 +0200
X-Mailer: git-send-email 1.5.6.2
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88828>


This patch series

    - fixes a small bug in the cvsimport testsuite
    - adds support for packed-refs to cvsserver
    - adds basic support cvs co -c to cvsserver

---
 git-cvsserver.perl              |   38 ++++++++++++++++++++++----------------
 t/t9400-git-cvsserver-server.sh |   25 +++++++++++++++++++++++++
 t/t9600-cvsimport.sh            |    1 +
 3 files changed, 48 insertions(+), 16 deletions(-)
