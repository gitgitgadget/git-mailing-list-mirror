From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntax (2)
Date: Sat, 02 Feb 2008 16:03:48 +0200
Organization: Private
Message-ID: <tzkr4fqz.fsf_-_@blue.sea.net>
References: <7ihp802o.fsf@blue.sea.net> <ir185c73.fsf@blue.sea.net>
	<m3lk637j3k.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 15:06:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLIzY-000686-UL
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 15:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757446AbYBBOEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 09:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757534AbYBBOEg
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 09:04:36 -0500
Received: from main.gmane.org ([80.91.229.2]:42302 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597AbYBBOEg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 09:04:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JLIyt-00030F-NA
	for git@vger.kernel.org; Sat, 02 Feb 2008 14:04:32 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 14:04:31 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 14:04:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:U+tl1rDn0iwmneG/G0qD4o4q/Cs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72277>

Adjust the command syntax to better reflect the call parameters:
[save] [message...] => [save [<message>]].

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 > [Jakub Narebski] I think it would beb better if you split this patch
 > in two,

 ***********************************************************************
 This is reworked patch (No. 2)
 ***********************************************************************

 Documentation/git-stash.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 9889806..cd0dc1b 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-stash' (list | show [<stash>] | apply [<stash>] | clear)
-'git-stash' [save] [message...]
+'git-stash' [save [<message>]]
 
 DESCRIPTION
 -----------
@@ -36,11 +36,12 @@ is also possible).
 OPTIONS
 -------
 
-save::
+save [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git-reset
 	--hard` to revert them.  This is the default action when no
-	subcommand is given.
+	subcommand is given. The <message> part is optional and gives
+	the description along with the stashed state.
 
 list::
 
-- 
1.5.4-rc5.GIT-dirty
