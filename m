From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 15:15:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807291511400.4631@eeepc-johanness>
References: <20080728162003.GA4584@artemis.madism.org> <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com> <20080728205545.GB10409@artemis.madism.org> <20080728205923.GC10409@artemis.madism.org> <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
 <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com> <20080729082135.GB32312@artemis.madism.org> <20080729083755.GC32312@artemis.madism.org> <20080729085125.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807291413460.4631@eeepc-johanness>
 <20080729130713.GF32312@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Benjamin Collins <aggieben@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 15:15:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNp2e-0007Pe-Pl
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 15:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbYG2NOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 09:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752422AbYG2NOD
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 09:14:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:36034 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751837AbYG2NOB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 09:14:01 -0400
Received: (qmail invoked by alias); 29 Jul 2008 13:13:59 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp010) with SMTP; 29 Jul 2008 15:13:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189Lnk+ork9DjBuQMmJFDDUrFgvnXV/TBt/mttON+
	HPB9BsO07wI0HJ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080729130713.GF32312@artemis.madism.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90634>

Hi,

On Tue, 29 Jul 2008, Pierre Habouzit wrote:

> On Tue, Jul 29, 2008 at 12:15:05PM +0000, Johannes Schindelin wrote:
> > On Tue, 29 Jul 2008, Petr Baudis wrote:
> > > On Tue, Jul 29, 2008 at 10:37:55AM +0200, Pierre Habouzit wrote:
> > > 
> > > > 	path = "$path"
> > > > 	url = git://somewhere/
> > > > 	tracks = master
> [...]
> > But then, how does the relation to the currently _committed_ state get 
> > displayed?
> 
> Hmm _that's_ why you need a name for it.

I do not understand.  We are talking about three different things here:

1) the committed state of the submodule
2) the local state of the submodule
3) the state of the "tracks" branch

We always have 1) and we have 2) _iff_ the submodule was checked out.  We 
only will have 3) if "tracks" is set in .git/config (for consistency's 
sake, we should not read that information directly from the .gitmodules 
file, but let the user override it in .git/config after "submodule init".

> Or you need the submodule to be aware he's one, and then one would have 
> some kind of "magic" word to name this sha1. And tools would find out in 
> the supermodule what it translates into.

You lost me there.

Ciao,
Dscho
