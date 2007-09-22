From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git as a filesystem
Date: Sat, 22 Sep 2007 13:06:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709221304080.28395@racer.site>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>
 <Pine.LNX.4.64.0709211208440.28395@racer.site>
 <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>
 <alpine.LFD.0.9999.0709210912120.32185@xanadu.home> <20070921233343.GA8327@muzzle>
 <Pine.LNX.4.64.0709220040450.28395@racer.site> <20070922020632.GB8327@muzzle>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Peter Stahlir <peter.stahlir@googlemail.com>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Sep 22 14:07:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ3lp-0004ls-Sa
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 14:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbXIVMH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 08:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbXIVMH2
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 08:07:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:43379 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751530AbXIVMH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 08:07:27 -0400
Received: (qmail invoked by alias); 22 Sep 2007 12:07:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 22 Sep 2007 14:07:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19RCNsaQNVR8MGQXrP0OrVSKK338t3zWKdoOOhXvq
	nu9cCxPpiHunVu
X-X-Sender: gene099@racer.site
In-Reply-To: <20070922020632.GB8327@muzzle>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58932>

Hi,

On Fri, 21 Sep 2007, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Fri, 21 Sep 2007, Eric Wong wrote:
> > > 
> > > On a similar note, has anybody experimented with using git to store 
> > > maildirs or news spools?  I'd imagine the quoted portions of most 
> > > message threads could be delta-compressed quite efficiently.
> > 
> > I store all my mail in a git repository.  Works beautifully.  Except 
> > that the buffers on my laptop are constantly full :-( So a simple 
> > commit takes some waiting.
> > 
> > Should be no issue on normal (desktop) machines.
> 
> D'oh.  I already have maildir performance problems on my laptop.

Umm.  Regular operation is not affected, since I (add and) commit only 
when I weeded out all those spams and other unwanted mail.

> I wonder how well only having an index and no commits (no versioning), 
> and manual packing with pack-objects would work.  Packing could be 
> optimized to order objects based on the Message-Id, References, and 
> In-Reply-To headers, too.

The most efficient way would be to have a mailer backend accessing the 
database, and then not have a working directory, methinks (especially with 
these amounts of mail I am juggling ATM).

Time forbids working on this, though.

Ciao,
Dscho
