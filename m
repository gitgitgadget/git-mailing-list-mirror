From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] Documentation: talk a little bit about
	GIT_NO_REPLACE_OBJECTS
Date: Thu, 19 Nov 2009 07:13:16 +0100
Message-ID: <20091119061317.3581.98979.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 07:20:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB0Nj-0001dc-L7
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 07:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbZKSGUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 01:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbZKSGUJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 01:20:09 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:57353 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbZKSGUH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 01:20:07 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1348C818019;
	Thu, 19 Nov 2009 07:20:04 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C277281809C;
	Thu, 19 Nov 2009 07:20:01 +0100 (CET)
X-git-sha1: 605e1acfd625496349a9a44fb1a3c2deb699b19c 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133214>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

	This patch should go in my series that introduced the
	GIT_NO_REPLACE_OBJECTS env variable.

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 69f704f..65a0da5 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -44,6 +44,9 @@ $ git cat-file commit foo
 
 shows information about commit 'bar'.
 
+The 'GIT_NO_REPLACE_OBJECTS' environment variable can be set to
+achieve the same effect as the `--no-replace-objects` option.
+
 OPTIONS
 -------
 -f::
-- 
1.6.5.1.gaf97d
