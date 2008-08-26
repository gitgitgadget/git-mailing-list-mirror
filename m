From: Willy Tarreau <w@1wt.eu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 23:06:31 +0200
Message-ID: <20080826210631.GC3812@1wt.eu>
References: <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com> <20080826162513.GR10544@machine.or.cz> <20080826164526.GM26610@one.firstfloor.org> <20080826171012.GO10360@machine.or.cz> <20080826171255.GI26523@spearce.org> <20080826171623.GE5318@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Andi Kleen <andi@firstfloor.org>,
	Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 23:09:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY5nZ-0002ue-FU
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 23:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbYHZVIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 17:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbYHZVIx
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 17:08:53 -0400
Received: from 1wt.eu ([62.212.114.60]:2836 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435AbYHZVIw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 17:08:52 -0400
Content-Disposition: inline
In-Reply-To: <20080826171623.GE5318@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93822>

On Tue, Aug 26, 2008 at 01:16:24PM -0400, Jeff King wrote:
> On Tue, Aug 26, 2008 at 10:12:55AM -0700, Shawn O. Pearce wrote:
> 
> > I'm the reason why count-objects, ls-tree and checkout-index are
> > still offered by the bash completion.  And sitting here reading your
> > email I realized its been _months_ since I last called checkout-index
> > by hand.  I still run count-objects and ls-tree very so often, but the
> > average user probably doesn't use ls-tree.
> > 
> > So yea, these probably should be removed from the completion list.
> > But I can make a weak argument for keeping count-objects.
> 
> I think this message shows the conflict in setting up such a list. We
> want the command set to be as tiny as possible to help new users find
> their way. But we want the command set to be useful to git power users.
> 
> I wonder if there should be multiple sets of commands for completion,
> with a minimal set enabled by default, and a "power user" set that
> exposes extra commands. I dunno. Maybe that is overengineering. I don't
> even use the bash completion at all.

The problem is not caused by the number of commands, but by their
complexity. I need completion because it's hard to type their very
long names without making mistakes (not counting the long options).
"git am" is fine with me, but "git format-patch" is quite boring to
type. It's also interesting to note that short names are currently
in place for less commonly used commands : git-rm, git-mv, git-gc.

Willy
