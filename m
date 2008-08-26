From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 19:27:42 +0200
Message-ID: <20080826172742.GN26610@one.firstfloor.org>
References: <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org> <alpine.LFD.1.10.0808261004150.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>, Petr Baudis <pasky@suse.cz>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:26:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2JD-0002re-9A
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbYHZRZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbYHZRZS
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:25:18 -0400
Received: from one.firstfloor.org ([213.235.205.2]:55201 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYHZRZR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:25:17 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 8820D1B90084; Tue, 26 Aug 2008 19:27:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808261004150.3363@nehalem.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93774>

> When you do
> 
> 	ls<space><tab><tab>

Actually do ls --<tab><tab> and you can well be scared too. 
Perhaps it's not quite git class yet, but it's working on it.
I could imagine some Unix newbie be scared about that.

["Quick: mention the two characters not used as ls short options yet"]

> 
> and it says
> 
> 	Display all 122 possibilities? (y or n)
> 
> (yeah, my home directory is a mess)

It's quite tidy in fact :)

% ls <tab><tab>
Display all 584 possibilities? (y or n)

> 120-something commands? etc etc".

I was assuming someone thinking about using git. At some point
they will do the git<space><tab><tab> thing and be scared away.

Ok maybe it's not the first action, but it's likely in the first 10 
minutes; more or less once they discover that git has sub commands.

Anyways the real solution to that is either having less commands
or hiding the internal ones better. I think both would be fine,
but once that is done and there's a slimmed down non scary list,
there's no reason to not put the remaining non internal ones back 
into $PATH isn't it?

-Andi
