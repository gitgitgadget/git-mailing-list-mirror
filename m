From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote: allow "-t" with fetch mirrors
Date: Thu, 26 May 2011 11:28:56 -0400
Message-ID: <20110526152855.GA4120@sigill.intra.peff.net>
References: <20110526151100.GA2881@sigill.intra.peff.net>
 <4DDE7116.4070900@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jimmie WESTER <jimmie.wester@stericsson.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 26 17:29:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPcUx-00010i-G1
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766Ab1EZP3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:29:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33946
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932501Ab1EZP26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:28:58 -0400
Received: (qmail 12798 invoked by uid 107); 26 May 2011 15:28:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 11:28:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 11:28:56 -0400
Content-Disposition: inline
In-Reply-To: <4DDE7116.4070900@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174523>

On Thu, May 26, 2011 at 05:26:14PM +0200, Johannes Sixt wrote:

> Am 5/26/2011 17:11, schrieb Jeff King:
> > +	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
> > +		die("specifying branches to track makes no sense with non-fetch mirrors");
> 
> Don't proliferate no double negation. How about:
> 
> +		die("specifying branches to track makes sense only with fetch mirrors");

I can't fail to not disagree with your logic.

Junio, can you squash it in?

-Peff
