From: Jeff King <peff@peff.net>
Subject: Re: [RCF/PATCH] Makefile: move 'ifdef DEVELOPER' after config.mak*
 inclusion
Date: Wed, 1 Jun 2016 04:05:04 -0400
Message-ID: <20160601080504.GB22528@sigill.intra.peff.net>
References: <20160531132443.5033-1-Matthieu.Moy@imag.fr>
 <20160601073037.GA14096@sigill.intra.peff.net>
 <vpqpos11gv3.fsf@anie.imag.fr>
 <20160601080348.GA22528@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 01 10:05:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b819U-0002Hc-3F
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 10:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757610AbcFAIFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 04:05:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:47062 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754341AbcFAIFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 04:05:08 -0400
Received: (qmail 25641 invoked by uid 102); 1 Jun 2016 08:05:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 04:05:08 -0400
Received: (qmail 31216 invoked by uid 107); 1 Jun 2016 08:05:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 04:05:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 04:05:04 -0400
Content-Disposition: inline
In-Reply-To: <20160601080348.GA22528@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296067>

On Wed, Jun 01, 2016 at 04:03:48AM -0400, Jeff King wrote:

> Perhaps:
> 
>   DEVELOPER_CFLAGS += -Wfoo
>   DEVELOPER_CFLAGS += -Wbar
>   ...
>   -include config.mak
>   ...
>   ifdef DEVELOPER
>   CFLAGS += $(DEVELOPER_CFLAGS)
>   endif
> 
> would be more flexible.

Heh, our mails crossed, but I see you had the same idea. I think it is a
strict improvement.

-Peff
