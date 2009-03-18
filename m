From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Wed, 18 Mar 2009 01:58:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903180155270.10279@pacific.mpi-cbg.de>
References: <200903171953.23650.ogoffart@kde.org> <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de> <20090318004056.GB25454@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Olivier Goffart <ogoffart@kde.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 01:58:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljk6c-0002en-Dp
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 01:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbZCRA4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 20:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbZCRA4X
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 20:56:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:60188 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752881AbZCRA4W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 20:56:22 -0400
Received: (qmail invoked by alias); 18 Mar 2009 00:56:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 18 Mar 2009 01:56:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IGaZdbphIBYrelyBDqeZ9IqRTF3kbutIpmgac5W
	TMwCKgPZlbH/2L
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090318004056.GB25454@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113546>

Hi,

On Tue, 17 Mar 2009, Jeff King wrote:

> On Tue, Mar 17, 2009 at 11:31:19PM +0100, Johannes Schindelin wrote:
> 
> > > I was told on IRC that this has been discussed already not so long ago, 
> > > and looking on the archive[1], all i seen was bikesheeding .  Here is a 
> > > patch :-)
> > 
> > Unfortunately, the implementation is not the problem, but picking the best 
> > name.  The first letter "m" will be taken in a short while by the "merge" 
> > command for "rebase -i -p", so "message" is out, sadly.
> > 
> > But the "rephrase" command will be part of the "rebase -i -p" series when 
> > I will finally be able to submit it.
> 
> Also, I thought the general plan was to add such features to the
> git-sequencer work which will (hopefully) eventually replace "rebase
> -i". Dscho, can you give a brief update on how that is coming? Are
> rebase patches worth thinking about?

IMHO rebase -i is the important part.  The user interface needs some 
serious overhaul, which I am in the slow process of doing.  The sequencer 
then has to follow suit.

As it stands, I think sequencer is not good enough yet to replace rebase 
-i (all my comments about that are public, except the heads-up I sent 
Stephan in private).

To be frank, 'rebase -i -p' support, as it is in git.git is not good 
enough at all.  That's why I was working on that, and I am close to 
finishing it.

Ciao,
Dscho
