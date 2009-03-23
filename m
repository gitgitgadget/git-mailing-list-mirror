From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH] Documentation: push.default applies to all remotes
Date: Tue, 24 Mar 2009 00:18:38 +0100
Message-ID: <1237850318-3671-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 00:20:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LltRR-0000gm-Gp
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 00:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842AbZCWXSz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 19:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754406AbZCWXSz
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 19:18:55 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:61946 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbZCWXSy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 19:18:54 -0400
Received: by bwz17 with SMTP id 17so1990854bwz.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 16:18:51 -0700 (PDT)
Received: by 10.103.244.19 with SMTP id w19mr3310808mur.134.1237850331403;
        Mon, 23 Mar 2009 16:18:51 -0700 (PDT)
Received: from localhost (p5B0D79B5.dip.t-dialin.net [91.13.121.181])
        by mx.google.com with ESMTPS id e9sm10895257muf.38.2009.03.23.16.18.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 16:18:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.258.g7ff14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114359>

push.default is not only for the current remote but setting the default
behavior for all remotes.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
Hi,

  this applies on top of next.

 Documentation/config.txt |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 089569a..7f5fe43 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1215,19 +1215,14 @@ push.default::
 	Defines the action git push should take if no refspec is given
 	on the command line, no refspec is configured in the remote, and
 	no refspec is implied by any of the options given on the command
-	line.
-+
-The term `current remote` means the remote configured for the current
-branch, or `origin` if no remote is configured. `origin` is also used
-if you are not on any branch. Possible values are:
+	line. Possible values are:
 +
 * `nothing` do not push anything.
-* `matching` push all matching branches to the current remote.
+* `matching` push all matching branches.
   All branches having the same name in both ends are considered to be
   matching. This is the current default value.
 * `tracking` push the current branch to the branch it is tracking.
-* `current` push the current branch to a branch of the same name on th=
e
-  current remote.
+* `current` push the current branch to a branch of the same name.
=20
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
--=20
1.6.1.258.g7ff14
