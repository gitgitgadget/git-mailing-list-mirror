From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH] Unify the argument of the parameter -m
Date: Sun,  3 Feb 2008 00:58:07 +0100
Message-ID: <1201996688-5559-2-git-send-email-joerg@alea.gnuu.de>
References: <1201996688-5559-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 11:34:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLcBc-0000IH-Lh
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 11:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbYBCKeW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2008 05:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbYBCKeV
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 05:34:21 -0500
Received: from banki.eumelnet.de ([83.246.114.63]:2814 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbYBCKeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 05:34:19 -0500
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id D1BB3488043; Sun,  3 Feb 2008 11:00:17 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JLbX7-0001St-E8
	for git@vger.kernel.org; Sun, 03 Feb 2008 10:53:05 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JLSFM-0001oM-L4; Sun, 03 Feb 2008 00:58:08 +0100
X-Mailer: git-send-email 1.5.4.rc5
In-Reply-To: <1201996688-5559-1-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72344>

In the text, the agument of -m is <master> which should be used in the
command synopsis, too.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 Documentation/git-remote.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.tx=
t
index 10f6fa5..2cbd1f7 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-remote'
-'git-remote' add [-t <branch>] [-m <branch>] [-f] [--mirror] <name> <u=
rl>
+'git-remote' add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <u=
rl>
 'git-remote' rm <name>
 'git-remote' show <name>
 'git-remote' prune <name>
--=20
1.5.4.rc5
