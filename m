From: Petr Baudis <pasky@suse.cz>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 22:36:31 +0200
Message-ID: <20080828203631.GX10360@machine.or.cz>
References: <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org> <23DFA9EC-9523-4179-BA3C-ACBDB82953DF@cs.indiana.edu> <alpine.DEB.1.10.0808271126190.10784@gandalf.stny.rr.com> <20080827230903.GB11005@flint.arm.linux.org.uk> <48B5E90E.3000601@s5r6.in-berlin.de> <20080828191956.GA7906@flint.arm.linux.org.uk> <7v63pkew9l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>,
	Kristian H??gsberg <krh@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Perry Wagle <wagle@cs.indiana.edu>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 22:37:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYoFQ-0005CW-Ab
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 22:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbYH1Ugf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 16:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbYH1Uge
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 16:36:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34836 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844AbYH1Uge (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 16:36:34 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B1680393A370; Thu, 28 Aug 2008 22:36:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v63pkew9l.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94135>

On Thu, Aug 28, 2008 at 01:10:14PM -0700, Junio C Hamano wrote:
> I think it is fair to say that I have vetoed and am still vetoing many "UI
> clean-ups" that propose to change things in a way that "should have been
> this way for consistency's sake from day one, if there were no existing
> user base".  During discussions to shoot down such proposals, I take
> opinions from early adopters (that's you, kernel, wine and x.org people)
> very seriously, perhaps to the point that outsiders would feel I am giving
> them disproportionately large vetoing power.  Sadly, those "opinions from
> eraly adopters" are less and less "real" but more "I'd imagine the early
> adopters would say..." these days.  The process would work better if early
> adopters do their part to help me by speaking up when it matters from time
> to time.

I think just freezing the UI is not a good answer. Git's UI evolved too
wildly and uncontrollably in the early days and I think in the long run,
tweaking out at least some of the inconsistencies is good idea, IMHO.
Not that I would think there should be any more *major* changes
upcoming, I mean mostly small stuff (all that I hate the
git-checkout/git-reset dichotomy or git-add/git-rm asymetry, touching
this would be just too radical change by now, IMHO).

The only problem I can see with the transition were the deprecation
messages, as was mentioned much earlier in the thread. If it's going
away in few years, Git should start to nag about it now. Then, all whom
it concerns _will_ realize this and slowly transition at their own pace.
Also, maybe we should require all internal references and documentation
updated when *declaring the feature deprecated* (not when removing it),
even if it means delaying the phase-out; that was the other major
complaint in this thread that is worth remembering, I believe.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
