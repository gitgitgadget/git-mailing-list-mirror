From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 18:45:26 +0200
Message-ID: <20080826164526.GM26610@one.firstfloor.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Kestenholz <mk@spinlock.ch>,
	Kristian H??gsberg <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 26 18:44:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY1ed-0007Bk-7S
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 18:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757342AbYHZQnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 12:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757205AbYHZQnD
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 12:43:03 -0400
Received: from one.firstfloor.org ([213.235.205.2]:47841 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757342AbYHZQnB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 12:43:01 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 1C08E1B90085; Tue, 26 Aug 2008 18:45:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080826162513.GR10544@machine.or.cz>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93760>

On Tue, Aug 26, 2008 at 06:25:13PM +0200, Petr Baudis wrote:
> On Tue, Aug 26, 2008 at 06:04:00PM +0200, Matthias Kestenholz wrote:
> > Correct, but there is a benefit. Imagine a new user:
> > 
> > git-<tab><tab> ... what? 140-something commands? I'll better start looking
> > for alternatives _right now_!
> 
> Actually, this is the only realistic argument I can remember at all.

It's not very convincing, because the bash completions script file for git 
is installed by default[1] which completes both forms, so the new user will 
experience instead:

git<space><tab><tab>.... what? 140-something commands? etc.etc.

Someone didn't think this through?

I won't disagree that the 140 commands thing is a problem -- I remember
thinking the same thoughts and I am still scared occasionally by
the multitude of commands. But that doesn't seem to be the solution.

-Andi

[1] At least it's in my openSUSE build service git-core rpm by default.
