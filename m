From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 20:09:26 +0200
Message-ID: <20080826180926.GA25711@isilmar.linta.de>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 20:10:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2zx-0000tO-29
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 20:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbYHZSJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 14:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbYHZSJ3
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 14:09:29 -0400
Received: from isilmar.linta.de ([213.133.102.198]:42103 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752571AbYHZSJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 14:09:28 -0400
Received: (qmail 27628 invoked by uid 1000); 26 Aug 2008 18:09:26 -0000
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93791>

Linus,

On Tue, Aug 26, 2008 at 10:03:25AM -0700, Linus Torvalds wrote:
> > Nice emotive response, especially the subtle but unsubstantiated 'silent
> > majority in favour' bit -- but you forgot the part where you were
> > supposed to actually point out a tangible benefit which is achieved by
> > breaking compatibility like this.
> 
> Umm. The 'git-xyzzy' thing has been one of the #1 complaints since pretty 
> much day#1.

But _why_ do they complain? Just whining or real reasons?

> Also, like it or not, it's done. So the argument about "compatibility" is 
> TOTAL AND UTTER BULLSHIT. There is no compatibility, because we already 
> released a major version without them.

Then release a 1.6.0.1. But the major problem is something else: it's that
doing PATH="$PATH:$(git --exec-path) is also deprecated, i.e. that workaround
is to go away in one of the next releases too.

>  - new people don't even learn the mistakes

But new people read "git-diff-tree" in the man pages, and then wonder why
"git-diff-tree" does not work. People read howtos in the Documentation/
directory and wonder why executing "git-diff-tree" does not work. Besides,
why it is a "mistake" to use git-xyzyy? Also, note that 1.5.4.x man pages
uses git-xyzzy form in many many places, not hinting at all of git-xyzyy
being deprecated.

> and there really is zero downside apart from the _trivial_ downside of you 
> just having to add a single PATH thing to your .bashrc or something.

downsides:

- man pages. man git-add for the command "git add" is a bit...
  disappointing.

- lots of documentation using "git-xyzyy"

- the PATH workaround being deprecated

Best,
	Dominik
