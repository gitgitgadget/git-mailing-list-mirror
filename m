From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Fix typo in contrib/examples/git-svnimport.txt
Date: Wed, 25 Feb 2009 15:05:17 +0100
Message-ID: <1235570717-19924-1-git-send-email-git@drmicha.warpmail.net>
References: <1235567065-7639-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 15:07:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcKPX-0008CS-S8
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 15:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbZBYOF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 09:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbZBYOF1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 09:05:27 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56803 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751629AbZBYOF1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 09:05:27 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 2C1562A5CC8;
	Wed, 25 Feb 2009 09:05:25 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 25 Feb 2009 09:05:25 -0500
X-Sasl-enc: OAVAOXiCT6D+bXy/j6W9EzwMZi1GyfRaP6svT/EysHv+ 1235570724
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8E5F422C1D;
	Wed, 25 Feb 2009 09:05:24 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc1.30.gd43c
In-Reply-To: <1235567065-7639-1-git-send-email-vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111458>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
If we fix it then why not do it right ;)

 contrib/examples/git-svnimport.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/examples/git-svnimport.txt b/contrib/examples/git-svnimport.txt
index 71aad8b..3bb871e 100644
--- a/contrib/examples/git-svnimport.txt
+++ b/contrib/examples/git-svnimport.txt
@@ -114,9 +114,9 @@ due to SVN memory leaks. (These have been worked around.)
 -R <repack_each_revs>::
 	Specify how often git repository should be repacked.
 +
-The default value is 1000. git-svnimport will do import in chunks of 1000
-revisions, after each chunk git repository will be repacked. To disable
-this behavior specify some big value here which is mote than number of
+The default value is 1000. git-svnimport will do imports in chunks of 1000
+revisions, after each chunk the git repository will be repacked. To disable
+this behavior specify some large value here which is greater than the number of
 revisions to import.
 
 -P <path_from_trunk>::
-- 
1.6.2.rc1.30.gd43c
