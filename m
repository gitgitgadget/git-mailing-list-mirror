From: Jeff King <peff@peff.net>
Subject: Re: t0300-credentials: poll failed: invalid argument
Date: Mon, 29 Aug 2011 13:43:09 -0400
Message-ID: <20110829174309.GA11524@sigill.intra.peff.net>
References: <5C993C44-D045-4344-95C1-94D3E6DB0316@silverinsanity.com>
 <20110829171411.GB756@sigill.intra.peff.net>
 <01E9C05C-A19D-45B0-B15D-DA6B911C11A9@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 19:43:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy5rk-00008M-25
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 19:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643Ab1H2RnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 13:43:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54367
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733Ab1H2RnO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 13:43:14 -0400
Received: (qmail 18914 invoked by uid 107); 29 Aug 2011 17:43:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Aug 2011 13:43:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2011 13:43:09 -0400
Content-Disposition: inline
In-Reply-To: <01E9C05C-A19D-45B0-B15D-DA6B911C11A9@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180326>

On Mon, Aug 29, 2011 at 01:28:05PM -0400, Brian Gernhardt wrote:

> > Ugh, sorry, this is my fault. The check_expiration() function can return
> > a totally bogus value before we actually get any credentials.
> > 
> > Does this patch fix it for you?
> 
> Yes it does!  Surprisingly enough, non-bogus parameters keeps poll
> from erroring with EINVAL.  Funny that.  ;-)

Great. I'm working on a few more patches on top of that topic, so I'll
add it to my list to send out in the next day or so.

-Peff
