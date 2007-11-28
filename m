From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] cvsimport: use show-ref to support packed refs
Date: Wed, 28 Nov 2007 20:37:48 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711282037100.27959@racer.site>
References: <20071128185504.GA11236@coredump.intra.peff.net>
 <20071128185611.GB11320@coredump.intra.peff.net> <Pine.LNX.4.64.0711281916140.27959@racer.site>
 <20071128194423.GB11396@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:38:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxTfo-0000FX-Ct
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 21:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269AbXK1Uh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 15:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755699AbXK1Uh6
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 15:37:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:54192 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753385AbXK1Uh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 15:37:58 -0500
Received: (qmail invoked by alias); 28 Nov 2007 20:37:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 28 Nov 2007 21:37:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RrKIt09ARlKVE3y47ZWqxs+AGpYQSgIwLN5Z7aZ
	8Hm7m4RLTZVOW+
X-X-Sender: gene099@racer.site
In-Reply-To: <20071128194423.GB11396@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66423>

Hi,

On Wed, 28 Nov 2007, Jeff King wrote:

> Since get_headref is useful in contexts where "$remote" is not always
> prepended (see patch 3/3), I think the best solution is:
>
> [PATCH prefixing the argument to get_headref() with "$remote/"]

Yes, I think so, too.

Thanks,
Dscho
