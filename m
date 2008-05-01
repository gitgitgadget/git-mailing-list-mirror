From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: hooks: fix missing verb in pre-applypatch
 description
Date: Thu, 1 May 2008 10:17:59 +0200
Message-ID: <20080501101759.0f40268e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>
X-From: git-owner@vger.kernel.org Thu May 01 10:13:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrTvL-0004Rj-OU
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 10:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbYEAINE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2008 04:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753703AbYEAINB
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 04:13:01 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36844 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908AbYEAIM7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2008 04:12:59 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BD71A1AB2F4;
	Thu,  1 May 2008 10:12:57 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 30B3D1AB2CF;
	Thu,  1 May 2008 10:12:56 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80893>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/githooks.txt |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

	Manoj Srivastava a =E9crit :
	>         I am afraid I can't parse the final sentence: I assume it me=
ans
	>  that the patched working tree is not committed, but the missing ver=
b
	>  makes it harder for non-native speakers of the english language to
	>  understand what is meant here.

	Perhaps something like this patch would fix it.

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 62ee065..0ede1ac 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -40,10 +40,11 @@ The default 'applypatch-msg' hook, when enabled, ru=
ns the
 pre-applypatch
 --------------
=20
-This hook is invoked by `git-am`.  It takes no parameter,
-and is invoked after the patch is applied, but before a commit
-is made.  Exiting with non-zero status causes the working tree
-after application of the patch not committed.
+This hook is invoked by `git-am`.  It takes no parameter, and is
+invoked after the patch is applied, but before a commit is made.
+
+If it exits with non-zero status, then the working tree will not be
+committed after application of the patch.
=20
 It can be used to inspect the current working tree and refuse to
 make a commit if it does not pass certain test.
--=20
1.5.5.1.100.gc23d
