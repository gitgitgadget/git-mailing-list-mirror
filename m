From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 10:12:55 -0700
Message-ID: <20080826171255.GI26523@spearce.org>
References: <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org> <20080826171012.GO10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andi Kleen <andi@firstfloor.org>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Kristian H??gsberg <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:14:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY27L-0007Z9-D9
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149AbYHZRM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756048AbYHZRM4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:12:56 -0400
Received: from george.spearce.org ([209.20.77.23]:33163 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857AbYHZRM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:12:56 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 537A638375; Tue, 26 Aug 2008 17:12:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080826171012.GO10360@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93769>

Petr Baudis <pasky@suse.cz> wrote:
> On Tue, Aug 26, 2008 at 06:45:26PM +0200, Andi Kleen wrote:
> > 
> > It's not very convincing, because the bash completions script file for git 
> > is installed by default[1] which completes both forms, so the new user will 
> > experience instead:
> > 
> > git<space><tab><tab>.... what? 140-something commands? etc.etc.
> 
> No, the point of course is that you should get much less.
> 
> It offers 66 commands to me here, though it's still way too many - some
> of them are clearly plumbing: count-objects, ls-tree, checkout-index?
> Someone should submit a patch! ;-) (After eliminating these, this comes
> down to 56 commands - which is still a lot, but the numbers are getting
> somewhat sane already.)

I'm the reason why count-objects, ls-tree and checkout-index are
still offered by the bash completion.  And sitting here reading your
email I realized its been _months_ since I last called checkout-index
by hand.  I still run count-objects and ls-tree very so often, but the
average user probably doesn't use ls-tree.

So yea, these probably should be removed from the completion list.
But I can make a weak argument for keeping count-objects.

-- 
Shawn.
