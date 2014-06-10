From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/17] store length of commit->buffer
Date: Tue, 10 Jun 2014 17:46:16 -0400
Message-ID: <20140610214616.GA19107@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
 <20140610213509.GA26979@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 23:46:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTs6-0001VI-Cn
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbaFJVqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:46:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:41456 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753136AbaFJVqR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:46:17 -0400
Received: (qmail 20212 invoked by uid 102); 10 Jun 2014 21:46:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 16:46:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 17:46:16 -0400
Content-Disposition: inline
In-Reply-To: <20140610213509.GA26979@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251263>

On Tue, Jun 10, 2014 at 05:35:09PM -0400, Jeff King wrote:

> Here's a re-roll of the commit-slab series. It fixes the issues pointed
> out by Eric and Christian (thanks, both).

Side note: I marked this as v2, but forgot to do so in each individual
patch (I write my cover letters first, and then issue format-patch as a
separate step, and I sometimes forget -v2 there). How big an
inconvenience is this?

When I was acting maintainer, it didn't bother me, as I picked the
patches up via threading. But if it is annoying, I can try to teach my
scripts to do it automatically, so I stop forgetting.

-Peff
