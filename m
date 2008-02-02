From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntax
Date: Sat, 02 Feb 2008 04:22:56 +0200
Organization: Private
Message-ID: <ir185c73.fsf@blue.sea.net>
References: <7ihp802o.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 03:24:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL839-0001UZ-2c
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 03:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757650AbYBBCXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 21:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757538AbYBBCXi
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 21:23:38 -0500
Received: from main.gmane.org ([80.91.229.2]:36789 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757471AbYBBCXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 21:23:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JL82a-0001TR-Jo
	for git@vger.kernel.org; Sat, 02 Feb 2008 02:23:36 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 02:23:36 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 02:23:36 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:tLDIvAT7StiYHVS5XqmkPSy+U/4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72210>

Change (list|...) to {list|...} to denote required commands. Adjust
the 'save' command syntax to better reflect the call parameters:
[save] [message...] => [save [message...]].

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 ***********************************************************************
 This is reworked patch (No. 1)
 ***********************************************************************

 Documentation/git-stash.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 9889806..8e343d8 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -8,8 +8,8 @@ git-stash - Stash the changes in a dirty working directory away
 SYNOPSIS
 --------
 [verse]
-'git-stash' (list | show [<stash>] | apply [<stash>] | clear)
-'git-stash' [save] [message...]
+'git-stash' {list | show [<stash>] | apply [<stash>] | clear}
+'git-stash' [save [message...]]
 
 DESCRIPTION
 -----------
-- 
1.5.4-rc5.GIT-dirty
