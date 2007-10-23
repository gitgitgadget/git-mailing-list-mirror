From: Theodore Tso <tytso@mit.edu>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 23 Oct 2007 00:56:32 -0400
Message-ID: <20071023045632.GD27132@thunk.org>
References: <20071016060456.GC13801@spearce.org> <Pine.LNX.4.64.0710161209480.25221@racer.site> <20071016195744.GB32132@closure.lan> <7v3aw2aaxu.fsf@gitster.siamese.dyndns.org> <20071023012140.GC22997@thunk.org> <7vtzoi8voo.fsf@gitster.siamese.dyndns.org> <20071023020044.GA27132@thunk.org> <20071023040522.GX14735@spearce.org> <20071023043321.GC27132@thunk.org> <20071023044657.GC14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 06:57:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkBpA-0005lK-Bu
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 06:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbXJWE4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 00:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbXJWE4u
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 00:56:50 -0400
Received: from thunk.org ([69.25.196.29]:59556 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbXJWE4t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 00:56:49 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IkBym-0001KZ-GF; Tue, 23 Oct 2007 01:07:00 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IkBoe-0007Xe-Bj; Tue, 23 Oct 2007 00:56:32 -0400
Content-Disposition: inline
In-Reply-To: <20071023044657.GC14735@spearce.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62090>

On Tue, Oct 23, 2007 at 12:46:57AM -0400, Shawn O. Pearce wrote:
> By merging only individual topics forked from master into next you
> can merge those individual topics into master at different points
> in time.  For example db/fetch-pack has been in next for many weeks
> and hasn't yet merged into master, yet jc/am-quiet was forked after
> db/fetch-pack started and has already merged into master.
> 
> Your way would make jc/am-quiet wait until db/fetch-pack was ready.
> That's a big risk in the sense that your tree is "blocked" and even
> simple changes are held up by ones that suddenly became a lot more
> complex then you originally thought they were going to be.

Yes, true.  Alternatively, what I've been doing is that if I wasn't
sure that a particular topic was ready to go to 'master' very shortly
after it went into 'next', I would never let it go into 'next', but
rather keep it in 'pu' (which is OK, because pu is constantly getting
rewound).  But I guess the downside of that is you might get fewer
testers for the code, because fewer people are probably tracking and
testing 'pu' as compared to 'next'.

Right?

					- Ted
