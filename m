From: Jeff King <peff@peff.net>
Subject: Re: How to still kill git fetch with too many refs
Date: Tue, 2 Jul 2013 01:28:27 -0400
Message-ID: <20130702052827.GA10626@sigill.intra.peff.net>
References: <201307012102.31384.mfick@codeaurora.org>
 <20130702040758.GA7068@sigill.intra.peff.net>
 <20130702044151.GB7068@sigill.intra.peff.net>
 <20130702050142.GA1206@sigill.intra.peff.net>
 <7vtxkd8rns.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 07:28:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utt8a-0006NU-G1
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 07:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613Ab3GBF2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 01:28:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:54185 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab3GBF2U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 01:28:20 -0400
Received: (qmail 18165 invoked by uid 102); 2 Jul 2013 05:29:29 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Jul 2013 00:29:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jul 2013 01:28:27 -0400
Content-Disposition: inline
In-Reply-To: <7vtxkd8rns.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229363>

On Mon, Jul 01, 2013 at 10:19:51PM -0700, Junio C Hamano wrote:

> > Like the patch below, which is built on top of next (which has Junio's
> > prio_queue implementation), and has both the priority queue fix for
> > rev_list_push and the mark_complete sort-at-the-end fix.
> 
> Wow, I saw "160 lines" in my MUA which scared me a bit until I
> opened it to realize 40% is discussion and most of the remaining
> lines are context around single liners.
> 
> It just looks too easy/simple, but the result looks correct, at
> least from a cursory read.
> 
> Good job ;-)

Thanks. :)

I'm splitting it out into readable patches now. At first I was made a
bit nervous by the "popping" behavior I described as "oddity #2"
earlier.  But the more I look at it, the more I am convinced it is
simply a bug that we can happen to fix along the way.

Patches in a few minutes.

-Peff
