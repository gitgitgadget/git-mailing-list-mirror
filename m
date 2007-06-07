From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: git-svn error msg
Date: Thu, 07 Jun 2007 13:22:39 +0200
Organization: Transmode AB
Message-ID: <1181215359.30670.53.camel@gentoo-jocke.transmode.se>
References: <008601c7a844$56dc5030$0e67a8c0@Jocke>
	 <20070607063723.GB2809@muzzle>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 13:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwG4r-0007bc-TR
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 13:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbXFGLWm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 07:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbXFGLWm
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 07:22:42 -0400
Received: from mail.transmode.se ([83.241.175.147]:29109 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750870AbXFGLWl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 07:22:41 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 07 Jun 2007 13:22:39 +0200
In-Reply-To: <20070607063723.GB2809@muzzle>
X-Mailer: Evolution 2.8.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49364>

On Wed, 2007-06-06 at 23:37 -0700, Eric Wong wrote:
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> >   git-svn init file:///usr/local/src/tst-git-svn/svn-uboot-repo/
> > and then
> >   git-svn fetch yields lots of:
> > Use of uninitialized value in substitution (s///) at /usr/bin/git-svn line 2144.
> > Use of uninitialized value in substitution (s///) at /usr/bin/git-svn line 2144.
> > ....
> > 
> > seems to work though.
> > 
> > git version - 1.5.1.3
> 
> Probably/hopefully harmless.  Although I would like to know what's
> causing it, though...  Are git-svn-id: lines generated correctly
> in your commit messages?
> 

Well, can't tell since I can't commit.
This is whats I did(from http://utsl.gen.nz/talks/git-svn/intro.html#howto-track )
git clone -l /usr/local/src/tm-uboot/u-boot my-uboot2.clone
git-config --add remote.origin.fetch '+refs/remotes/*:refs/remotes/*'
git-svn init file:///usr/local/src/tst-git-svn/svn-uboot-repo/trunk
git-svn fetch

The /usr/local/src/tm-uboot/u-boot is a repo that is using git-svn and I wan't
to clone it.

git svn fetch ended with:
Done rebuilding .git/svn/git-svn/.rev_db.17788414-8b20-0410-8e02-ac2c1e7fead6
        D       lib_i386/Makefile
        D       lib_i386/bios.S
        D       lib_i386/bios.h
.....
       D       drivers/videomodes.h
        D       drivers/w83c553f.c
        D       drivers/
W: -empty_dir: trunk/board
W: -empty_dir: trunk/common
W: -empty_dir: trunk/cpu
W: -empty_dir: trunk/disk
W: -empty_dir: trunk/doc
W: -empty_dir: trunk/drivers
W: -empty_dir: trunk/dtt
W: -empty_dir: trunk/examples
W: -empty_dir: trunk/fs
W: -empty_dir: trunk/include
W: -empty_dir: trunk/lib_arm
W: -empty_dir: trunk/lib_blackfin
W: -empty_dir: trunk/lib_generic
W: -empty_dir: trunk/lib_i386
W: -empty_dir: trunk/lib_m68k
W: -empty_dir: trunk/lib_microblaze
W: -empty_dir: trunk/lib_mips
W: -empty_dir: trunk/lib_nios
W: -empty_dir: trunk/lib_nios2
W: -empty_dir: trunk/lib_ppc
W: -empty_dir: trunk/nand_spl
W: -empty_dir: trunk/net
W: -empty_dir: trunk/post
W: -empty_dir: trunk/rtc
W: -empty_dir: trunk/tools
Last fetched revision of refs/remotes/git-svn was r76, but we are about to fetch: r1!

If I try to commit I get:
git svn dcommit
Unable to determine upstream SVN information from HEAD history

Note: the file:///usr/local/src/tst-git-svn/svn-uboot-repo/trunk is a local
copy of the real subversion repo.
