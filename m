From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 26/27] t/*svn*: fix moderate &&-chain breakage
Date: Fri, 20 Mar 2015 16:13:21 -0400
Message-ID: <20150320201321.GA21945@peff.net>
References: <550C2E7B.3030203@drmicha.warpmail.net>
 <317e6b1e70f3e1c50d62207c53f4d038ad027c9d.1426861743.git.git@drmicha.warpmail.net>
 <xmqqy4mree9x.fsf@gitster.dls.corp.google.com>
 <xmqqh9tfea1v.fsf@gitster.dls.corp.google.com>
 <20150320200239.GA25506@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 21:13:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ3IP-0000K9-Fg
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 21:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbbCTUN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 16:13:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:36154 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751797AbbCTUNY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 16:13:24 -0400
Received: (qmail 1176 invoked by uid 102); 20 Mar 2015 20:13:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 15:13:23 -0500
Received: (qmail 28200 invoked by uid 107); 20 Mar 2015 20:13:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 16:13:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 16:13:21 -0400
Content-Disposition: inline
In-Reply-To: <20150320200239.GA25506@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265962>

On Fri, Mar 20, 2015 at 04:02:39PM -0400, Jeff King wrote:

> Yeah, that was my impression, too. I don't have svn installed on my
> system, so I missed those ones. I don't have CVS either. That might be
> worth following up on.

Hmm, that turned out rather easy. No breakages at all in the cvs tests.
It almost makes me think I ran the tests wrong. ;)

-Peff
