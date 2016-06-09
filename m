From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Adds *~ to the .gitignore
Date: Thu, 9 Jun 2016 19:31:18 -0400
Message-ID: <20160609233118.GA25709@sigill.intra.peff.net>
References: <1465506629-16577-1-git-send-email-Lars.Vogel@vogella.com>
 <xmqqh9d2girw.fsf@gitster.mtv.corp.google.com>
 <20160609213809.GA23059@sigill.intra.peff.net>
 <xmqqd1nqges3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Vogel <lars.vogel@gmail.com>, git@vger.kernel.org,
	Lars Vogel <Lars.Vogel@vogella.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 01:31:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB9QA-0006cB-6z
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 01:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbcFIXbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 19:31:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:52191 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751902AbcFIXbW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 19:31:22 -0400
Received: (qmail 7573 invoked by uid 102); 9 Jun 2016 23:31:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 19:31:21 -0400
Received: (qmail 28639 invoked by uid 107); 9 Jun 2016 23:31:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 19:31:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2016 19:31:18 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd1nqges3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296939>

On Thu, Jun 09, 2016 at 03:48:12PM -0700, Junio C Hamano wrote:

> As I said, however, I could support a move to add some selected
> small number of common file extensions, as long as we have some
> (social) mechanism to avoid churning this file every time somebody
> new comes and complains their favourite editor or other tools are
> not supported.

Yeah, I don't mind it either, myself, provided we avoid the churn.

OTOH, wouldn't somebody who cared about this want it for all of their
projects? I guess I just don't see the point in making this a
git-specific thing.

-Peff
