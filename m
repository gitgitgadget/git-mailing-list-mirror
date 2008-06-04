From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Wed, 4 Jun 2008 16:43:39 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806041641150.13507@racer.site.net>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806032115340.13507@racer.site.net> <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz> <20080604102906.GA2126@diana.vm.bytemark.co.uk> <m3ej7dzc7y.fsf@localhost.localdomain>
 <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
X-From: git-owner@vger.kernel.org Wed Jun 04 17:45:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3vB8-0007yw-OE
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 17:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061AbYFDPoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 11:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755323AbYFDPon
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 11:44:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:60471 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754983AbYFDPon (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 11:44:43 -0400
Received: (qmail invoked by alias); 04 Jun 2008 15:44:41 -0000
Received: from unknown (EHLO none.local) [128.177.17.254]
  by mail.gmx.net (mp058) with SMTP; 04 Jun 2008 17:44:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2+yBIHKa2OyP55Kw4/UALZWeuUqohyIcinDg2pK
	jAJAMZvDqUTMRw
X-X-Sender: gene099@racer.site.net
In-Reply-To: <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83789>

Hi,

On Wed, 4 Jun 2008, Jaroslav Kysela wrote:

> On Wed, 4 Jun 2008, Jakub Narebski wrote:
> 
> > Karl Hasselstr?m <kha@treskal.com> writes:
> > 
> > > On 2008-06-04 11:16:46 +0200, Jaroslav Kysela wrote:
> > > 
> > > > On Tue, 3 Jun 2008, Johannes Schindelin wrote:
> > > >
> > > > > That feels really funny, given that the guy running git-am _is_
> > > > > the committer, not whoever provided some extra headers to the
> > > > > mailbox.
> > > >
> > > > Yes, the implementatation does not make sense for public patch
> > > > handling, but if you do various things locally with git-rebase or
> > > > git-am (pack picking from another repo), you may consider it useful.
> > > 
> > > But still, you're creating new commits, so they should have your name
> > > on them.
> > 
> > Yes, if you are _creating_ *commits*, then you are *committer*, isn't it?
> 
> I agree with that, but if you just manage patches and you want to keep 
> commit history and change only hash numbers, it's an option. Nothing else. 
> It's just tool extension and users have to cleverly decide if it's worth 
> to use it or not.

I think that

- what you want to do is better done with git fast-export; <edit>; git 
  fast-import, than with git porcelain, and

- you hopefully do _not_ want to recommend your workflow (and bless it 
  with porcelain support), because

- as has been pointed out several times now, you _are_ the committer, and 
  you seem to want to lie there.

Ciao,
Dscho
