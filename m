From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0302: "unreadable" test needs SANITY prereq
Date: Fri, 12 Jun 2015 09:36:52 -0400
Message-ID: <20150612133652.GA2446@peff.net>
References: <1434115798-8250-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jean-Yves LENHOF <jean-yves@lenhof.eu.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 15:37:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3P8m-0006re-U5
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 15:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbbFLNg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 09:36:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:45245 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752818AbbFLNg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 09:36:56 -0400
Received: (qmail 22574 invoked by uid 102); 12 Jun 2015 13:36:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 08:36:55 -0500
Received: (qmail 15049 invoked by uid 107); 12 Jun 2015 13:36:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 09:36:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jun 2015 09:36:52 -0400
Content-Disposition: inline
In-Reply-To: <1434115798-8250-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271489>

On Fri, Jun 12, 2015 at 09:29:58PM +0800, Paul Tan wrote:

> The test expects that "chmod -r ~/.git-credentials" would make it
> unreadable to the user, and thus needs the SANITY prerequisite.

Yup, looks obviously correct to me. Thanks for a quick turnaround.

-Peff
