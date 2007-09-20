From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Symbolic link documentation
Date: Thu, 20 Sep 2007 18:20:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709201819340.28395@racer.site>
References: <70952A932255A2489522275A628B97C3052E98EB@xmb-sjc-233.amer.cisco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 19:22:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYPjL-0000Vi-EC
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 19:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758263AbXITRU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 13:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758517AbXITRU5
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 13:20:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:52491 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758348AbXITRU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 13:20:56 -0400
Received: (qmail invoked by alias); 20 Sep 2007 17:20:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 20 Sep 2007 19:20:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+Cco/zWT+/UG7PZTt41tobFaSlOzjPeujBLnrLV
	FnyBDilsVYAQmy
X-X-Sender: gene099@racer.site
In-Reply-To: <70952A932255A2489522275A628B97C3052E98EB@xmb-sjc-233.amer.cisco.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58788>

Hi,

On Thu, 20 Sep 2007, Matt Seitz (matseitz) wrote:

> Where does the git user documentation discuss how git handles symbolic 
> links?

$ git grep symbolic Documentation/ | grep link
Documentation/RelNotes-1.5.0.2.txt:    in place of the symbolic link.  The default strategy,
Documentation/RelNotes-1.5.0.2.txt:    that was pointed at by the symbolic link.  Both of these
Documentation/RelNotes-1.5.0.2.txt:    when changes to a symbolic link conflicted.  It should have
Documentation/RelNotes-1.5.0.2.txt:    file the symbolic link pointed at.
Documentation/RelNotes-1.5.1.5.txt:    directory $PWD points at is a symbolic link.
Documentation/RelNotes-1.5.1.6.txt:    directory $PWD points at is a symbolic link.
Documentation/RelNotes-1.5.1.txt:    in place of the symbolic link.  The default strategy,
Documentation/RelNotes-1.5.1.txt:    that was pointed at by the symbolic link.  Both of these
Documentation/RelNotes-1.5.1.txt:    when changes to a symbolic link conflicted.  It should have
Documentation/RelNotes-1.5.1.txt:    file the symbolic link pointed at.
Documentation/RelNotes-1.5.3.2.txt:   - an untracked symbolic link to a directory made it fart;
Documentation/config.txt:	If false, symbolic links are checked out as small plain files that
Documentation/config.txt:	symbolic links. True by default.
Documentation/config.txt:	and other symbolic reference files, use symbolic links.
Documentation/config.txt:	expect HEAD to be a symbolic link.
Documentation/core-tutorial.txt:   This is similar to a symbolic link and points at
Documentation/git-local-fetch.txt:	Instead of regular file-to-file copying use symbolic links to the objects
Documentation/git-symbolic-ref.txt:In the past, `.git/HEAD` was a symbolic link pointing at
Documentation/git-symbolic-ref.txt:advertised (horrors).  Therefore symbolic links are now deprecated
Documentation/git-update-index.txt:to 'false' (see gitlink:git-config[1]), symbolic links are checked out
Documentation/git-update-index.txt:from symbolic link to regular file.
Documentation/git-update-ref.txt:these symbolic pointers, whether they are symlinks or these
Documentation/git-update-ref.txt:"regular file symbolic refs".  It follows *real* symlinks only
Documentation/glossary.txt:	references are manipulated with the gitlink:git-symbolic-ref[1]
Documentation/repository-layout.txt:	a symbolic link instead of a symref that points at the current
Documentation/technical/racy-git.txt:files vs symbolic links) and executable bits (only for regular

Hth,
Dscho
