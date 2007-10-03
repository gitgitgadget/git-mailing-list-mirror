From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push (mis ?)behavior
Date: Wed, 3 Oct 2007 17:18:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710031718110.28395@racer.site>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
 <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp>
 <buobqbgmv6z.fsf@dhapc248.dev.necel.com> <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com>
 <20071003104943.GA3017@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031550490.28395@racer.site>
 <20071003160731.GA7113@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>, Miles Bader <miles@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 18:20:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id6xS-0007n5-Nv
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 18:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbXJCQUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 12:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbXJCQUP
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 12:20:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:33291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752588AbXJCQUN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 12:20:13 -0400
Received: (qmail invoked by alias); 03 Oct 2007 16:20:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 03 Oct 2007 18:20:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19i5L8BlhpieI28c6rR0wxbsyab3PzglcSp3VgxL1
	1lcjcpFH2PmQvV
X-X-Sender: gene099@racer.site
In-Reply-To: <20071003160731.GA7113@diana.vm.bytemark.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59854>

Hi,

On Wed, 3 Oct 2007, Karl Hasselstr?m wrote:

> On 2007-10-03 16:27:49 +0100, Johannes Schindelin wrote:
> 
> > On Wed, 3 Oct 2007, Karl Hasselstr?m wrote:
> >
> > >   2. "push all branches" is the default, but the user intended to
> > >      push only the current branch. She ends up pushing a superset
> > >      of what she wanted, which is not easily fixed if she can't be
> > >      sure that no one else has pulled from the public repo before
> > >      she notices what's happened.
> >
> > But that is not the default. Not at all.
> >
> > The default is to push the refs which the remote and the local side
> > have _in common_.
> 
> I know, and that's what I meant by "all branches". Sorry for the
> sloppy language.
> 
> > Maybe we should initialise the "remote.origin.push" variable to
> > "completely-bogus-branchname" when you "git init --im-a-newbie"?
> 
> I'd rather have a suboptimal default than different defaults depending
> on user settings. (See also Junio's comment on that elsewhere in this
> thread.)

This thread is getting painful.  Lot's of "I want"s, but nobody to date 
came up with a solution that makes both oldtimers and newtimers happy.

Ciao,
Dscho
