From: Jeff King <peff@peff.net>
Subject: Re: Question about git-log --date and default behavior
Date: Mon, 27 Aug 2007 04:45:44 -0400
Message-ID: <20070827084544.GA19358@coredump.intra.peff.net>
References: <m2ejhpc1j0.fsf@ziti.fhcrc.org> <20070827082750.GD17373@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Falcon <sfalcon@fhcrc.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 10:45:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPaEK-0001Eq-1m
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 10:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbXH0Ips (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 04:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbXH0Ipr
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 04:45:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4970 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbXH0Ipq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 04:45:46 -0400
Received: (qmail 29509 invoked by uid 111); 27 Aug 2007 08:45:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 27 Aug 2007 04:45:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2007 04:45:44 -0400
Content-Disposition: inline
In-Reply-To: <20070827082750.GD17373@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56785>

On Mon, Aug 27, 2007 at 04:27:50AM -0400, Jeff King wrote:

> I think changing the default for 'git-log' should be OK, as it's a
> porcelain, but others might disagree.

As Johannes pointed out, at least gitk is using 'git-log' behind the
scenes, so this is probably not a good idea. It seems like a bit of a
conflict, though, since git-log is supposed to be porcelain (I thought).

-Peff
