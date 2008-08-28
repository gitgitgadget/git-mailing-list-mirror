From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 09:32:07 +0100
Message-ID: <1219912327.7107.245.camel@pmac.infradead.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	 <1219664940.9583.42.camel@pmac.infradead.org>
	 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
	 <20080826145719.GB5046@coredump.intra.peff.net>
	 <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
	 <20080827001705.GG23698@parisc-linux.org>
	 <7v63pmkozh.fsf@gitster.siamese.dyndns.org>
	 <1219907659.7107.230.camel@pmac.infradead.org>
	 <7vtzd5fta0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Matthew Wilcox <matthew@wil.cx>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 10:37:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYd0H-0006nT-0R
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 10:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbYH1IgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 04:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbYH1IgM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 04:36:12 -0400
Received: from bombadil.infradead.org ([18.85.46.34]:34122 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbYH1IgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 04:36:11 -0400
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by bombadil.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1KYcyM-0007oS-Fs; Thu, 28 Aug 2008 08:35:18 +0000
In-Reply-To: <7vtzd5fta0.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by bombadil.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2008-08-28 at 01:17 -0700, Junio C Hamano wrote:
> David Woodhouse <dwmw2@infradead.org> writes:
> 
> > Excellent. All we need to do is make sure the distributions all set
> > $(gitexecdir) to /usr/bin when they upgrade to 1.6.0 -- and could you
> > also fix it on master.kernel.org please?
> 
> Are you trying to irritate me even more?

Not at all; I'm sorry if that's the effect.

> Although I personally did not particularly like the "out of /usr/bin" move,
> this was done by user request.  I now am hated for doing something I was
> dragged into doing, not because I wanted the change, but only because many
> others wanted it, and you are dreaming that another pointless change will
> be made in the other direction?

I'm not asking you to make another change in upstream git. You've told
us the workaround (gitexecdir=/usr/bin), and that workaround is no
longer going to be deprecated, which is great. It's just up to us to
ensure that we use that workaround when we build git for ourselves, and
to ensure that our distributions also build packages using that
workaround.

Since I believe you're building the git packages used on kernel.org, I
was just asking you to apply the workaround when you build _those_
packages, that's all.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
