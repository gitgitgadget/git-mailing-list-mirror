From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] Add git-sequencer documentation
Date: Wed, 30 Jul 2008 16:06:42 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807301556140.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net> <1217049644-8874-2-git-send-email-s-beyer@gmx.net> <1217049644-8874-3-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807261623530.26810@eeepc-johanness>
 <20080730121454.GA8767@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 30 16:08:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOCLD-0001bA-3x
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 16:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbYG3OGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 10:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbYG3OGq
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 10:06:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:43465 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752152AbYG3OGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 10:06:45 -0400
Received: (qmail invoked by alias); 30 Jul 2008 14:06:43 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp016) with SMTP; 30 Jul 2008 16:06:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+OJNozLqaO5BTUXXyVWnz/HuG9X4R2H4pyUNYgWr
	eNIBuuCVbVpXp5
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080730121454.GA8767@leksak.fem-net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90793>

Hi,

On Wed, 30 Jul 2008, Stephan Beyer wrote:

> Johannes Schindelin wrote:
> > > +-B::
> > > +--batch::
> > > +	Run in batch mode. If unexpected user intervention is needed
> > > +	(e.g. a conflict or the need to run an editor), 'git-sequencer' fails.
> > 
> > Does it abort, or leave a dirty tree?
> 
> It aborts.
> Perhaps I should make this clear in the docs.

No, just leave it as is.  The users can always ask you on the mailing 
list.  So my comment was totally unfounded.

> > > +--onto=<base>::
> > > +	Checkout given commit or branch before sequencing.
> > > +	If you provide a branch, sequencer will make the provided
> > > +	changes on the branch, i.e. the branch will be changed.
> > 
> > Whoa, does that mean that
> > 
> > 	$ git checkout my-private-branch
> > 	$ git sequencer --onto=master
> > 
> > will change _master_?
> 
> Exactly.

/me does not like that.  I could see a new porcelain doing that, but not 
the thing that will be called by rebase.

> > > +	--include-merges;;
> > > +		Sanity check does not fail if you have merges
> > > +		between HEAD and <mark>.
> > 
> > It may be a commit, too, right?  And why does it make sense to check that 
> > there are no merges?  I mean, it is just as if I did two cherry-picks, the 
> > second with -n, and then commit --amend it.  Can make tons of sense...
> 
> I think I mean something different. With "merges" I am talking about
> commits having more than one parent.

Yes, I read "merges" the same way.  My comment still stands.

> Thanks for your reply and your other notes. (The ones I didn't comment 
> are just ACKed.)

The ones that _I_ did not comment on I do not necessarily agree with, but 
then, I do not have the time to argue about them.

Ciao,
Dscho
