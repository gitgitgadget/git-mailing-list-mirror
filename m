From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH 0/2] git checkout: one bugfix and one cosmetic change
Date: Sun, 15 Mar 2009 12:38:54 +0100
Message-ID: <cover.1237115791.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 15 12:40:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Liohk-0001dx-5W
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 12:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694AbZCOLjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 07:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755417AbZCOLjB
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 07:39:01 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:57828 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506AbZCOLjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 07:39:00 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KGJ00A7VPOX1PA0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 15 Mar 2009 12:38:57 +0100 (CET)
Received: from localhost.localdomain ([80.203.106.191])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KGJ001V7POXJX50@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 15 Mar 2009 12:38:57 +0100 (CET)
X-Mailer: git-send-email 1.6.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113285>

Just one small bugfix patch, and one small cosmetic change.

By the way, I wonder how often the list of 'Primary Authors' and
'Contributors' on the webpage http://git-scm.com/about is updated.
Should'nt it be updated when a new release, like v1.6.2, is made?

Kjetil Barvik (2):
  checkout bugfix: use stat.mtime instead of stat.ctime in two places
  make the ST_{C,M}TIME_NSEC macros more function like
