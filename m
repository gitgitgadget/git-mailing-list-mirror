From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv2 2/4] Documentation: push.default applies to all remotes
Date: Mon, 30 Mar 2009 12:11:41 +0200
Message-ID: <1238407903-28020-3-git-send-email-santi@agolina.net>
References: <1238407903-28020-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 12:15:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoEW0-0007Mz-IA
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 12:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758689AbZC3KMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 06:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758687AbZC3KMI
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 06:12:08 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:10054 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758647AbZC3KMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 06:12:07 -0400
Received: by fk-out-0910.google.com with SMTP id 18so838412fkq.5
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 03:12:04 -0700 (PDT)
Received: by 10.223.107.199 with SMTP id c7mr3786953fap.31.1238407924456;
        Mon, 30 Mar 2009 03:12:04 -0700 (PDT)
Received: from localhost (p5B0D60BE.dip.t-dialin.net [91.13.96.190])
        by mx.google.com with ESMTPS id z15sm2241671fkz.11.2009.03.30.03.12.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 03:12:04 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.258.g7ff14
In-Reply-To: <1238407903-28020-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115131>

push.default is not only for the current remote but setting the default
behaviour for all remotes.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 Documentation/config.txt |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fa2595b..7ae584f 100644
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
