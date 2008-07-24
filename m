From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH] document that git-tag can tag more than heads
Date: Thu, 24 Jul 2008 00:01:34 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807240000470.23113@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 07:02:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLsyK-00033l-Iq
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 07:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbYGXFBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 01:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbYGXFBg
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 01:01:36 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:57037 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbYGXFBf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 01:01:35 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6O51YIa013103
	for <git@vger.kernel.org>; Thu, 24 Jul 2008 00:01:35 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6O51Ysd023126
	for <git@vger.kernel.org>; Thu, 24 Jul 2008 00:01:34 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After looking the git-tag manpage, someone on #git wondered how
to tag a commit that is not a branch head.  This patch changes
the synopsis to say "<commit-ish> | <object>" instead of
"<head>" to address his question.

Samuel Bronson had the idea of putting "<commit-ish> | <object>"
for "<object>" because most tags point to commits (and for the
rest of the manpage, all tags point to commits).

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-tag.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index b8dc88f..1ce1d7d 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,7 +9,8 @@ git-tag - Create, list, delete or verify a tag object signed with GPG
 SYNOPSIS
 --------
 [verse]
-'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]  <name> [<head>]
+'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
+	<name> [<commit-ish> | <object>]
 'git tag' -d <name>...
 'git tag' [-n[<num>]] -l [<pattern>]
 'git tag' -v <name>...
-- 
1.5.6.3.549.g8ca11
