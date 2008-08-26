From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 13:04:46 -0400
Message-ID: <20080826170446.GA5318@coredump.intra.peff.net>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Petr Baudis <pasky@suse.cz>, Matthias Kestenholz <mk@spinlock.ch>,
	Kristian H??gsberg <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:06:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY1zN-0004NV-Aa
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbYHZREt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbYHZREt
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:04:49 -0400
Received: from peff.net ([208.65.91.99]:4707 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139AbYHZREs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:04:48 -0400
Received: (qmail 31847 invoked by uid 111); 26 Aug 2008 17:04:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 26 Aug 2008 13:04:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2008 13:04:46 -0400
Content-Disposition: inline
In-Reply-To: <20080826164526.GM26610@one.firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93764>

On Tue, Aug 26, 2008 at 06:45:26PM +0200, Andi Kleen wrote:

> It's not very convincing, because the bash completions script file for git 
> is installed by default[1] which completes both forms, so the new user will 
> experience instead:
> 
> git<space><tab><tab>.... what? 140-something commands? etc.etc.

The bash completion has the luxury of not mentioning some commands if
they are likely to be confusing (i.e., very low-level plumbing).

That being said, it still produces 70-something commands.

-Peff
