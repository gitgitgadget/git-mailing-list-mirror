From: Jeff King <peff@peff.net>
Subject: Re: strbuf new API, take 2 for inclusion
Date: Thu, 6 Sep 2007 13:16:21 -0400
Message-ID: <20070906171621.GA5305@coredump.intra.peff.net>
References: <20070902224213.GB431@artemis.corp> <11890776114037-git-send-email-madcoder@debian.org> <20070906125811.GA32400@coredump.intra.peff.net> <20070906171502.GF8451@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 19:16:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKxv-00016j-Qz
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 19:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbXIFRQX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 13:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbXIFRQX
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 13:16:23 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4998 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbXIFRQW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 13:16:22 -0400
Received: (qmail 23622 invoked by uid 111); 6 Sep 2007 17:16:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Sep 2007 13:16:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2007 13:16:21 -0400
Content-Disposition: inline
In-Reply-To: <20070906171502.GF8451@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57911>

On Thu, Sep 06, 2007 at 07:15:02PM +0200, Pierre Habouzit wrote:

>   Yes, Junio already did that remark. The reason is that it's forward
> compatible: if we ever change strbuf's intitial value for some reason,
> we would just have to rebuild the code. As junio disliked it (and I'm
> not sure I love it either) I've used it where using the _init() function
> was impractical.

OK, I missed that discussion. Thanks for the explanation.

-Peff
