From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
 whitespace.
Date: Mon, 28 Apr 2008 19:07:57 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804281902040.19187@eeepc-johanness>
References: <20080427151610.GB57955@Hermes.local> <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness> <7vej8rgq62.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281112500.2949@eeepc-johanness> <slrng1bdsf.25r.joerg@alea.gnuu.de>
 <alpine.DEB.1.00.0804281409030.5399@eeepc-johanness> <20080428163003.GA6449@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-369898738-1209406077=:19187"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 20:09:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqXmc-0004lt-Ob
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 20:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965363AbYD1SHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 14:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbYD1SHt
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 14:07:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:41992 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964914AbYD1SHr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 14:07:47 -0400
Received: (qmail invoked by alias); 28 Apr 2008 18:07:45 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp026) with SMTP; 28 Apr 2008 20:07:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XDaZ2xC1XVaehSGVGwA3ohCEEgpA1+cM4d137Vc
	8ZhRQCRMhxc8kI
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080428163003.GA6449@alea.gnuu.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80574>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-369898738-1209406077=:19187
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 28 Apr 2008, Jörg Sommer wrote:

> Johannes Schindelin schrieb am Mon 28. Apr, 14:42 (+0100):
> > On Mon, 28 Apr 2008, Jörg Sommer wrote:
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > On Sun, 27 Apr 2008, Junio C Hamano wrote:
> > > >
> > > >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > >> 
> > > >> > ...  It did not help that I hated the fact that that series changed 
> > > >> > the original design without even understanding it.
> > > >> 
> > > >> Care to elaborate on this point further?  I do not get it.
> > > >
> > > > The original implementation of -p was modeled closely after 
> > > > filter-branch, in that it created a subdirectory (dotest/rewritten) 
> > > > containing the new commit names for those commits that were rewritten.
> > > 
> > > But that wasn't the way rebase -i works.
> > 
> > I know exactly how it works. D'oh.
> > 
> > > You had to jump in before pick_one does anything which clearly shows you 
> > > did something different from the default way.
> > 
> > That is bullshit.  I did not do anything "different from the default way".  
> > I carefully designed an interface that was easy to understand, because it 
> > mimicked how you would do the same _by hand_, but without the hassle to 
> > actually having to do everything by hand.
> > 
> > In other words, rebase -i is just a cherry-pick in a loop.
> 
> But not rebase -i -p.

Yes.  With the exception that you have to checkout and merge in the loop, 
too.

> > And _exactly_ the same should have been done for -p.
> 
> But you didn't do it.

Very well done.  If your intention is to piss me off: you succeeded.

_OF COURSE_ I did not do it.  That is why it was not working.

But you could have fixed that.

Instead, you chose to complicate things.

> > Namely, _not_ introduce some artificial marks, but use the _commit 
> > names_!
> 
> I don't buy, you don't use marks (notes on paper or git tags) when you 
> rebase a branch with at least 8 commits and 2 merges.
> 
> And Junio discribed how he would do such a rebase and it included marks. 
> And I follow how. So no, they aren't artificial.

So you again ignored completely the argument I made.

Brilliant.

The same issue is _totally_ the same _without_ -p!

And you cannot fix the problem by introducing another one.

You can try to complicate things even further, sure, but you will not 
change the fact that this is no solution at all.

Well, I refuse to let you insult my intelligence any more.

Ciao,
Dscho

--658432-369898738-1209406077=:19187--
