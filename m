From: Petr Baudis <pasky@ucw.cz>
Subject: git-diff-tree -B broken
Date: Sun, 9 Apr 2006 02:46:05 +0200
Message-ID: <20060409004605.GU27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 09 02:46:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSO4K-0006dz-UO
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 02:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWDIAqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 20:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWDIAqH
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 20:46:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53705 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965053AbWDIAqG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Apr 2006 20:46:06 -0400
Received: (qmail 6974 invoked by uid 2001); 9 Apr 2006 02:46:05 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18537>

  Hi,

  no pun intended in the $SUBJ, but git-diff-tree -B seems to be giving
me bogus output

	$ git-diff-tree -r -p -B -M 916d8240bfc8ef5b80780b1a32ebb83ed055a178 \
		3c9324ea16c345fc0bc0f11041905ba714797e4a cg-mkpatch
	diff --git a/cg-mkpatch b/cg-mkpatch
	dissimilarity index 57%
	index 74fe917..c932bc9 100755
	--- cg-mkpatch
	+++ cg-mkpatch
	@@ -0,0 +0,0 @@

and nothing else. I'm too tired to debug or bisect this (xdiff
introduction is the obvious suspect, I guess), just didn't want this
to slip into the looming 1.3.0 so reporting early.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
