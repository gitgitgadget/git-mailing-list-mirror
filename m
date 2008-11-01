From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI
 revamp
Date: Sat, 1 Nov 2008 01:37:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811010137020.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <alpine.LFD.2.00.0810301024300.13034@xanadu.home> <20081030145253.GK14786@spearce.org> <20081030145928.GA21707@glandium.org> <20081030150135.GG24098@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 01:33:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw4QL-00010K-Ty
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 01:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbYKAAaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 20:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbYKAAaI
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 20:30:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:39753 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750756AbYKAAaG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 20:30:06 -0400
Received: (qmail invoked by alias); 01 Nov 2008 00:30:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 01 Nov 2008 01:30:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XPK1OWz/XdPZtzi9MRZVKC8E799dB8knaSDrP6I
	xZkLvX/Abm1myq
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081030150135.GG24098@artemis.corp>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99692>

Hi,

On Thu, 30 Oct 2008, Pierre Habouzit wrote:

> On Thu, Oct 30, 2008 at 02:59:28PM +0000, Mike Hommey wrote:
> > On Thu, Oct 30, 2008 at 07:52:53AM -0700, Shawn O. Pearce <spearce@spearce.org> wrote:
> > > +1 to Nico's NAK.
> > > 
> > > Although I was at the GitTogether I don't remember this change to
> > > checkout being discussed.  I must have been asleep reading email
> > > or something.  I am _NOT_ in favor of this change; I think the
> > > current behavior of "git checkout origin/master" is correct and as
> > > sane as we can make it.
> > 
> > Except he was talking about 'git checkout branch', not 'git checkout
> > origin/branch'. And I would be fine with 'git checkout branch' doing
> > what 'git checkout -b branch $remote/branch' does if $remote is unique
> > (i.e. there is no other 'branch' branch in any other remote) and the
> > 'branch' branch doesn't already exist.
> 
> Seconded.
> 
> Having git-checkout $foo being a shorthand for git checkout -b $foo
> origin/$foo when origin/$foo exists and $foo doesn't is definitely handy.

Have you guys actually checked out what

	git checkout -t origin/foo

does?

Ciao,
Dscho
