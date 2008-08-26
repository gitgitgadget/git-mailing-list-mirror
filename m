From: Petr Baudis <pasky@suse.cz>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 19:35:12 +0200
Message-ID: <20080826173512.GS10544@machine.or.cz>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <80myizelcw.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Kristian H?gsberg <krh@redhat.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, users@kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:36:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2Sr-0005ap-9K
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205AbYHZRfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757226AbYHZRfQ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:35:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57294 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757128AbYHZRfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:35:15 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id D6CB73939B52; Tue, 26 Aug 2008 19:35:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <80myizelcw.fsf@tiny.isode.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93778>

On Tue, Aug 26, 2008 at 06:29:03PM +0100, Bruce Stephens wrote:
>   - it means git on Windows has the same interface
> 
> (Arguably the latter point ought to be "forces Unix users to use the
> same interface as on Windows", but the git-foo forms have been
> deprecated on all platforms for a while.  Making Unix and Windows the
> same seems a worthwhile goal, though presumably it's irrelevant for
> linux kernel people.)

I actually checked, and my msysgit installation does hardlinking (or at
least pretends to do, and ls -l shows high linkcounts). And somewhat
amusingly, it doesn't appear that 1.6.0 will be released for Windows
anytime soon, though that's of course not relevant from long term
perspective.

				Petr "Pasky" Baudis
