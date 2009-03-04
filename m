From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH 0/2] some few more 'git checkout' improvements
Date: Wed, 04 Mar 2009 18:47:38 +0100
Message-ID: <cover.1236187259.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 18:49:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LevDU-0000US-Ve
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 18:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbZCDRro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 12:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbZCDRrn
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 12:47:43 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:44530 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbZCDRrn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 12:47:43 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFZ00CFBTFGM710@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Mar 2009 18:47:40 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.182])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KFZ00BZKTFGLP50@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Mar 2009 18:47:40 +0100 (CET)
X-Mailer: git-send-email 1.6.1.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112229>

- one bugfix (I hope)
- and one patch to make life easier when using the USE_NSEC define

These 2 patches is based on 'next' because patch 2/2 is based on one
previous patch, which is only in 'next' for the moment.

Kjetil Barvik (2):
  stat_tracking_info(): only count real commits
  better introduction of GIT with USE_NSEC defined

 read-cache.c   |   23 +----------------------
 remote.c       |    3 ++-
 unpack-trees.c |    2 --
 3 files changed, 3 insertions(+), 25 deletions(-)
