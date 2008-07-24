From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH v2] document that git-tag can tag more than heads
Date: Thu, 24 Jul 2008 11:55:25 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807241148210.14325@harper.uchicago.edu>
References: <Pine.GSO.4.62.0807240000470.23113@harper.uchicago.edu>
 <87prp3652z.fsf@Astalo.kon.iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:56:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM47J-0007Oa-48
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 18:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbYGXQzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 12:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYGXQzh
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 12:55:37 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:55916 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbYGXQzg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 12:55:36 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6OGtPeW030590;
	Thu, 24 Jul 2008 11:55:25 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6OGtPlq014662;
	Thu, 24 Jul 2008 11:55:25 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <87prp3652z.fsf@Astalo.kon.iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89911>

After looking the git-tag manpage, someone on #git wondered how
to tag a commit that is not a branch head.  This patch changes
the synopsis to say "<commit> | <object>" instead of "<head>" to
address his question.

Samuel Bronson had the idea of putting "<commit> | <object>"
for "<object>" because most tags point to commits (and for the
rest of the manpage, all tags point to commits).

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Kalle Olavi Niemitalo wrote:

 > git-tag does not automatically dereference tag objects that
 > point to a commit.  So if you want to use "|", then it should be
 > "<commit> | <object>".

 Nice catch -- thanks.

 Documentation/git-tag.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index b8dc88f..046ab35 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,7 +9,8 @@ git-tag - Create, list, delete or verify a tag object signed with GPG
 SYNOPSIS
 --------
 [verse]
-'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]  <name> [<head>]
+'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
+	<name> [<commit> | <object>]
 'git tag' -d <name>...
 'git tag' [-n[<num>]] -l [<pattern>]
 'git tag' -v <name>...
-- 
1.5.6.3.549.g8ca11
