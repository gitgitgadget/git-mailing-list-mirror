From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How it was at GitTogether'08 ?
Date: Mon, 10 Nov 2008 13:09:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811101307250.30769@pacific.mpi-cbg.de>
References: <200811080254.53202.jnareb@gmail.com> <200811091955.19304.kai@samba.org> <alpine.DEB.1.00.0811101055020.30769@pacific.mpi-cbg.de> <200811101109.02885.kai@samba.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Tim Ansell <mithro@mithis.com>
To: Kai Blin <kai@samba.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 13:03:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzVU1-0006jy-7n
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 13:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbYKJMBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 07:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754598AbYKJMBr
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 07:01:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:35105 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754487AbYKJMBr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 07:01:47 -0500
Received: (qmail invoked by alias); 10 Nov 2008 12:01:45 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 10 Nov 2008 13:01:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NN8IYXMUNe1AdVArNkJ3JSbu6Bi2PWI9sxaz1yV
	6KnTEzbxmEetEx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200811101109.02885.kai@samba.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100519>

Hi,

On Mon, 10 Nov 2008, Kai Blin wrote:

> On Monday 10 November 2008 10:58:05 Johannes Schindelin wrote:
> 
> > > Tim was talking about that media/ folder and managing that in git. 
> > > If you want to work on the media, you might end up getting hundreds 
> > > of gigabytes of data to get that folder, even if you only need to 
> > > change one single file.
> > >
> > > That's the issue we're running into, and I don't thing submodules 
> > > solve this at all.
> >
> > You'd have to have a single repository for each and every media file, 
> > and you'd need to use shallow clones and shallow fetches.
> >
> > However, a push-conflict will probably be beyond any non-programmer 
> > skillz.
> 
> Ok, I agree. But you could work around that by teaching the artists to 
> fetch/rebase/push instead of just pushing, or hiding this in the GUI. If 
> there's a conflict on a binary data file you're screwed anyway. :)

A fetch in that case would make the artist download things she does not 
need, right?  So maybe that is not the way to go.

> > I'd rather propose to have a different interface, like through a web 
> > server, where the user can say "I have some cool new graphics, in this 
> > .zip file" together with a commit message.
> >
> > Kind of a git-gui via browser.
> 
> Incidentally I'm currently working on something like this, just aimed at 
> the "artist side", instead of the VCS side. This certainly is a useable 
> solution for artists.

Seems like a nice starting point for a git-gui-in-a-browser.

> But at some point a developer will want to check out the repository to 
> cut a release tarball, and we're back to wanting shallow and narrow 
> clones. :)

Shallow clones are not an issue.  They _should_ work.

And for releasing you do not want narrow clones.

Ciao,
Dscho
