From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Diff format in packs
Date: Tue, 1 Aug 2006 12:59:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608011248530.17230@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910607311408i10e17dse776920de7c5076a@mail.gmail.com> 
 <ealruh$sq9$1@sea.gmane.org>  <9e4733910607311420n8537b76lbde4d60062195403@mail.gmail.com>
  <46a038f90607311747j947c786s6af2fe637dbde89d@mail.gmail.com> 
 <9e4733910607311813l78791e40l1234cf0e458db66f@mail.gmail.com> 
 <46a038f90607311916k5d130f70gc0ac26eb8f15fec0@mail.gmail.com>
 <9e4733910607311929j189eb6b9r6a804cc744290fdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 12:59:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7ry7-0008Me-1k
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 12:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWHAK7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 06:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWHAK7I
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 06:59:08 -0400
Received: from mail.gmx.net ([213.165.64.21]:30884 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932553AbWHAK7H (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 06:59:07 -0400
Received: (qmail invoked by alias); 01 Aug 2006 10:59:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 01 Aug 2006 12:59:05 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910607311929j189eb6b9r6a804cc744290fdc@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24592>

Hi Jon,

On Mon, 31 Jul 2006, Jon Smirl wrote:

> On 7/31/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > > would be to use cvs2svn to build the changeset database and then use
> > > cvsps to simply read the changesets out of it and build the git
> > > repository.
> > 
> > Once cvs2svn has the db built, it should be easy to write a
> > perl/python script that mimics the output of cvsps.
> 
> This is an efficiency problem.

In another mail, you asked for a solution for the initial 700MB download. 
How about doing it like Linux-2.6, namely have a clean cut, and for those 
who want, they can load the historical repo, too, and graft it onto the 
current one?

I _think_ that with a new start, incremental git-cvsimport should still 
work, if you do it cleverly. Obviously, it would _not_ have the full 
history, but rather add onto the most recent revisions (incremental 
git-cvsimport detects the revisions to import by author date IIRC).

Note that this method will _not_ work, if there are _new_ branches that 
cvsps has problems with.

Ciao,
Dscho
