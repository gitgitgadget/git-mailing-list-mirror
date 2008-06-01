From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] glossary: improve a few links
Date: Sun,  1 Jun 2008 20:15:33 +0200
Message-ID: <1212344133-3311-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 20:16:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2s6Y-0001ty-UI
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 20:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbYFASPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 14:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbYFASPi
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 14:15:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:35797 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbYFASPh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 14:15:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so554810fgg.17
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=rycASVDgEk/5O0uHB9OPeBU4jEurdBck412+0+St6zc=;
        b=cDbqMFSxcrC0gi/yhxfJlTooMOEIwhF/BDeVrnuf4sZYPcArek1zBPjkKgjnytvc6lqvrLLryFTBcIxJSSO7+PunejQqh64NMzvf/izx9FIjGmdZjN5jKB53N3x1gyGuh1RXo0DGklRhfk7a+xZ1WBcGh8HTmm+vLYf4c2UC7VE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=jqN9TW2OL0mRF52COq8NE3+6J4bjdX0EFWgF2qSOy9pf2bZXqenSmgioxUBbdlPmcCbcZLykYQH8iDgtF/oQACMCVWU1Z6pfdtuRIm/x91uDyko5/RTLP0GYW/5UHIhvcn/D87LCzKqqUdcTNFEpfKKffOEIUfjfoRzEBXkS8aA=
Received: by 10.86.96.18 with SMTP id t18mr4878326fgb.17.1212344135902;
        Sun, 01 Jun 2008 11:15:35 -0700 (PDT)
Received: from fly ( [91.33.205.25])
        by mx.google.com with ESMTPS id 13sm7912332fks.12.2008.06.01.11.15.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 11:15:35 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2s5d-0000rl-6Y; Sun, 01 Jun 2008 20:15:33 +0200
X-Mailer: git-send-email 1.5.5.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83455>

They now point to more specific/appropriate targets.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
 Documentation/glossary.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 51b6353..85178c3 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -90,11 +90,10 @@ to point at the new commit.
 	source code management tools.
 
 [[def_DAG]]DAG::
-	Directed acyclic graph. The <<def_commit,commit>> objects form a
+	Directed acyclic graph. The <<def_commit_object,commit objects>> form a
 	directed acyclic graph, because they have parents (directed), and the
-	graph of commit objects is acyclic (there is no
-	<<def_chain,chain>> which begins and ends with the same
-	<<def_object,object>>).
+	graph of commit objects is acyclic (there is no <<def_chain,chain>>
+	which begins and ends with the same <<def_object,object>>).
 
 [[def_dangling_object]]dangling object::
 	An <<def_unreachable_object,unreachable object>> which is not
@@ -250,9 +249,10 @@ This commit is referred to as a "merge commit", or sometimes just a
 	the <<def_hash,hash>> of the object.
 
 [[def_object_type]]object type::
-	One of the identifiers
-	"<<def_commit,commit>>","<<def_tree,tree>>","<<def_tag,tag>>" or "<<def_blob_object,blob>>"
-	describing the type of an <<def_object,object>>.
+	One of the identifiers "<<def_commit_object,commit>>",
+	"<<def_tree_object,tree>>", "<<def_tag_object,tag>>" or
+	"<<def_blob_object,blob>>" describing the type of an
+	<<def_object,object>>.
 
 [[def_octopus]]octopus::
 	To <<def_merge,merge>> more than two <<def_branch,branches>>. Also denotes an
-- 
1.5.5.GIT
