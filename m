From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as
 shortcut to the tracked branch
Date: Fri, 20 Mar 2009 12:57:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903201255230.6865@intel-tinevez-2-302>
References: <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org>
 <20090320060545.GB27008@coredump.intra.peff.net> <7vprgc4r6h.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903201029290.10279@pacific.mpi-cbg.de> <20090320111238.GZ8940@machine.or.cz> <alpine.DEB.1.00.0903201245140.6865@intel-tinevez-2-302>
 <20090320115043.GB8940@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 20 12:59:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkdNE-0004yB-Ru
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 12:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbZCTL5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 07:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751974AbZCTL5S
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 07:57:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:36258 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751300AbZCTL5R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 07:57:17 -0400
Received: (qmail invoked by alias); 20 Mar 2009 11:57:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp059) with SMTP; 20 Mar 2009 12:57:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UGiE8wQDUIi41vyrkHzbuS+AGHvhhphz1tQY+Tc
	llycLK5D2XyEaY
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090320115043.GB8940@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113945>

Hi,

On Fri, 20 Mar 2009, Petr Baudis wrote:

> On Fri, Mar 20, 2009 at 12:46:19PM +0100, Johannes Schindelin wrote:
> 
> > On Fri, 20 Mar 2009, Petr Baudis wrote:
> > 
> > > On Fri, Mar 20, 2009 at 10:30:29AM +0100, Johannes Schindelin wrote:
> > > > On Thu, 19 Mar 2009, Junio C Hamano wrote:
> > > > 
> > > > > I think you are right.  It is just "git branch" and perhaps "git
> > > > > update-ref" are too loose in enforcing what can be created.
> > > > 
> > > > "git branch" I agree with, but not "git update-ref".  As plumbing, the 
> > > > latter should be much more allowing, feeding rope aplenty (but also 
> > > > allowing cool tricks we do not think about yet).
> > > 
> > > We shouldn't allow creating insane ref names even with update-ref. That
> > > way porcelains cannot rely on update-ref to sanity check the user's
> > > crap. At most, maybe you might want to bypass this check with some force
> > > switch, though I really can't quite imagine why.
> > 
> > You really cannot imagine?  You, the author of filter-branch?  People _do_ 
> > have fscked-up repositories, but they get really angry when they cannot 
> > use rebase or filter-branch on them.
> 
> They can rename the ref as the first step of a cleanup, can't they?

Well, of course, we can make life hard on everybody.  That is quite 
possible.

But then, we can be nice, and at the same time fix the problem _properly_.

IMHO a _warning_ should be the best thing.

But all this does not solve _my_ problem: I'd like something as easy to 
write as %next, but as unlikely to be used in existing refs as @{..}.

Ciao,
Dscho
