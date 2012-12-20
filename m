From: Jeff King <peff@peff.net>
Subject: Re: $PATH pollution and t9902-completion.sh
Date: Thu, 20 Dec 2012 15:01:09 -0500
Message-ID: <20121220200109.GC21785@sigill.intra.peff.net>
References: <20121217010538.GC3673@gmail.com>
 <20121220145519.GB27211@sigill.intra.peff.net>
 <7vk3sc606f.fsf@alter.siamese.dyndns.org>
 <7vobho4hxa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Spiers <git@adamspiers.org>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 21:01:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlmJ8-00080f-CC
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 21:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab2LTUBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 15:01:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60025 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab2LTUBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 15:01:11 -0500
Received: (qmail 14478 invoked by uid 107); 20 Dec 2012 20:02:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Dec 2012 15:02:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2012 15:01:09 -0500
Content-Disposition: inline
In-Reply-To: <7vobho4hxa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211923>

On Thu, Dec 20, 2012 at 11:55:45AM -0800, Junio C Hamano wrote:

> The beginning of such a change may look like the attached patch.
> [...]
> +test_fully_contains () {
> +	sort "$1" >expect.sorted &&
> +	sort "$2" >actual.sorted &&
> +	test $(comm -23 expect.sorted actual.sorted | wc -l) = 0
> +}

I like the direction. I suspect test_fully_contains could be used in a
lot of other places, too.

-Peff
