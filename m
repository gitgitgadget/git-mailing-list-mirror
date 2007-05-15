From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] Add a birdview-on-the-source-code section to the user manual
Date: Tue, 15 May 2007 02:24:04 -0400
Message-ID: <20070515062404.GA13316@coredump.intra.peff.net>
References: <20070514181943.GA31749@diana.vm.bytemark.co.uk> <20070514183931.GC23090@fieldses.org> <20070515042200.GA10884@coredump.intra.peff.net> <20070515045044.GB2805@fieldses.org> <20070515050808.GA11745@coredump.intra.peff.net> <1179208673.3714.16.camel@lt21223.campus.dmacc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jeffrey C. Ollie" <jeff@ocjtech.us>
X-From: git-owner@vger.kernel.org Tue May 15 08:24:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnqSC-0002Qy-CF
	for gcvg-git@gmane.org; Tue, 15 May 2007 08:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbXEOGYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 02:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759441AbXEOGYJ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 02:24:09 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2098 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755478AbXEOGYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 02:24:08 -0400
Received: (qmail 25590 invoked from network); 15 May 2007 06:24:06 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 15 May 2007 06:24:06 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 15 May 2007 02:24:04 -0400
Content-Disposition: inline
In-Reply-To: <1179208673.3714.16.camel@lt21223.campus.dmacc.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47318>

On Tue, May 15, 2007 at 12:57:53AM -0500, Jeffrey C. Ollie wrote:

> Exim can advertise the 8BITMIME extension - it's turned off by default:

Yes, although turning it on would just paper over the actual problem,
which is that vger is rewritin the content-type header with the wrong
charset. It would fix the problem for Bruce, but not for other
receivers.

The real problem is (I believe) the lack of the MIME-Version header. I
will do a few test messages momentarily (which will unfortunately
require me spamming the list a bit).

-Peff
