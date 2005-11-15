From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 12:06:15 -0500
Message-ID: <1132074375.25640.47.camel@dv>
References: <1132034390.22207.18.camel@dv>
	 <7vveyuqto5.fsf@assigned-by-dhcp.cox.net> <1132042427.3512.50.camel@dv>
	 <7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
	 <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20051115121854.GV30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 18:12:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec4HY-0006wh-VS
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 18:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVKORHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 12:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbVKORHm
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 12:07:42 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:63382 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964957AbVKORHl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 12:07:41 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Ec4HM-00025i-SH
	for git@vger.kernel.org; Tue, 15 Nov 2005 12:07:39 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Ec4G7-00072P-Eo; Tue, 15 Nov 2005 12:06:15 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051115121854.GV30496@pasky.or.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11919>

On Tue, 2005-11-15 at 13:18 +0100, Petr Baudis wrote:
> Dear diary, on Tue, Nov 15, 2005 at 12:09:42PM CET, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > I think Junio is right: we should not force everybody not to use symlinks, 
> > only because there happens to be VFAT-, SMB- or HTTP-shared repositories. 
> > As Junio says, if there are people experiencing problems because they lack 
> > symbolic links, they should fix it.
> 
> I'm ambivalent here. I would like to have just a single behaviour here,
> since the symbolic ref otherwise really does not get much testing. But I
> can also understand that we are breaking tools here.
> 
> Still, for the reason above, I think we should aim at the symbolic refs
> being the canonical format in the next major release after 1.0, giving
> users time to fix their tools. I can see no advantage in symlinks except
> the backwards compatibility - speed argument was presented, but I don't
> buy that until I see hard data supporting that.

I planned to write about symrefs long ago, and probably I waited for too
long.  I still hope it will be the default for 1.0 release, but if not,
I hope the next release won't be too far away.

> > On the other hand, I think it would be useful to be able to configure the 
> > behaviour via .git/config.
> 
> Yes, I would very much like to have this. I still want to go
> symrefs-only for public repositories created for cg-admin-setuprepo, so
> that fetching over HTTP works properly.

Agreed.  By the way, the symref doesn't need to be called HEAD - it
could be "trunk" or "main" or "default-branch".

-- 
Regards,
Pavel Roskin
