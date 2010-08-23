From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/3] git-bundle.txt: whitespace cleanup
Date: Mon, 23 Aug 2010 11:02:38 +0200
Message-ID: <af750e09280f8d5118e1d854fa839cb1a7c32579.1282553586.git.git@drmicha.warpmail.net>
References: <cover.1282553585.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 11:03:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnSwC-0002Eq-0J
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 11:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638Ab0HWJCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 05:02:48 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60778 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753604Ab0HWJCr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 05:02:47 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CBAE045C;
	Mon, 23 Aug 2010 05:02:46 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 23 Aug 2010 05:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=yzXKQSFT/4N5+Nh/x3du7wkvpHA=; b=YEtolbzxJg4NjXYpxyzmyOjjHF2Fe6VbIYb0/bRJxjl8T6033a6576237pUUUD0ZMzOxG5kpSqCIlu4VYjRhLtIA9pckhVrE1Fankhuj12iJwva2BtmeWFL3heWha/H25psdhOBzY2BGkkStuCcIq3bZZaIQ6NS8qTde/mB4Uxc=
X-Sasl-enc: DcWUBO/zEn+VYkCk4PF+Ufon7Au6wBDONuduRf4Wc13f 1282554166
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1E57F40A5D8;
	Mon, 23 Aug 2010 05:02:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.1.52.g7f7860
In-Reply-To: <cover.1282553585.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154212>

Use tabs, not 7 spaces.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-bundle.txt |   56 +++++++++++++++++++++---------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 2d92696..3cdbc72 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -34,45 +34,45 @@ OPTIONS
 -------
 
 create <file>::
-       Used to create a bundle named 'file'.  This requires the
-       'git-rev-list-args' arguments to define the bundle contents.
+	Used to create a bundle named 'file'.  This requires the
+	'git-rev-list-args' arguments to define the bundle contents.
 
 verify <file>::
-       Used to check that a bundle file is valid and will apply
-       cleanly to the current repository.  This includes checks on the
-       bundle format itself as well as checking that the prerequisite
-       commits exist and are fully linked in the current repository.
-       'git bundle' prints a list of missing commits, if any, and exits
-       with a non-zero status.
+	Used to check that a bundle file is valid and will apply
+	cleanly to the current repository.  This includes checks on the
+	bundle format itself as well as checking that the prerequisite
+	commits exist and are fully linked in the current repository.
+	'git bundle' prints a list of missing commits, if any, and exits
+	with a non-zero status.
 
 list-heads <file>::
-       Lists the references defined in the bundle.  If followed by a
-       list of references, only references matching those given are
-       printed out.
+	Lists the references defined in the bundle.  If followed by a
+	list of references, only references matching those given are
+	printed out.
 
 unbundle <file>::
-       Passes the objects in the bundle to 'git index-pack'
-       for storage in the repository, then prints the names of all
-       defined references. If a list of references is given, only
-       references matching those in the list are printed. This command is
-       really plumbing, intended to be called only by 'git fetch'.
+	Passes the objects in the bundle to 'git index-pack'
+	for storage in the repository, then prints the names of all
+	defined references. If a list of references is given, only
+	references matching those in the list are printed. This command is
+	really plumbing, intended to be called only by 'git fetch'.
 
 <git-rev-list-args>::
-       A list of arguments, acceptable to 'git rev-parse' and
-       'git rev-list', that specifies the specific objects and references
-       to transport.  For example, `master{tilde}10..master` causes the
-       current master reference to be packaged along with all objects
-       added since its 10th ancestor commit.  There is no explicit
-       limit to the number of references and objects that may be
-       packaged.
+	A list of arguments, acceptable to 'git rev-parse' and
+	'git rev-list', that specifies the specific objects and references
+	to transport.  For example, `master{tilde}10..master` causes the
+	current master reference to be packaged along with all objects
+	added since its 10th ancestor commit.  There is no explicit
+	limit to the number of references and objects that may be
+	packaged.
 
 
 [refname...]::
-       A list of references used to limit the references reported as
-       available. This is principally of use to 'git fetch', which
-       expects to receive only those references asked for and not
-       necessarily everything in the pack (in this case, 'git bundle' acts
-       like 'git fetch-pack').
+	A list of references used to limit the references reported as
+	available. This is principally of use to 'git fetch', which
+	expects to receive only those references asked for and not
+	necessarily everything in the pack (in this case, 'git bundle' acts
+	like 'git fetch-pack').
 
 SPECIFYING REFERENCES
 ---------------------
-- 
1.7.2.1.52.g7f7860
