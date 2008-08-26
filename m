From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 13:07:48 -0400
Message-ID: <20080826170748.GB5318@coredump.intra.peff.net>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthias Kestenholz <mk@spinlock.ch>,
	David Woodhouse <dwmw2@infradead.org>,
	Kristian H??gsberg <krh@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, users@kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:09:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY22I-0005ei-T6
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbYHZRHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbYHZRHv
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:07:51 -0400
Received: from peff.net ([208.65.91.99]:4063 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbYHZRHu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:07:50 -0400
Received: (qmail 31910 invoked by uid 111); 26 Aug 2008 17:07:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 26 Aug 2008 13:07:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2008 13:07:48 -0400
Content-Disposition: inline
In-Reply-To: <20080826162513.GR10544@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93765>

On Tue, Aug 26, 2008 at 06:25:13PM +0200, Petr Baudis wrote:

> > git-<tab><tab> ... what? 140-something commands? I'll better start looking
> > for alternatives _right now_!
> 
> Actually, this is the only realistic argument I can remember at all.
> Are there any others? I couldn't come up with any - but I didn't do much
> history digging: others seem to be equally in dark, though.

The three reasons I can recall are:

  - too many commands on completion

  - confusion between "git-*" and "git *" equivalence, and inability to
    perform some operations with "git-*" (like git --no-pager).

  - I might be wrong, but I think there was discussion of a
    hardlink-challenged platform where we wasted space by copying the
    'git' binary. Taking git-* out of /usr/bin is the first step to
    removing the hardlinks entirely.

-Peff
