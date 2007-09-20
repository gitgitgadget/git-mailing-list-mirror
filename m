From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Symbolic link documentation
Date: Thu, 20 Sep 2007 13:27:36 -0400
Message-ID: <20070920172736.GU3099@spearce.org>
References: <70952A932255A2489522275A628B97C3052E98EB@xmb-sjc-233.amer.cisco.com> <Pine.LNX.4.64.0709201819340.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Matt Seitz (matseitz)" <matseitz@cisco.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 19:27:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYPod-0002eu-AB
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 19:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341AbXITR1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 13:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbXITR1n
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 13:27:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50149 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbXITR1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 13:27:43 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IYPoJ-0007ti-LQ; Thu, 20 Sep 2007 13:27:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 042D320FBAE; Thu, 20 Sep 2007 13:27:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709201819340.28395@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58790>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 20 Sep 2007, Matt Seitz (matseitz) wrote:
> 
> > Where does the git user documentation discuss how git handles symbolic 
> > links?
> 
> $ git grep symbolic Documentation/ | grep link
> Documentation/RelNotes-1.5.0.2.txt:    in place of the symbolic link.  The default strategy,
> Documentation/RelNotes-1.5.0.2.txt:    that was pointed at by the symbolic link.  Both of these
> Documentation/RelNotes-1.5.0.2.txt:    when changes to a symbolic link conflicted.  It should have
> Documentation/RelNotes-1.5.0.2.txt:    file the symbolic link pointed at.
> Documentation/RelNotes-1.5.1.5.txt:    directory $PWD points at is a symbolic link.
> Documentation/RelNotes-1.5.1.6.txt:    directory $PWD points at is a symbolic link.
> Documentation/RelNotes-1.5.1.txt:    in place of the symbolic link.  The default strategy,
> Documentation/RelNotes-1.5.1.txt:    that was pointed at by the symbolic link.  Both of these
> Documentation/RelNotes-1.5.1.txt:    when changes to a symbolic link conflicted.  It should have
> Documentation/RelNotes-1.5.1.txt:    file the symbolic link pointed at.
> Documentation/RelNotes-1.5.3.2.txt:   - an untracked symbolic link to a directory made it fart;

Many of these release notes are talking about bugs that we fixed
related to switching between revisions where in one revision the
path was a symlink and in the other revision it was a directory or
a file (or vice-versa).

> Documentation/config.txt:	If false, symbolic links are checked out as small plain files that
> Documentation/config.txt:	symbolic links. True by default.
> Documentation/git-update-index.txt:to 'false' (see gitlink:git-config[1]), symbolic links are checked out
> Documentation/git-update-index.txt:from symbolic link to regular file.
> Documentation/technical/racy-git.txt:files vs symbolic links) and executable bits (only for regular

These are probably what Matt was looking for.

> Documentation/config.txt:	and other symbolic reference files, use symbolic links.
> Documentation/config.txt:	expect HEAD to be a symbolic link.
> Documentation/core-tutorial.txt:   This is similar to a symbolic link and points at
> Documentation/git-local-fetch.txt:	Instead of regular file-to-file copying use symbolic links to the objects
> Documentation/git-symbolic-ref.txt:In the past, `.git/HEAD` was a symbolic link pointing at
> Documentation/git-symbolic-ref.txt:advertised (horrors).  Therefore symbolic links are now deprecated
> Documentation/git-update-ref.txt:these symbolic pointers, whether they are symlinks or these
> Documentation/git-update-ref.txt:"regular file symbolic refs".  It follows *real* symlinks only
> Documentation/glossary.txt:	references are manipulated with the gitlink:git-symbolic-ref[1]
> Documentation/repository-layout.txt:	a symbolic link instead of a symref that points at the current

These are all about how Git stores refs, and how HEAD used to be
a symbolic link but has since changed to a symbolic reference...
So less useful to what he was looking for I think.

-- 
Shawn.
