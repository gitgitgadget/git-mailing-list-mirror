From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/14] introduce credentials API
Date: Fri, 22 Jul 2011 16:16:04 -0600
Message-ID: <20110722221602.GB14118@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718075034.GF12341@sigill.intra.peff.net>
 <7vy5zs4mxt.fsf@alter.siamese.dyndns.org>
 <20110722203901.GA11922@sigill.intra.peff.net>
 <7vtyaevupu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 00:16:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkO12-0000HV-Jr
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 00:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569Ab1GVWQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 18:16:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36837
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509Ab1GVWQL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 18:16:11 -0400
Received: (qmail 23897 invoked by uid 107); 22 Jul 2011 22:16:40 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Jul 2011 18:16:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2011 16:16:04 -0600
Content-Disposition: inline
In-Reply-To: <7vtyaevupu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177676>

On Fri, Jul 22, 2011 at 02:42:09PM -0700, Junio C Hamano wrote:

> >> The document did not say anything about escaping/quoting of values, but it
> >> may not be a bad idea to make it more explicit over there.
> >
> > There is no quoting or escaping. As the document says, "the value may
> > contain any bytes except a newline". It doesn't mention that keys cannot
> > contain an "=" or a newline, though that is also true.
> 
> This also was a documentation comment; "may contain any bytes" can be
> followed with "and used as-is" and I wouldn't have been confused.

Makes sense. I'll tweak for the next version.

-Peff
