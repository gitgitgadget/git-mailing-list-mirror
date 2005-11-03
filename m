From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: little conundrum
Date: Thu, 3 Nov 2005 20:36:45 +0100
Message-ID: <20051103193644.GB28273@bohr.gbar.dtu.dk>
References: <200511031741.20496.alan@chandlerfamily.org.uk> <200511031848.58040.alan@chandlerfamily.org.uk> <20051103191652.GA28273@bohr.gbar.dtu.dk> <200511031930.28929.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 03 20:37:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXkth-0002ZZ-CF
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 20:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbVKCTgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 14:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbVKCTgr
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 14:36:47 -0500
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:48006 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1030456AbVKCTgq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 14:36:46 -0500
Received: (qmail 3467 invoked by uid 5842); 3 Nov 2005 20:36:45 +0100
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200511031930.28929.alan@chandlerfamily.org.uk>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11088>

On Thu, Nov 03, 2005 at 07:30:28PM +0000, Alan Chandler wrote:
...
> This is the same as before.  It lists the modified files, but it doesn't tell 
> you about any added or deleted files.

That's odd, because I get this (shortened) output with Git current:

~/peter-2.6]git-status
#
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       deleted:  README
#       deleted:  REPORTING-BUGS
#       deleted:  arch/mips/mips-boards/atlas/Makefile
#       deleted:  arch/mips/mips-boards/sead/sead_setup.c
#       modified: fs/fs-writeback.c
#       deleted:  init/Kconfig
#       deleted:  init/Makefile
#       deleted:  init/calibrate.c
#
#
# Untracked files:
#   (use "git add" to add to commit)
#
#       drivers/media/MAINTAINERS
#       drivers/parport/mips-boards/atlas/Makefile
#       drivers/parport/mips-boards/atlas/atlas_gdb.c
#       drivers/parport/mips-boards/sead/sead_setup.c
#       fs/fs-writeback.c~
nothing to commit


> [I have done this manually now - originally I thought that there were quite a 
> few files - but once I had stripped out things like "tags" and some spurious 
> directories that were empty it ended up being only three files:-).  So its 
> only an intellectual exercise now:-)]

Be careful to remember to add any links.  At least with Git when
I last tried importing directories containing them.

Peter
