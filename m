From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] user-manual: fix clone and fetch typos
Date: Mon, 7 May 2007 23:34:26 -0400
Message-ID: <20070508033426.GD9471@fieldses.org>
References: <-1060540797535999820@unknownmsgid> <8aa486160705070027g2cb6797fy5acbe338e30429ff@mail.gmail.com> <20070508030732.GB9471@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 05:34:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlGTD-0000qi-48
	for gcvg-git@gmane.org; Tue, 08 May 2007 05:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966509AbXEHDea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 23:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966549AbXEHDea
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 23:34:30 -0400
Received: from mail.fieldses.org ([66.93.2.214]:46058 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966509AbXEHDe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 23:34:29 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HlGT4-0003n8-JV; Mon, 07 May 2007 23:34:26 -0400
Content-Disposition: inline
In-Reply-To: <20070508030732.GB9471@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46527>

More typo fixes from Santi B=E9jar, plus a couple other mistakes I noti=
ced
along the way.

Cc: Santi B=E9jar <sbejar@gmail.com>
Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index 67f5b9b..13db969 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1836,12 +1836,12 @@ Now, assume your personal repository is in the =
directory ~/proj.  We
 first create a new clone of the repository:
=20
 -------------------------------------------------
-$ git clone --bare proj.git
+$ git clone --bare ~/proj proj.git
 -------------------------------------------------
=20
-The resulting directory proj.git will contains a "bare" git
-repository--it is just the contents of the ".git" directory, without
-a checked-out copy of a working directory.
+The resulting directory proj.git contains a "bare" git repository--it =
is
+just the contents of the ".git" directory, without a checked-out copy =
of
+a working directory.
=20
 Next, copy proj.git to the server where you plan to host the
 public repository.  You can use scp, rsync, or whatever is most
@@ -2372,9 +2372,8 @@ $ git config remote.example.fetch master:refs/rem=
otes/example/master
 then the following commands will all do the same thing:
=20
 -------------------------------------------------
-$ git fetch git://example.com/proj.git master:ref/remotes/example/mast=
er
-$ git fetch example master:ref/remotes/example/master
-$ git fetch example example/master
+$ git fetch git://example.com/proj.git master:refs/remotes/example/mas=
ter
+$ git fetch example master:refs/remotes/example/master
 $ git fetch example
 -------------------------------------------------
=20
--=20
1.5.1.1.98.gedb4f
