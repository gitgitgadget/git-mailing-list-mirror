From: Jeff King <peff@peff.net>
Subject: Re: strbuf new API, take 2 for inclusion
Date: Thu, 6 Sep 2007 08:58:11 -0400
Message-ID: <20070906125811.GA32400@coredump.intra.peff.net>
References: <20070902224213.GB431@artemis.corp> <11890776114037-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 14:58:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITGwG-0004r7-Ed
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 14:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483AbXIFM6P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 08:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755224AbXIFM6P
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 08:58:15 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2908 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755094AbXIFM6O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 08:58:14 -0400
Received: (qmail 21303 invoked by uid 111); 6 Sep 2007 12:58:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Sep 2007 08:58:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2007 08:58:11 -0400
Content-Disposition: inline
In-Reply-To: <11890776114037-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57875>

On Thu, Sep 06, 2007 at 01:20:04PM +0200, Pierre Habouzit wrote:

>   I've also stripped as many STRBUF_INIT uses as possible, some people
> didn't liked it. I've kept its use for "static" strbufs where it's way
> more convenient that a function call.

The STRBUF_INIT initializer just sets everything to '0' or NULL. Static
objects already have this done automagically by the compiler, so there's
no need to use STRBUF_INIT at all there.

-Peff
