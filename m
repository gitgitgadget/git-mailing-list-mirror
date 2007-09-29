From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Stashing untracked files
Date: Sun, 30 Sep 2007 00:09:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709300007370.28395@racer.site>
References: <46FE9924.7080006@theory.org> <Pine.LNX.4.64.0709292201400.28395@racer.site>
 <EEE8F630-AE62-4425-96A0-239D54724DF4@lrde.epita.fr>
 <Pine.LNX.4.64.0709292248400.28395@racer.site> <20070929222320.GB2947@hermes.priv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>,
	Neil Macneale <mac4-git@theory.org>, git <git@vger.kernel.org>
To: Tom Prince <tom.prince@ualberta.net>
X-From: git-owner@vger.kernel.org Sun Sep 30 01:10:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IblS8-0003bR-UY
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 01:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537AbXI2XKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 19:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755146AbXI2XKN
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 19:10:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:55876 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755343AbXI2XKM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 19:10:12 -0400
Received: (qmail invoked by alias); 29 Sep 2007 23:10:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 30 Sep 2007 01:10:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19P3SBM2XBPGdkMtugiCHGEViDRMMh9hTofl8xDYC
	V+1kWOV4sTPtcg
X-X-Sender: gene099@racer.site
In-Reply-To: <20070929222320.GB2947@hermes.priv>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59507>

Hi,

On Sat, 29 Sep 2007, Tom Prince wrote:

> > > You could stash untracked files that are not ignored (I personally 
> > > ignore *.o, *.a and the like).
> > 
> > And what if you happen to forget to ignore that?  Or if you happen to 
> > have an strace log in some file (which you did not ignore either)?
> > 
> > Thanks, but I think the semantics of git stash is pretty well defined.  
> > And it means that you stash away _tracked_ content that was not yet 
> > committed.
> > 
> > I mean, you can have your desired behaviour with
> > 
> > $ git add .
> > $ git stash
> > 
> > but if we were to fulfil your wish and change the default behaviour, 
> > there is no way back to the current behaviour (which I happen to find 
> > pretty sane).
> 
> But
> 
> git add .
> git stash
> git stash apply
> 
> will not be a no-op any more.

It never was.  (Or did you mean "git stash apply --index"?)

> It doesn't need to be a default, but there are certainly times when I 
> would find the option to stash untracked files convenient.

But then I'll have to ask you why the untracked files, which are not 
touched by git, have to be stashed anyway?

I'm seriously thinking that we are in deep "XY problem" land here.

Ciao,
Dscho
