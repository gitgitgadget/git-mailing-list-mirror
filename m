From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-rebase.sh: Update USAGE string
Date: Sun, 03 Feb 2008 22:19:25 +0200
Organization: Private
Message-ID: <prvd3i9e.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 21:21:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLlKr-0000ba-8e
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 21:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbYBCUUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 15:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbYBCUUc
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 15:20:32 -0500
Received: from main.gmane.org ([80.91.229.2]:48196 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbYBCUUb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 15:20:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JLlKD-00014O-CG
	for git@vger.kernel.org; Sun, 03 Feb 2008 20:20:25 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 20:20:25 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 20:20:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:JXEDocBN72aMsCY4eBYsKACXMTw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72399>

Present the options in -s|--long (short, long) order.
Mention merge and new whitespace option.

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index bdcea0e..9c8cf90 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--onto <newbase>] <upstream> [<branch>]'
+USAGE='[-i|--interactive] [-v|--verbose] [--whitespace={nowarn|warn|error|error-all|strip}] [-m|--merge] [--onto <newbase>] <upstream> [<branch>]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
-- 
1.5.4-rc5.GIT-dirty



-- 
Welcome to FOSS revolution: we fix and modify until it shines
