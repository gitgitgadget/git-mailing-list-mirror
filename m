From: henrik@austad.us
Subject: [PATCH 2/2] Be consistent in switch usage for tar
Date: Mon,  5 Jan 2009 16:25:37 +0100
Message-ID: <1231169137-32653-3-git-send-email-henrik@austad.us>
References: <1231169137-32653-1-git-send-email-henrik@austad.us>
 <1231169137-32653-2-git-send-email-henrik@austad.us>
Cc: Henrik Austad <henrik@austad.us>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 17:20:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJsBE-0003l0-2g
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 17:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbZAEQSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 11:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbZAEQSb
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 11:18:31 -0500
Received: from mail47.e.nsc.no ([193.213.115.47]:43197 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbZAEQSb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 11:18:31 -0500
X-Greylist: delayed 3170 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jan 2009 11:18:30 EST
Received: from januz.myftp.org (084202164248.customer.alfanett.no [84.202.164.248])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id n05FPalD013660;
	Mon, 5 Jan 2009 16:25:38 +0100 (MET)
Received: by januz.myftp.org (Postfix, from userid 1000)
	id 7B385140DA; Mon,  5 Jan 2009 16:25:37 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc2
In-Reply-To: <1231169137-32653-2-git-send-email-henrik@austad.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104583>

From: Henrik Austad <henrik@austad.us>

tar handles switches with and witouth preceding '-', but the documentation should be
consistent nonetheless.

Signed-off-by: Henrik Austad <henrik@austad.us>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 5242a7e..19f571a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1009,7 +1009,7 @@ $ git init
 If you have some initial content (say, a tarball):
 
 -------------------------------------------------
-$ tar -xzvf project.tar.gz
+$ tar xzvf project.tar.gz
 $ cd project
 $ git init
 $ git add . # include everything below ./ in the first commit:
-- 
1.6.1.36.g8430e
