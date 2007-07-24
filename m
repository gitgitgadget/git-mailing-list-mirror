From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git log -g: Complain, but do not fail, when no reflogs
 are there
Date: Tue, 24 Jul 2007 12:11:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241210170.14781@racer.site>
References: <Pine.LNX.4.64.0707240039300.14781@racer.site> 
 <81b0412b0707240026v4321a709wcbbbd7b67a4c506b@mail.gmail.com> 
 <Pine.LNX.4.64.0707241014500.14781@racer.site>
 <81b0412b0707240317q56e42a9bs44eb3e5ef9e796c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:11:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDIIp-0008Q7-IT
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 13:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933754AbXGXLLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 07:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933747AbXGXLLk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 07:11:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:48559 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933609AbXGXLLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 07:11:39 -0400
Received: (qmail invoked by alias); 24 Jul 2007 11:11:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 24 Jul 2007 13:11:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/khphJHITkgknoZtCH2uMQbFdFk9iJaz1G65Lwpb
	KMTdVw/lk9CXQ5
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0707240317q56e42a9bs44eb3e5ef9e796c6@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53566>

Hi,

On Tue, 24 Jul 2007, Alex Riesen wrote:

> On 7/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 24 Jul 2007, Alex Riesen wrote:
> > > On 7/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > When asking "git log -g --all", clearly you want to see only those refs
> > > > that do have reflogs, but you do not want it to fail, either.
> > > >
> > > > So instead of die()ing, complain about it, but move on to the other
> > refs.
> > > >
> > >
> > > I believe you wont even see these complaints: the pager will start shortly
> > > afterwards and fill the screen with commits, completely hiding the errors.
> > 
> > You can see it briefly, but it is hidden by default.  Which is a good
> > thing.  If you set the pager to "cat" (which is happily not the default!)
> > you can see them clearly.  Until you are swamped by the rest of the
> > output.
> > 
> > Maybe this is a feature?
> > 
> 
> Maybe. I can't see it at all. Should I downgrade something or propose
> a patch to put some delay after this error? I think not.
> 
> I think second Junios suggestion, but this is of course no
> difference to me.

Okay, two votes are enough to make me reconsider.  Junio, could you please 
replace the two "error(...)"s by "-1"s?  Only if you apply the patch, of 
course...

Ciao,
Dscho
