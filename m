From: Petr Baudis <pasky@suse.cz>
Subject: Re: What is in git.git
Date: Sun, 22 Jan 2006 04:12:37 +0100
Message-ID: <20060122031237.GU28365@pasky.or.cz>
References: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net> <200601211636.02340.lan@ac-sw.com> <7vek31mkyg.fsf@assigned-by-dhcp.cox.net> <200601220033.26321.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 04:11:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0VdF-0008NX-Us
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 04:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWAVDLH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 22:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWAVDLG
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 22:11:06 -0500
Received: from w241.dkm.cz ([62.24.88.241]:4267 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932218AbWAVDLF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 22:11:05 -0500
Received: (qmail 19906 invoked by uid 2001); 22 Jan 2006 04:12:37 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200601220033.26321.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15041>

Just-in-case panic response...

Dear diary, on Sun, Jan 22, 2006 at 12:33:25AM CET, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> > You need to keep a file that describes how your repository is
> > tracking the development histories of each subproject in
> > $GIT_DIR/bind, that would look like:
> > 
> > 	master main=/ subpro=sub/
> 
> What about putting $GITDIR/bind information directly into reference files?
> 
>  $HOME/gitproj> cat .git/refs/heads/master
>  92347432598...
>  bind main=/
>  bind subpro=sub/
> 
> This way, you can rename/copy heads, and the binding info will stay with
> the commit.

Please don't. I can see no real advantage to separate files (except for
the very rare case of rename/copy/removal of heads) except for massive
porcelain breakage and significant clutter-up of all the code dealing
with refs.

Please leave our poor refs alone. :) They are fine as they are - simple
one-value thing.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
