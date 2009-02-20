From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rebase -i
Date: Fri, 20 Feb 2009 01:07:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902200105520.10279@pacific.mpi-cbg.de>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com> <76718490902191255w24b30bd8jacaed8aa919d6526@mail.gmail.com> <gnkre1$g8s$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 01:08:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaIwJ-0001Um-BR
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 01:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbZBTAGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 19:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbZBTAGz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 19:06:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:36060 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754785AbZBTAGy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 19:06:54 -0500
Received: (qmail invoked by alias); 20 Feb 2009 00:06:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 20 Feb 2009 01:06:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+i2JAkq0+i5PGUgeZNIaLWt5NcZk7B+6sFgR5CKT
	zyBuD+OWTsxOwY
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <gnkre1$g8s$1@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110766>

Hi,

On Fri, 20 Feb 2009, Giuseppe Bilotta wrote:

> On Thursday 19 February 2009 21:55, Jay Soffian wrote:
> 
> > On Thu, Feb 19, 2009 at 4:21 AM, John Tapsell <johnflux@gmail.com> wrote:
> >> Hi,
> >>
> >>  I often do   'git rebase -i HEAD~10'  to rebase.  Since afaics it
> >> doesn't matter if you go back 'too far' I just always use HEAD~10 even
> >> if it's just for the last or so commit.
> >>
> >>  Would there be any objections to making  'git rebase -i' default to
> >> HEAD~10  or maybe 16 or 20.  Having sensible defaults for commands
> >> helps a bit with making it easier to use.
> > 
> > I think the following might be reasonable to support:
> > 
> > $ git rebase -i -10
> > $ git rebase -i -n -10
> 
> This feature gets my vote. I actually gave the implementation a quick try,
> but didn't get very far through it. I was actually considering making git
> rev-parse support the syntax.
> 
> Yes, as remarked by Johannes there are issue when there are merges in between
> (in which case -10 is most likely not the same as HEAD~10), but I would say
> that this is in no way a good reason to deprive users from the comfort it can
> give in most common situations.

"I want it, I want it, I want it, and I'll just ignore what you just said" 
is not a good counterargument, would you say?

Sure, you even cited me, responding to the mail I responded to (as opposed 
to my mail), but you managed to ignore my argument nevertheless.

Ciao,
Dscho
