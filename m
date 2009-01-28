From: Jeff King <peff@peff.net>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 04:24:25 -0500
Message-ID: <20090128092425.GA2400@coredump.intra.peff.net>
References: <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com> <20090128020220.GE1321@spearce.org> <7v3af4yvmu.fsf@gitster.siamese.dyndns.org> <20090128033020.GF1321@spearce.org> <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org> <20090128044150.GI1321@spearce.org> <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org> <20090128075515.GA1133@coredump.intra.peff.net> <7vfxj3vos2.fsf@gitster.siamese.dyndns.org> <7vbptrvo0m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 10:25:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS6gC-0002ll-Iz
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 10:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbZA1JYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 04:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbZA1JY3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 04:24:29 -0500
Received: from peff.net ([208.65.91.99]:47580 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbZA1JY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 04:24:28 -0500
Received: (qmail 20456 invoked by uid 107); 28 Jan 2009 09:24:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 04:24:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 04:24:25 -0500
Content-Disposition: inline
In-Reply-To: <7vbptrvo0m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107513>

On Wed, Jan 28, 2009 at 12:22:01AM -0800, Junio C Hamano wrote:

> Nah, I take that back.
> 
> Even the original code does not consider this case an error.
> 
> If you really want that, the revision machinery needs major surgery, as I
> already noted that the design of mark_parents_uninteresting() wants to
> treat a missing uninteresting commit as a non-error event.

Hrm. Never mind my concern, then. I was worried that we were losing some
existing corruption checks, but it seems they are not there in the first
place.

-Peff
