From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 08:14:19 +0100
Message-ID: <1219907659.7107.230.camel@pmac.infradead.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	 <1219664940.9583.42.camel@pmac.infradead.org>
	 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
	 <20080826145719.GB5046@coredump.intra.peff.net>
	 <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
	 <20080827001705.GG23698@parisc-linux.org>
	 <7v63pmkozh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Matthew Wilcox <matthew@wil.cx>, Jeff King <peff@peff.net>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 09:19:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYbmm-0002XT-QH
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 09:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbYH1HSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 03:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbYH1HSM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 03:18:12 -0400
Received: from bombadil.infradead.org ([18.85.46.34]:45940 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbYH1HSL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 03:18:11 -0400
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by bombadil.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1KYbl4-0004W8-LC; Thu, 28 Aug 2008 07:17:30 +0000
In-Reply-To: <7v63pmkozh.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by bombadil.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2008-08-27 at 16:38 -0700, Junio C Hamano wrote:
> The discussion in this thread was about how to go forward from here, now
> the transition is over.  One of the future directions the transition was
> aiming at was removal of git-foo form for built-ins even from the libexec
> area -- I was complaining about David's beating an offtopic dead horse in
> the above, because it was throwing the thread in an off-track direction,
> distracting everybody from discussing what was more important, discussing
> constructively if/how to proceed from here.

I'm sorry you feel that way. The reason I didn't object back then was
almost certainly because I didn't notice the discussion. I open the git
mailing list folder so infrequently I might as well not be subscribed. 

But even if I _had_ seen the discussion, I might not have replied.
Life's too short to undertake a reasoned critique of every crack-addled
'plan' you see on the Internet. I'm not going to bother arguing with the
next person who asserts that we should turn Linux into a microkernel and
write it in C++, and I would have treated some idiotic plan to break git
in this way with just the same level of interest.

> Now the primary topic of what to do about built-ins have already settled.
> We _will_ keep git-foo commands in the libexec area.  We won't be removing
> them.

Excellent. All we need to do is make sure the distributions all set
$(gitexecdir) to /usr/bin when they upgrade to 1.6.0 -- and could you
also fix it on master.kernel.org please?

I believe we currently have to override $(gitexecdir) at make time --
could we have it as an option to ./configure, please?

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
