From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-rebase.sh: Update USAGE string (No. 1)
Date: Mon, 04 Feb 2008 01:33:38 +0200
Organization: Private
Message-ID: <ir15399p.fsf@blue.sea.net>
References: <prvd3i9e.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 00:34:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLoMP-0003SB-P9
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 00:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbYBCXeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 18:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbYBCXeV
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 18:34:21 -0500
Received: from main.gmane.org ([80.91.229.2]:34443 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753407AbYBCXeU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 18:34:20 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JLoLo-0001Y0-SN
	for git@vger.kernel.org; Sun, 03 Feb 2008 23:34:16 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 23:34:16 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 23:34:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:X3OUIHunfaENtU+UGfS22k4zBIU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72421>

Present the options in -s|--long (short, long) order.
Mention merge and new whitespace option.

ed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 ***********************************************************************
 Reworked patch (No. 1)

 [Jakub Narebski]
 > or break synopsis into lines 80-column lines max.

 ***********************************************************************

 git-rebase.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index bdcea0e..6805742 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,10 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--onto <newbase>] <upstream> [<branch>]'
+USAGE='[-i|--interactive] [-v|--verbose]
+[--whitespace={nowarn|warn|error|error-all|strip}]
+[-m|--merge] [--onto <newbase>] <upstream> [<branch>]'
+
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
-- 
1.5.4-rc5.GIT-dirty


-- 
Welcome to FOSS revolution: we fix and modify until it shines
