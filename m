From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Sun, 8 Oct 2006 00:36:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610080034490.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061006212616.GA5175@lumumba.uhasselt.be>
 <20061006220542.GA5890@lumumba.uhasselt.be> <BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE>
 <BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE> <7viriwsa75.fsf@assigned-by-dhcp.cox.net>
 <eg82tq$2uq$1@sea.gmane.org> <Pine.LNX.4.63.0610071930300.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061007223023.GI20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 00:36:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWKmn-00046O-4T
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 00:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879AbWJGWgq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 18:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932880AbWJGWgq
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 18:36:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:35755 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932879AbWJGWgp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 18:36:45 -0400
Received: (qmail invoked by alias); 07 Oct 2006 22:36:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 08 Oct 2006 00:36:43 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061007223023.GI20017@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28516>

Hi,

On Sun, 8 Oct 2006, Petr Baudis wrote:

> Dear diary, on Sat, Oct 07, 2006 at 07:32:25PM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
>
> > HOWEVER, Junio pointed out that he'd like a finer grain than per-repo, and 
> > .gitconfig is a coarser one!
> 
> Actually, that doesn't matter. The point is that it is of _different_
> shape than this division. It's per remote server, even spanning several
> repositories. So you want to be able to set it up per the server, at the
> most global place possible for a regular user, so ~/.gitconfig might be
> good idea.

Actually, I do not think that anybody in her right mind would set this to 
different values for different repos or servers.

I _know_ that if I hit that very problem, the next thing I'd do is set the 
timeout to 5 seconds _globally_.

Ciao,
Dscho
