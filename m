From: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv3 1/2] git-rebase.txt: "--onto" option updated
Date: Fri,  8 Jun 2012 16:53:54 +0200
Message-ID: <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 16:54:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd0Zl-0001Hr-VH
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 16:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760868Ab2FHOyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 10:54:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49491 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760739Ab2FHOyA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 10:54:00 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q58EjBRt002556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 16:45:11 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q58Ertu6011537;
	Fri, 8 Jun 2012 16:53:55 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q58Ert7Y002351;
	Fri, 8 Jun 2012 16:53:55 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q58ErtlS002350;
	Fri, 8 Jun 2012 16:53:55 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 08 Jun 2012 16:45:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q58EjBRt002556
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339771513.13995@nwawLwCGqgzBxlH2CgcUrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199497>

The description of the option "--onto" is changed to be consistent
with the format of the other options.

Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 Documentation/git-rebase.txt |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 147fa1a..d2a510c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -210,11 +210,13 @@ rebase.autosquash::
 
 OPTIONS
 -------
-<newbase>::
-	Starting point at which to create the new commits. If the
-	--onto option is not specified, the starting point is
-	<upstream>.  May be any valid commit, and not just an
-	existing branch name.
+--onto <newbase>::
+	With this option, git rebase takes all commits from <branch>,
+	that are not in <upstream>, and transplants them on top of
+	<newbase>. <newbase is the starting point at which to create
+	the new commits. If the --onto option is not specified, the
+	starting point is <upstream>.  May be any valid commit, and
+	not just an existing branch name.
 +
 As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
-- 
1.7.8
