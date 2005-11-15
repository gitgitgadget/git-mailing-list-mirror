From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 13:18:54 +0100
Message-ID: <20051115121854.GV30496@pasky.or.cz>
References: <1132034390.22207.18.camel@dv> <7vveyuqto5.fsf@assigned-by-dhcp.cox.net> <1132042427.3512.50.camel@dv> <7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net> <7vd5l2mco1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Pavel Roskin <proski@gnu.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 13:21:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbzmA-0001Su-Gq
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 13:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVKOMS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 07:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVKOMS6
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 07:18:58 -0500
Received: from w241.dkm.cz ([62.24.88.241]:55683 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932406AbVKOMS5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 07:18:57 -0500
Received: (qmail 7849 invoked by uid 2001); 15 Nov 2005 13:18:54 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11900>

Dear diary, on Tue, Nov 15, 2005 at 12:09:42PM CET, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> I think Junio is right: we should not force everybody not to use symlinks, 
> only because there happens to be VFAT-, SMB- or HTTP-shared repositories. 
> As Junio says, if there are people experiencing problems because they lack 
> symbolic links, they should fix it.

I'm ambivalent here. I would like to have just a single behaviour here,
since the symbolic ref otherwise really does not get much testing. But I
can also understand that we are breaking tools here.

Still, for the reason above, I think we should aim at the symbolic refs
being the canonical format in the next major release after 1.0, giving
users time to fix their tools. I can see no advantage in symlinks except
the backwards compatibility - speed argument was presented, but I don't
buy that until I see hard data supporting that.

> On the other hand, I think it would be useful to be able to configure the 
> behaviour via .git/config.

Yes, I would very much like to have this. I still want to go
symrefs-only for public repositories created for cg-admin-setuprepo, so
that fetching over HTTP works properly.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
