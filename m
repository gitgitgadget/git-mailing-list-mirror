From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH v4 3/5] git-reset.txt: better docs for '--patch'
Date: Thu,  5 May 2011 21:58:18 +0200
Message-ID: <1304625498-23475-1-git-send-email-valentin.haenel@gmx.de>
References: <7v7ha56jh4.fsf@alter.siamese.dyndns.org>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 21:59:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4hi-0003bP-Ql
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab1EET7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 15:59:14 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:58979 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab1EET7N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 15:59:13 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p45JwjBf023528;
	Thu, 5 May 2011 21:58:45 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p45Jwjih023527;
	Thu, 5 May 2011 21:58:45 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7v7ha56jh4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172896>

Describe '-p' as a short form of '--patch' in synopsis. Also include a better
explanation of this option and additionally refer the reader to the patch mode
description of git-add documentation.

Helped-by: Jeff King <peff@peff.net>
Mentored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
---

Reworded the option description, turned the bullet points in the commit-message
into proper sentences, and fixed the sign-off-chain. Sending only patch 3/5 of
v4 since the others have already been queued.

 Documentation/git-reset.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 8481f9d..82001f2 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git reset' [-q] [<commit>] [--] <paths>...
-'git reset' --patch [<commit>] [--] [<paths>...]
+'git reset' --patch|-p [<commit>] [--] [<paths>...]
 'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
@@ -39,8 +39,9 @@ working tree in one go.
 	and <commit> (defaults to HEAD).  The chosen hunks are applied
 	in reverse to the index.
 +
-This means that `git reset -p` is the opposite of `git add -p` (see
-linkgit:git-add[1]).
+This means that `git reset -p` is the opposite of `git add -p`, i.e.
+you can use it to selectively reset hunks. See the ``Interactive Mode''
+section of linkgit:git-add[1] to learn how to operate the `\--patch` mode.
 
 'git reset' [--<mode>] [<commit>]::
 	This form resets the current branch head to <commit> and
-- 
1.7.1
