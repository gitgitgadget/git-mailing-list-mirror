From: Jeff King <peff@peff.net>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Fri, 24 Feb 2012 16:16:58 -0500
Message-ID: <20120224211658.GA30922@sigill.intra.peff.net>
References: <4F462E61.4020203@gmail.com>
 <m34nuhelnf.fsf@localhost.localdomain>
 <4F4643BB.8090001@gmail.com>
 <20120223193451.GB30132@sigill.intra.peff.net>
 <7vy5rt2u0c.fsf@alter.siamese.dyndns.org>
 <4F475689.4040203@gmail.com>
 <20120224095253.GC11846@sigill.intra.peff.net>
 <7vsji0xalg.fsf@alter.siamese.dyndns.org>
 <20120224204615.GB21447@sigill.intra.peff.net>
 <7vk43cx7c2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nikolaj Shurkaev <snnicky@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:17:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S12Vn-0007bN-AG
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 22:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226Ab2BXVRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 16:17:01 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56034
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab2BXVRA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 16:17:00 -0500
Received: (qmail 29106 invoked by uid 107); 24 Feb 2012 21:17:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 16:17:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 16:16:58 -0500
Content-Disposition: inline
In-Reply-To: <7vk43cx7c2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191481>

On Fri, Feb 24, 2012 at 01:14:05PM -0800, Junio C Hamano wrote:

> > True. That is also a slightly dangerous thing to do, though, because you
> > are omitting full patches in the middle that touch the same paths as the
> > patches you include....
> > ... So
> > perhaps we are better off to refer the user to git-log(1), say that
> > commit limiting options in general would work, but be careful with
> > sending a partial result.
> 
> You seem to have spelled out everything I originally wrote in my reply
> that I later deleted before sending it out, and I think the reason that
> brought you to the three-line conclusion is the same one that made me I
> delete them ;-).

OK, good. :)

Nikolaj, have you followed all of this? Do you want to try to improve
your patch in this direction?

-Peff
