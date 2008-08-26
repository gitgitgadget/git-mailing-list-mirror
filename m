From: Petr Baudis <pasky@suse.cz>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 19:10:12 +0200
Message-ID: <20080826171012.GO10360@machine.or.cz>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Kestenholz <mk@spinlock.ch>,
	Kristian H??gsberg <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:11:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY24f-0006cn-Mi
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006AbYHZRKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbYHZRKQ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:10:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49182 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664AbYHZRKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:10:16 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 80CF83939B52; Tue, 26 Aug 2008 19:10:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080826164526.GM26610@one.firstfloor.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93767>

On Tue, Aug 26, 2008 at 06:45:26PM +0200, Andi Kleen wrote:
> On Tue, Aug 26, 2008 at 06:25:13PM +0200, Petr Baudis wrote:
> > On Tue, Aug 26, 2008 at 06:04:00PM +0200, Matthias Kestenholz wrote:
> > > Correct, but there is a benefit. Imagine a new user:
> > > 
> > > git-<tab><tab> ... what? 140-something commands? I'll better start looking
> > > for alternatives _right now_!
> > 
> > Actually, this is the only realistic argument I can remember at all.
> 
> It's not very convincing, because the bash completions script file for git 
> is installed by default[1] which completes both forms, so the new user will 
> experience instead:
> 
> git<space><tab><tab>.... what? 140-something commands? etc.etc.

No, the point of course is that you should get much less.

It offers 66 commands to me here, though it's still way too many - some
of them are clearly plumbing: count-objects, ls-tree, checkout-index?
Someone should submit a patch! ;-) (After eliminating these, this comes
down to 56 commands - which is still a lot, but the numbers are getting
somewhat sane already.)

				Petr "Pasky" Baudis
