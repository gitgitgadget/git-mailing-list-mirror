From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH 2/4] Documentation: push.default applies to all remotes
Date: Sun, 29 Mar 2009 00:10:02 +0100
Message-ID: <1238281804-30290-3-git-send-email-santi@agolina.net>
References: <1238281804-30290-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 00:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnhhM-00033N-0M
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 00:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679AbZC1XK2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 19:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754369AbZC1XKZ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 19:10:25 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59133 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbZC1XKX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 19:10:23 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so1483335fxm.37
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 16:10:21 -0700 (PDT)
Received: by 10.103.11.5 with SMTP id o5mr1006653mui.132.1238281821435;
        Sat, 28 Mar 2009 16:10:21 -0700 (PDT)
Received: from localhost (p5B0D7403.dip.t-dialin.net [91.13.116.3])
        by mx.google.com with ESMTPS id s10sm5863028muh.52.2009.03.28.16.10.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Mar 2009 16:10:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.258.g7ff14
In-Reply-To: <1238281804-30290-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114989>

push.default is not only for the current remote but setting the default
behaviour for all remotes.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 Documentation/config.txt |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 56f0cd7..07f88f5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1219,19 +1219,14 @@ push.default::
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
