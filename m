From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH] git-update-ref documentation: --no-deref can be used
 together with -d
Date: Wed, 7 Sep 2011 18:06:16 +0200
Message-ID: <20110907160616.GA28336@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 18:49:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1LJC-0003Ay-3y
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab1IGQsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:48:15 -0400
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:36450
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753901Ab1IGQsN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 12:48:13 -0400
X-Greylist: delayed 2520 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Sep 2011 12:48:13 EDT
Received: from pcpool01.mathematik.uni-freiburg.de ([132.230.30.151])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1R1Kdf-0005XT-SP
	for git@vger.kernel.org; Wed, 07 Sep 2011 18:06:11 +0200
Received: from brl by pcpool01.mathematik.uni-freiburg.de with local (Exim 4.72)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1R1Kdk-0007NO-3x
	for git@vger.kernel.org; Wed, 07 Sep 2011 18:06:16 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180869>

---
 Documentation/git-update-ref.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index d377a35..5da3691 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -8,7 +8,7 @@ git-update-ref - Update the object name stored in a ref safely
 SYNOPSIS
 --------
 [verse]
-'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>])
+'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<oldvalue>] | <ref> <newvalue> [<oldvalue>])
 
 DESCRIPTION
 -----------
-- 
1.7.2.5
