From: Jeff King <peff@peff.net>
Subject: Re: Git + SFC Status Update
Date: Thu, 16 Apr 2015 05:31:26 -0400
Message-ID: <20150416093126.GB18135@peff.net>
References: <20150413115613.GA4589@peff.net>
 <1429173474310-7628850.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 11:31:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yig9F-0007wF-OR
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 11:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933529AbbDPJbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 05:31:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:46149 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933499AbbDPJba (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 05:31:30 -0400
Received: (qmail 23437 invoked by uid 102); 16 Apr 2015 09:31:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 04:31:29 -0500
Received: (qmail 23796 invoked by uid 107); 16 Apr 2015 09:31:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 05:31:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 05:31:26 -0400
Content-Disposition: inline
In-Reply-To: <1429173474310-7628850.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267273>

On Thu, Apr 16, 2015 at 01:37:54AM -0700, Yi EungJun wrote:

> >  - Written policy: https://git-scm.com/trademark
> 
> My browser shows an "Untrusted Connection" page when click the link.
> 
> Does git-scm have no TLS certificate?

Hmm, you're right. It has a *.herokuapp.com cert. That's fine for
hitting https://git-scm.herokuapp.com, but obviously not when you use
the custom domain. I think I manually accepted the cert long ago and
forgot about it.

Looks like somebody opened

  https://github.com/git/git-scm.com/issues/489

but nobody has dealt with it. I have no idea what the recommended setup
is for dealing with TLS and custom domains on Heroku.

-Peff
