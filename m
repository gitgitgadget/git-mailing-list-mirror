From: Ted Ts'o <tytso@mit.edu>
Subject: Re: jk/tag-contains: stalled
Date: Thu, 5 Aug 2010 16:36:33 -0400
Message-ID: <20100805203633.GL2901@thunk.org>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
 <20100805001629.GC2901@thunk.org>
 <7vsk2tdnv5.fsf@alter.siamese.dyndns.org>
 <7vhbj9dm6h.fsf@alter.siamese.dyndns.org>
 <20100805173635.GA15760@sigill>
 <7vy6ckdhhu.fsf@alter.siamese.dyndns.org>
 <20100805190653.GA2942@sigill>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 05 22:37:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh7BV-0001lt-Kl
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 22:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759299Ab0HEUgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 16:36:40 -0400
Received: from thunk.org ([69.25.196.29]:41053 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933205Ab0HEUgi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 16:36:38 -0400
Received: from root (helo=tytso-glaptop)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1Oh7B5-00054j-Gv; Thu, 05 Aug 2010 16:36:35 -0400
Received: from tytso by tytso-glaptop with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1Oh7B3-00039W-QR; Thu, 05 Aug 2010 16:36:33 -0400
Content-Disposition: inline
In-Reply-To: <20100805190653.GA2942@sigill>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152712>

On Thu, Aug 05, 2010 at 03:06:54PM -0400, Jeff King wrote:
> But my intent was to have a generic contains function. I was planning on
> applying this to "git branch --contains", as well, but my initial
> approach wasn't really any faster than the current code (probably
> because the number of branches tends to be small compared to the number
> of tags).

At work we have some 100 topics branches per kernel revision, and I
have a repository with 332 branches in it at the moment.  So there may
very well be repo's where git branch --contains might be faster with
your approach.

							- Ted
