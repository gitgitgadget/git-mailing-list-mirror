From: Jeff King <peff@peff.net>
Subject: Re: [TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 12:38:10 -0400
Message-ID: <20080624163810.GA4654@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0806241515460.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 24 18:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBBXz-0005JL-JF
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 18:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbYFXQiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 12:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbYFXQiN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 12:38:13 -0400
Received: from peff.net ([208.65.91.99]:3375 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbYFXQiM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 12:38:12 -0400
Received: (qmail 4550 invoked by uid 111); 24 Jun 2008 16:38:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 12:38:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2008 12:38:10 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806241515460.9925@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86082>

On Tue, Jun 24, 2008 at 03:17:18PM +0100, Johannes Schindelin wrote:

> When you look for a fix instead of a regression, it can be quite hard
> to twist your brain into choosing the correct bisect command between
> 'git bisect bad' and 'git bisect good'.
> 
> So introduce the commands 'git bisect fixed' and 'git bisect unfixed'.

Thanks. This just bit me the other day, and I thought of the same
solution. I think it might be worth a "non-toy" patch.

-Peff
