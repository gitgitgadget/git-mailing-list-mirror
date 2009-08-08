From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] verify-pack -v: do not report "chain length 0"
Date: Sat, 8 Aug 2009 00:11:05 -0400
Message-ID: <20090808041105.GA20339@coredump.intra.peff.net>
References: <1249702594-7815-1-git-send-email-gitster@pobox.com>
 <1249702594-7815-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 06:11:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZdHE-0004kX-3m
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 06:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbZHHELI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 00:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbZHHELI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 00:11:08 -0400
Received: from peff.net ([208.65.91.99]:41530 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbZHHELH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 00:11:07 -0400
Received: (qmail 23337 invoked by uid 107); 8 Aug 2009 04:13:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 08 Aug 2009 00:13:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Aug 2009 00:11:05 -0400
Content-Disposition: inline
In-Reply-To: <1249702594-7815-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125243>

On Fri, Aug 07, 2009 at 08:36:33PM -0700, Junio C Hamano wrote:

> +	if (baseobjects)
> +		printf("non delta: %lu object%s\n",
> +		       baseobjects, baseobjects > 1 ? "s" : "");

Nit: this should be "non-delta" or "no delta".

-Peff
