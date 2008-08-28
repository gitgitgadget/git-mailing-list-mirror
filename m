From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 10:10:40 -0600
Message-ID: <20080828161040.GH18340@parisc-linux.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <7vr68b8q9p.fsf@gitster.siamese.dyndns.org> <20080827001705.GG23698@parisc-linux.org> <20080827225233.GA11005@flint.arm.linux.org.uk> <alpine.DEB.1.00.0808281733460.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	users@kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 28 18:12:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYk6N-0007ix-Ey
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 18:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbYH1QK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 12:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752952AbYH1QK5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 12:10:57 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:37516 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbYH1QK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 12:10:57 -0400
Received: by mail.parisc-linux.org (Postfix, from userid 26919)
	id C29DE494005; Thu, 28 Aug 2008 10:10:40 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808281733460.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94079>

On Thu, Aug 28, 2008 at 05:34:43PM +0200, Johannes Schindelin wrote:
> On Wed, 27 Aug 2008, Russell King wrote:
> > On Tue, Aug 26, 2008 at 06:17:05PM -0600, Matthew Wilcox wrote:
> > > We didn't know the conversation was going on.  Why should we?  We only
> > > use the tool, not develop it.  I'm also not on the mailing lists for
> > > mutt, vim, gcc, binutils, openssh, grep, xchat, mozilla, gnome, xpdf or
> > > any of the dozens of other programs I use on a daily basis.
> > 
> > Well said Matthew, as a git _user_ I completely agree.
> 
> So are you effectively saying that we should have asked on all the mailing 
> list of existing and potential Git users to ask their opinions?

No.  I'm effectively saying that *you shouldn't break backwards
compatibility*.  Ever.  It only annoys people.

Including:
 - The maintainer who has to listen to all this whining
 - Everyone who gets this thread cc'd in their inbox
 - People who hadn't been informed of the new way of doing things
 - People who thought they'd got their own way and now have to suffer
   the 'silent majority' speaking up.
 - Linus

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
