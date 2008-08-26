From: Petr Baudis <pasky@suse.cz>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 18:25:13 +0200
Message-ID: <20080826162513.GR10544@machine.or.cz>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Kristian H??gsberg <krh@redhat.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, users@kernel.org
To: Matthias Kestenholz <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Tue Aug 26 18:26:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY1N8-0001gV-7D
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 18:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbYHZQZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 12:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756032AbYHZQZQ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 12:25:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42375 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754329AbYHZQZP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 12:25:15 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 88F6B3939B52; Tue, 26 Aug 2008 18:25:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93757>

On Tue, Aug 26, 2008 at 06:04:00PM +0200, Matthias Kestenholz wrote:
> Correct, but there is a benefit. Imagine a new user:
> 
> git-<tab><tab> ... what? 140-something commands? I'll better start looking
> for alternatives _right now_!

Actually, this is the only realistic argument I can remember at all.
Are there any others? I couldn't come up with any - but I didn't do much
history digging: others seem to be equally in dark, though.

(And I'm not saying this one is not important; it's apparently a
significant "P.R." issue. But is just this _the_ official rationale?)

> Having a cluttered namespace is never a good thing. It means that it's
> less obvious which commands you are supposed to use etc.

This is not much of a valid argument; you could install the same set of
commands to /usr/bin that you are offering in the bash autocompletion.
(With the catch that this might break peoples scripts in a subtler way
than just removing all of them.)

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
