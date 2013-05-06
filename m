From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 6 May 2013 13:41:58 -0400
Message-ID: <20130506174158.GA23213@sigill.intra.peff.net>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
 <1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
 <20130506123111.GB3809@sigill.intra.peff.net>
 <7v7gjctabm.fsf@alter.siamese.dyndns.org>
 <20130506162008.GB7992@sigill.intra.peff.net>
 <7vli7srrva.fsf@alter.siamese.dyndns.org>
 <20130506164046.GA20257@sigill.intra.peff.net>
 <7v8v3srpsa.fsf@alter.siamese.dyndns.org>
 <20130506171935.GA21892@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 06 19:42:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZPQS-0000d1-4S
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 19:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128Ab3EFRmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 13:42:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:40098 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755101Ab3EFRmA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 13:42:00 -0400
Received: (qmail 18153 invoked by uid 102); 6 May 2013 17:42:20 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 12:42:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 13:41:58 -0400
Content-Disposition: inline
In-Reply-To: <20130506171935.GA21892@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223478>

On Mon, May 06, 2013 at 01:19:35PM -0400, Jeff King wrote:

> > Here is what I tentatively queued.
> > [...]
> 
> Yeah, that is much for to understand (to me, at least).

Ugh. That was supposed to be "much easier to understand". Perhaps I will
learn to type one day.

-Peff
