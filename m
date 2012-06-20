From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 01/11] Makefile: sort LIB_H list
Date: Wed, 20 Jun 2012 16:01:51 -0400
Message-ID: <20120620200151.GA388@sigill.intra.peff.net>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183008.GA30995@sigill.intra.peff.net>
 <7vwr31u532.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:02:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShR6F-000106-2C
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 22:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757657Ab2FTUBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 16:01:55 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39202
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754415Ab2FTUBz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 16:01:55 -0400
Received: (qmail 29018 invoked by uid 107); 20 Jun 2012 20:01:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 16:01:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 16:01:51 -0400
Content-Disposition: inline
In-Reply-To: <7vwr31u532.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200352>

On Wed, Jun 20, 2012 at 01:00:01PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This was mostly sorted already, but put things like
> > "cache-tree.h" after "cache.h", even though "-" comes before
> > "." (at least in the C locale). This will make it easier to
> > keep the list sorted later by piping it through "sort".
> 
> I agree this would make it easier to blindly run "sort", but I think
> the result hurts scannability.  Is it a good change?

I don't personally see a difference, but if you do, I don't care that
much about this patch. The main motive was that the next patch involved
adding 10 new entries, and I didn't want to have to insert them
manually into the correct sorting spots.

-Peff
