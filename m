From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] Fix section about backdating tags in the git-tag docs
Date: Fri, 11 Apr 2008 22:52:07 +0200
Message-ID: <20080411205207.GA18531@atjola.homenet>
References: <loom.20080411T193913-700@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Eric Blake <ebb9@byu.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 22:53:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkQF6-0004YE-AK
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 22:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759689AbYDKUwT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Apr 2008 16:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759587AbYDKUwT
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 16:52:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:52814 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759539AbYDKUwS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 16:52:18 -0400
Received: (qmail invoked by alias); 11 Apr 2008 20:52:16 -0000
Received: from i577BBFE2.versanet.de (EHLO atjola.local) [87.123.191.226]
  by mail.gmx.net (mp022) with SMTP; 11 Apr 2008 22:52:16 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/DbEZiX93DvESwKJTAyeg+raYhzO4IWh49n9Tv2m
	kfYTSTDISwBHuv
Content-Disposition: inline
In-Reply-To: <loom.20080411T193913-700@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79296>

The tagger is equal to the committer, not the author, so
GIT_COMMITTER_DATE is the right environment variable to use, not
GIT_AUTHOR_DATE.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
 Documentation/git-tag.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 4b6fd90..9712392 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -233,14 +233,14 @@ the tag object affects, for example, the ordering=
 of tags in the
 gitweb interface.
=20
 To set the date used in future tag objects, set the environment
-variable GIT_AUTHOR_DATE to one or more of the date and time.  The
+variable GIT_COMMITTER_DATE to one or more of the date and time.  The
 date and time can be specified in a number of ways; the most common
 is "YYYY-MM-DD HH:MM".
=20
 An example follows.
=20
 ------------
-$ GIT_AUTHOR_DATE=3D"2006-10-02 10:31" git tag -s v1.0.1
+$ GIT_COMMITTER_DATE=3D"2006-10-02 10:31" git tag -s v1.0.1
 ------------
=20
=20
--=20
1.5.5.rc3.7.gba133
