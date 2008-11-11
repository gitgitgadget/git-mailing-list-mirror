From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: problem with git gui on cygwin.
Date: Tue, 11 Nov 2008 19:08:17 +0100
Message-ID: <20081111180817.GA7589@blimp.localdomain>
References: <loom.20081111T155614-227@post.gmane.org> <20081111170557.GI2932@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Jensen <jhjjhjjhj@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 11 19:09:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzxgJ-0004Nq-5n
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 19:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbYKKSIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 13:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbYKKSIW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 13:08:22 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:49673 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbYKKSIV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 13:08:21 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8BU83pbQ=
Received: from tigra.home (Fae1e.f.strato-dslnet.de [195.4.174.30])
	by post.webmailer.de (mrclete mo16) (RZmta 17.19)
	with ESMTP id L060c6kABGQNvM ; Tue, 11 Nov 2008 19:08:17 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 8E2C7277C8;
	Tue, 11 Nov 2008 19:08:17 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 4808E36D27; Tue, 11 Nov 2008 19:08:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081111170557.GI2932@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100665>

Shawn O. Pearce, Tue, Nov 11, 2008 18:05:57 +0100:
> Jim Jensen <jhjjhjjhj@gmail.com> wrote:
> > I have been trying to use git for a small project using cygwin.  I copied my
> > repository from one windows XP system to a Vista system using a usb drive.  On
> > the new system when I use "git gui" I get a pop up that says "Git directory not
> > found: .git"
> > 
> > This happens with git gui and gitk.  The command line programs I tried, git show
> > and git status appear to work.
> 
> Huh.  Sounds like the Tcl/Tk process isn't spawning the Cygwin git
> process in the right directory or something.  Weird that both git-gui
> and gitk are giving you errors; usually its git-gui that is being
> paranoid about the repository structure and gitk works just fine.
> 
> You can try starting `git gui --trace` and see if that tells you
> any more detail, but it doesn't show cwd so it may not be all that
> useful to help you debug it.
> 

Maybe the fact that wish is not a cygwin application (doesn't use use
cygwin1.dll) is a hint?
