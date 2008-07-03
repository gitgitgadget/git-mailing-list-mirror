From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 05/15] git-commit(1): depersonalize description
Date: Thu, 3 Jul 2008 00:13:45 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807030008200.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>,
	Olivier Marin <dkr+ml.git@free.fr>,
	Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:02:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEIpd-0003HF-Pm
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbYGCG7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbYGCG54
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:56 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:55774 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769AbYGCFNt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 01:13:49 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m635Dk3u008766;
	Thu, 3 Jul 2008 00:13:46 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m635DjkJ018618;
	Thu, 3 Jul 2008 00:13:45 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87231>

The intent is to make git-commit(1) feel more like a manual page.  The
change also makes the page four words shorter.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-commit.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 03594cd..0ac6204 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -15,8 +15,8 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Use 'git commit' to store the current contents of the index in a new
-commit along with a log message describing the changes you have made.
+Stores the current contents of the index in a new commit along
+with a log message from the user describing the changes.
 
 The content to be added can be specified in several ways:
 
-- 
1.5.5.GIT
