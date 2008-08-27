From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 23:52:33 +0100
Message-ID: <20080827225233.GA11005@flint.arm.linux.org.uk>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <7vr68b8q9p.fsf@gitster.siamese.dyndns.org> <20080827001705.GG23698@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, users@kernel.org
To: Matthew Wilcox <matthew@wil.cx>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYU8c-0000zJ-UY
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbYH0XIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753848AbYH0XIO
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:08:14 -0400
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42253 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbYH0XIN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arm.linux.org.uk; s=caramon; h=Date:From:To:Cc:Subject:
	Message-ID:References:Mime-Version:Content-Type:In-Reply-To:
	Sender; bh=u0OVH/N7sSTyrkGrV1ryERslGPa9K63w+RrUhum6Wek=; b=klfds
	czwVp3RqpY6DqQL3+RqMwC/xb93kZK0j7Jva/CnjHQ4f0OXOuuL1LHrilZIkvp4m
	5W0eKJpOW4AnvgkriuwdK/zRLhIIvNDwHjI1UZB9sZ+8HdGbfLII/DV8GwimJnKb
	xUqiBJGQM2GFvsHbB5HKbHY82b7ja6v+uNmqr4=
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1KYTsT-0003au-9P; Wed, 27 Aug 2008 23:52:37 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1KYTsQ-0003aW-Ki; Wed, 27 Aug 2008 23:52:34 +0100
Content-Disposition: inline
In-Reply-To: <20080827001705.GG23698@parisc-linux.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93977>

On Tue, Aug 26, 2008 at 06:17:05PM -0600, Matthew Wilcox wrote:
> On Tue, Aug 26, 2008 at 01:39:30PM -0700, Junio C Hamano wrote:
> > When I hear something like what David Woodhouse said in this thread, I
> > should be feeling "People -- those of you who claimed to be the silent
> > majority -- see, I told you so!  This is a very bad move".
> > 
> > But I can't.  People who complain _now_ just annoy me even more.  Why
> > weren't you defending the backward compatibility with me, which you seem
> > to value it so much, perhaps even more than I did back then?  Why are you
> > wasting our time bringing it up again, instead of joining the discussion
> > when it _mattered_ back then?
> 
> We didn't know the conversation was going on.  Why should we?  We only
> use the tool, not develop it.  I'm also not on the mailing lists for
> mutt, vim, gcc, binutils, openssh, grep, xchat, mozilla, gnome, xpdf or
> any of the dozens of other programs I use on a daily basis.

Well said Matthew, as a git _user_ I completely agree.

I only found out myself when it got installed on master.kernel.org, and
things that had worked fine for ages suddenly stopped working with no
clear solution.  Useless documentation which refers to the commands
which didn't seem to be in existence anymore was just, to put it mildly,
infuriating, and provided no answer.

That said, I've now updated all my scripts to not use the dashed version,
including on my local machines (which are still using git 1.5.4.x); the
only thing is I can't get out of the habbit of typing 'git-diff-tree -u'
if I want to see a single commit, or 'git-diff-files -u' if I want to
see (almost) everything in my working directory, or 'git-am'.  The
solution is trivial for when the dashed commands finally go away.

alias git-am='git am'
alias git-diff-files='git diff-files'

etc. in ~/.bashrc  So it's no real big hastle for me anymore.

-- 
Russell King
