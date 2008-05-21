From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Wed, 21 May 2008 15:47:34 -0400
Message-ID: <20080521194734.GA17321@sigill.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <20080328212900.GB9656@coredump.intra.peff.net> <7vve171m67.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 21:48:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyuIX-0002Ib-FT
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 21:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937100AbYEUTri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 15:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937081AbYEUTrh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 15:47:37 -0400
Received: from peff.net ([208.65.91.99]:4192 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937066AbYEUTrg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 15:47:36 -0400
Received: (qmail 23933 invoked by uid 111); 21 May 2008 19:47:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 21 May 2008 15:47:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2008 15:47:34 -0400
Content-Disposition: inline
In-Reply-To: <7vve171m67.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82574>

On Wed, May 21, 2008 at 12:39:44PM -0700, Junio C Hamano wrote:

> Last night I was going through old mail-logs and found this and another
> one that this is a follow-up to, which I think are still needed.  Does
> anybody see anything wrong with them?
>
> Jeff King <peff@peff.net> writes:
> 
> > We always use 'utf-8' as the encoding, since we currently
> > have no way of getting the information from the user.

Ah, thanks for bringing this up. I noticed a few weeks ago that it
hadn't been applied and meant to bring it up, but somehow I failed to
do so.

Obviously I'm in support of this one, but I also think Horst's patch
looks correct.

-Peff
