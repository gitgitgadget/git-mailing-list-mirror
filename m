From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH 1/2] gitattributes: Document built in hunk header patterns
Date: Tue, 12 Aug 2008 16:24:25 +0200
Message-ID: <1218551066-13012-1-git-send-email-hendeby@isy.liu.se>
Cc: Gustaf Hendeby <hendeby@isy.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 16:25:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSuoh-00066H-PS
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 16:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbYHLOYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 10:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYHLOYa
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 10:24:30 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:37678 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbYHLOYa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 10:24:30 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 67DE725A69
	for <git@vger.kernel.org>; Tue, 12 Aug 2008 16:24:28 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 20156-01; Sun, 31 Dec 1967 01:00:02 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id A90C225A53;
	Tue, 12 Aug 2008 16:24:26 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 4E73E2ED78; Tue, 12 Aug 2008 16:24:26 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc2.37.gbb9f5.dirty
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92099>

Since the hunk header pattern text was written patterns for Ruby and
Pascal/Delphi have been added.  For users to be able to find them they
should be documented not only in code.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---

Would it maybe be a good idea to also link to this information in the
git diff documentation?  At the moment I can't find any documentation
about hunk headers and hunk header patterns at all in the diff
documentation.  The git diff documentation is the first place I would
look for that kind of information.  OTOH, the diff documentation is
already quite lengthy and I'm not really found of making it even
longer.  Oppinions how this nice feature should best be made generally
known?

/Gustaf

 Documentation/gitattributes.txt |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index d7b4114..c61a58d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -307,9 +307,16 @@ backslash, and zero or more occurrences of `sub` followed by
 There are a few built-in patterns to make this easier, and `tex`
 is one of them, so you do not have to write the above in your
 configuration file (you still need to enable this with the
-attribute mechanism, via `.gitattributes`).  Another built-in
-pattern is defined for `java` that defines a pattern suitable
-for program text in Java language.
+attribute mechanism, via `.gitattributes`).  The following built in
+patterns are available:
+
+- `java` suitable for source code in the Java lanugage.
+
+- `pascal` suitable for source code in the Pascal/Delphi language.
+
+- `ruby` suitable for source code in the Ruby language.
+
+- `tex` suitable for source code for LaTeX documents.
 
 
 Performing a three-way merge
-- 
1.6.0.rc2.30.gf3f0.dirty
