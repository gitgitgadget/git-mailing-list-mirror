From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 13:16:24 -0400
Message-ID: <20080826171623.GE5318@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org> <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Petr Baudis <pasky@suse.cz>, Andi Kleen <andi@firstfloor.org>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Kristian H??gsberg <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:17:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2Ad-00008z-Hw
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330AbYHZRQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbYHZRQ1
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:16:27 -0400
Received: from peff.net ([208.65.91.99]:4454 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbYHZRQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:16:26 -0400
Received: (qmail 32102 invoked by uid 111); 26 Aug 2008 17:16:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 26 Aug 2008 13:16:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2008 13:16:24 -0400
Content-Disposition: inline
In-Reply-To: <20080826171255.GI26523@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93770>

On Tue, Aug 26, 2008 at 10:12:55AM -0700, Shawn O. Pearce wrote:

> I'm the reason why count-objects, ls-tree and checkout-index are
> still offered by the bash completion.  And sitting here reading your
> email I realized its been _months_ since I last called checkout-index
> by hand.  I still run count-objects and ls-tree very so often, but the
> average user probably doesn't use ls-tree.
> 
> So yea, these probably should be removed from the completion list.
> But I can make a weak argument for keeping count-objects.

I think this message shows the conflict in setting up such a list. We
want the command set to be as tiny as possible to help new users find
their way. But we want the command set to be useful to git power users.

I wonder if there should be multiple sets of commands for completion,
with a minimal set enabled by default, and a "power user" set that
exposes extra commands. I dunno. Maybe that is overengineering. I don't
even use the bash completion at all.

-Peff
