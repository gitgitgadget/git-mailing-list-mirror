From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Wed, 1 Jun 2016 17:08:32 -0400
Message-ID: <20160601210832.GB18118@sigill.intra.peff.net>
References: <xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com>
 <xmqqk2i8zxtx.fsf@gitster.mtv.corp.google.com>
 <20160601163747.GA10721@sigill.intra.peff.net>
 <20160601183100.GN1355@john.keeping.me.uk>
 <20160601190759.GB12496@sigill.intra.peff.net>
 <20160601191621.GO1355@john.keeping.me.uk>
 <xmqqinxsy9q0.fsf@gitster.mtv.corp.google.com>
 <20160601202852.GP1355@john.keeping.me.uk>
 <xmqq8tyoy6se.fsf@gitster.mtv.corp.google.com>
 <xmqq37owy6fr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 23:08:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8DNX-0004a0-EL
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 23:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbcFAVIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 17:08:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:47543 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750824AbcFAVIf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 17:08:35 -0400
Received: (qmail 28733 invoked by uid 102); 1 Jun 2016 21:08:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 17:08:35 -0400
Received: (qmail 5235 invoked by uid 107); 1 Jun 2016 21:08:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 17:08:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 17:08:32 -0400
Content-Disposition: inline
In-Reply-To: <xmqq37owy6fr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296166>

On Wed, Jun 01, 2016 at 01:56:08PM -0700, Junio C Hamano wrote:

> So here is the final version with a log message.
> 
> -- >8 --
> Subject: [PATCH] t5500 & t7403: lose bash-ism "local"
> [...]

Looks good. Thanks.

-Peff
