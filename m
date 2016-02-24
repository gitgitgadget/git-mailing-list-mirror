From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git config: do not create .git/ if it does not exist yet
Date: Wed, 24 Feb 2016 07:34:44 -0500
Message-ID: <20160224123444.GA27909@sigill.intra.peff.net>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
 <20160224082657.GD12511@sigill.intra.peff.net>
 <20160224101403.GN1766@serenity.lan>
 <20160224103152.GA21448@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602241230120.3152@virtualbox>
 <alpine.DEB.2.20.1602241309560.3152@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Karsten Blees <blees@dcon.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:34:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYYed-0000RG-M7
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 13:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbcBXMet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 07:34:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:48279 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750763AbcBXMet (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 07:34:49 -0500
Received: (qmail 2031 invoked by uid 102); 24 Feb 2016 12:34:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 07:34:48 -0500
Received: (qmail 8240 invoked by uid 107); 24 Feb 2016 12:34:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 07:34:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 07:34:44 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1602241309560.3152@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287203>

On Wed, Feb 24, 2016 at 01:13:39PM +0100, Johannes Schindelin wrote:

> > I created a test and essentially duplicated Peff's finding: this is a
> > Windows-only issue.
> 
> Indeed it is in our patches:
> 
> 	https://github.com/git-for-windows/git/commit/3a4c37b22
> 
> (short version: we carry some patches that simplify locking the config
> file before building on top of it, and somehow we agreed back in the days
> when this patch was written that it would be a good idea if that code
> created leading directories.)

Thanks for tracking it down.

> I will fix this issue in Git for Windows, but I still think that my patch
> brings a usability improvement: the error message is just so much more to
> the point (will submit v2 in a moment).

Yeah, I agree it is still worth doing.

-Peff
