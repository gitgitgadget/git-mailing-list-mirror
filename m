From: Jeff King <peff@peff.net>
Subject: Re: Question about git-log --date and default behavior
Date: Mon, 27 Aug 2007 04:27:50 -0400
Message-ID: <20070827082750.GD17373@coredump.intra.peff.net>
References: <m2ejhpc1j0.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Falcon <sfalcon@fhcrc.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 10:27:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPZwx-0002ga-Us
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 10:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbXH0I1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 04:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbXH0I1w
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 04:27:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1542 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbXH0I1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 04:27:52 -0400
Received: (qmail 29216 invoked by uid 111); 27 Aug 2007 08:27:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 27 Aug 2007 04:27:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2007 04:27:50 -0400
Content-Disposition: inline
In-Reply-To: <m2ejhpc1j0.fsf@ziti.fhcrc.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56779>

On Sun, Aug 26, 2007 at 04:35:31PM -0700, Seth Falcon wrote:

> Is there a way have git-log use --date=local as the default for my
> repositories?

I don't think so. It would be nice to have a config option, but that
should almost certainly wait until post-1.5.3.

I think changing the default for 'git-log' should be OK, as it's a
porcelain, but others might disagree.

-Peff
