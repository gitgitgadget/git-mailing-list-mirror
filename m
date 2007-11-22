From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] Teach builtin-add to pass multiple paths to
	git-add--interactive
Date: Thu, 22 Nov 2007 06:37:35 -0500
Message-ID: <20071122113735.GC12913@sigill.intra.peff.net>
References: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <1195689773-28601-1-git-send-email-win@wincent.com> <1195689773-28601-2-git-send-email-win@wincent.com> <1195689773-28601-3-git-send-email-win@wincent.com> <1195689773-28601-4-git-send-email-win@wincent.com> <20071122090828.GC7153@sigill.intra.peff.net> <825BAB3C-FAB4-4A48-AB94-FAAF5B808CD1@wincent.com> <20071122103339.GA12692@sigill.intra.peff.net> <43664C66-59F9-4B12-B5FD-86011938EC07@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:38:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvANi-0004hK-KG
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbXKVLhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbXKVLhi
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:37:38 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3031 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbXKVLhh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:37:37 -0500
Received: (qmail 22901 invoked by uid 111); 22 Nov 2007 11:37:36 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 06:37:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 06:37:35 -0500
Content-Disposition: inline
In-Reply-To: <43664C66-59F9-4B12-B5FD-86011938EC07@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65805>

On Thu, Nov 22, 2007 at 12:02:17PM +0100, Wincent Colaiuta wrote:

> True, argv will never be NULL. We'll still be doing a zero-byte memcpy 
> though, which I guess is not a big deal here. I'll drop the conditional.

Right. And zero-byte memcpy _is_ allowed by the standard, so it will
already internally have some form of that conditional.

-Peff
