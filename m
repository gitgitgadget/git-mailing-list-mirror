From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Dissociating a repository from its alternates
Date: Mon, 22 Oct 2007 20:05:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221957360.25221@racer.site>
References: <7vabzfhn9q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702151638130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xex50aa.fsf@assigned-by-dhcp.cox.net> <20071022180424.GA17429@ginosko.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 21:06:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik2bi-0008Jy-NF
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 21:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbXJVTGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 15:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbXJVTGW
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 15:06:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:41754 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751815AbXJVTGW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 15:06:22 -0400
Received: (qmail invoked by alias); 22 Oct 2007 19:06:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 22 Oct 2007 21:06:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nDosue3UnqtGigGONf5Yy67l9dZF191ajvBLOnz
	GzvhBEyR+nYO//
X-X-Sender: gene099@racer.site
In-Reply-To: <20071022180424.GA17429@ginosko.local>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62036>

Hi,

On Mon, 22 Oct 2007, Michael Hendricks wrote:

> On Fri, Feb 16, 2007 at 12:13:01PM -0800, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Wed, 14 Feb 2007, Junio C Hamano wrote:
> > >
> > >> People often start out with "clone -l -s" (or --reference) and
> > >> later wish to dissociate the repository from its alternates.
> > >
> > > Why not make a really dumb script which just _copies_ (or maybe 
> > > optionally hard link) the objects from the alternate repo, and then kills 
> > > the alternatives file? That should be easier. You always can repack after 
> > > that.
> > 
> > I think that is much safer.
> 
> Was such a script ever incorporated into Git?

Not that I know of, but "git repack -a && rm .git/objects/info/alternates" 
should do what you want.  You can even make a script of it, add some 
documentation and a test case, and earn git fame by posting a patch ;-)

Ciao,
Dscho
