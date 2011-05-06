From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout: honor advice.detachedHead when reattaching to
 a branch
Date: Fri, 6 May 2011 19:21:18 -0400
Message-ID: <20110506232118.GA24794@sigill.intra.peff.net>
References: <7vei4bzhwm.fsf@alter.siamese.dyndns.org>
 <20110506223847.GC17848@sigill.intra.peff.net>
 <7vbozfxwon.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 01:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIUL4-00047r-HX
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 01:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab1EFXVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 19:21:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33356
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841Ab1EFXVV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 19:21:21 -0400
Received: (qmail 14664 invoked by uid 107); 6 May 2011 23:23:16 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 May 2011 19:23:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 May 2011 19:21:18 -0400
Content-Disposition: inline
In-Reply-To: <7vbozfxwon.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173027>

On Fri, May 06, 2011 at 03:59:20PM -0700, Junio C Hamano wrote:

> > I tend to think (3) is now just useless.
> 
> Quite the contrary. If you do not want to pay the price of (4) that is
> useless most of the time, (3) is a cheap, space efficient and useful
> information that is essential to allow you to get rid of (4) without
> having to look at reflog.

Sorry, I should have been more clear. If you turn off orphan-checking,
(3) is just as useful as it always was. But _if_ you have
orphan-checking turned on, and it comes up negative, showing (3) is not
particularly useful. You already know you are not losing commits.

-Peff
