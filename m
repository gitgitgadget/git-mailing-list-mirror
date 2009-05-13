From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] log: prettier decorations
Date: Wed, 13 May 2009 17:28:12 -0400
Message-ID: <20090513212812.GA21268@coredump.intra.peff.net>
References: <1242249726-8514-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 23:28:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Lzn-0000Mq-FV
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759944AbZEMV2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 17:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756645AbZEMV2A
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:28:00 -0400
Received: from peff.net ([208.65.91.99]:39312 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551AbZEMV17 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 17:27:59 -0400
Received: (qmail 18608 invoked by uid 107); 13 May 2009 21:28:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 13 May 2009 17:28:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2009 17:28:12 -0400
Content-Disposition: inline
In-Reply-To: <1242249726-8514-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119112>

On Thu, May 14, 2009 at 12:22:03AM +0300, Felipe Contreras wrote:

> In order to do that I had to change prettify_ref to prettify_refname because
> add_ref_decoration doesn't have the ref object.

Thanks, this 1/3 looks fine to me.

But:

> Felipe Contreras (3):
>   Change prettify_ref to prettify_refname
>   Prettify log decorations even more
>   Fix test for new log decorate

Shouldn't 2/3 and 3/3 just be squashed together? It looks like 3/3 fixes
tests broken in 2/3, so you are hurting bisectability if they don't
happen together.

Other than that, I think the intent of the change and the implementation
look fine.

-Peff
