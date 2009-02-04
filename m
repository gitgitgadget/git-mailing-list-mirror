From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: [PATCH] urls.txt: document optional port specification in git URLS
Date: Wed,  4 Feb 2009 12:51:35 +0100
Message-ID: <1233748295-4554-1-git-send-email-stefan.naewe@atlas-elektronik.com>
Cc: gitster@pobox.com, Stefan Naewe <stefan.naewe@atlas-elektronik.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 13:14:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUgdu-0000Pf-4p
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 13:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbZBDMMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 07:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbZBDMMo
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 07:12:44 -0500
Received: from lxsrv96.atlas.de ([194.156.172.86]:33417 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbZBDMMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 07:12:43 -0500
X-Greylist: delayed 1263 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Feb 2009 07:12:43 EST
Received: from vssrv01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with SMTP id 496B8138A9;
	Wed,  4 Feb 2009 12:51:36 +0100 (CET)
Received: from mgsrv01.atlas.de ([10.200.101.16])
 by vssrv01.atlas.de (SMSSMTP 4.1.9.35) with SMTP id M2009020412515231113
 ; Wed, 04 Feb 2009 12:51:52 +0100
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 16C7A2716C;
	Wed,  4 Feb 2009 12:51:36 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_20
	autolearn=disabled version=3.2.5
Received: from as100897.atlas.de (as100897.atlas.de [141.200.51.220])
	by mail01.atlas.de (Postfix) with ESMTP id 0E46E2716A;
	Wed,  4 Feb 2009 12:51:36 +0100 (CET)
Received: by as100897.atlas.de (Postfix, from userid 1000)
	id F069314075; Wed,  4 Feb 2009 12:51:35 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108341>

Signed-off-by: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
---
 Documentation/urls.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index fa34c67..c74f00b 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -8,8 +8,8 @@ to name the remote repository:
 - rsync://host.xz/path/to/repo.git/
 - http://host.xz/path/to/repo.git/
 - https://host.xz/path/to/repo.git/
-- git://host.xz/path/to/repo.git/
-- git://host.xz/~user/path/to/repo.git/
+- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
+- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
-- 
1.6.1.2
