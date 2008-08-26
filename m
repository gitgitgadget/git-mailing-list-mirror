From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 20:42:54 +0300
Message-ID: <20080826174254.GA8441@mithlond.arda.local>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826170748.GB5318@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Matthias Kestenholz <mk@spinlock.ch>,
	David Woodhouse <dwmw2@infradead.org>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, users@kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:45:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2bM-0000Aj-3u
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379AbYHZRoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757239AbYHZRoA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:44:00 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:54863 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756686AbYHZRoA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:44:00 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 489066C501327C94; Tue, 26 Aug 2008 20:43:03 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KY2ZC-0002G1-Ks; Tue, 26 Aug 2008 20:42:54 +0300
Content-Disposition: inline
In-Reply-To: <20080826170748.GB5318@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93785>

Jeff King wrote (2008-08-26 13:07 -0400):

> On Tue, Aug 26, 2008 at 06:25:13PM +0200, Petr Baudis wrote:
> 
> > > git-<tab><tab> ... what? 140-something commands? I'll better start
> > > looking for alternatives _right now_!
> > 
> > Actually, this is the only realistic argument I can remember at all.
> > Are there any others? I couldn't come up with any - but I didn't do
> > much history digging: others seem to be equally in dark, though.
> 
> The three reasons I can recall are:

Don't know about "original" reasons but filling users' ~/bin isn't nice 
either. I always install all of the self-built git under $HOME. Since 
"make install" (by default) used to fill ~/bin with those 140 git-* 
executables I already configured git to install itself to a custom 
directory. I had to use $GIT_EXEC_PATH and create some symlinks but with 
1.6.0 I don't have to do this anymore. Me happy.

Setting $GIT_EXEC_PATH wasn't a big deal and I can't see it being a big 
deal now, for some other people, to extend their $PATH to include every  
imaginable git-* executable in the system.

BTW I'd also vote for reducing the number of commands printed with "git 
<tab><tab>" bash-completion.
