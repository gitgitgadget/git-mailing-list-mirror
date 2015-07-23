From: Jeff King <peff@peff.net>
Subject: Re: Config variables and scripting // was Re: [RFC/PATCH] log: add
 log.firstparent option
Date: Wed, 22 Jul 2015 23:53:11 -0700
Message-ID: <20150723065310.GA7542@peff.net>
References: <20150723012343.GA21000@peff.net>
 <20150723044007.GA3651@gmail.com>
 <20150723051445.GA24029@peff.net>
 <20150723054816.GA1917@peff.net>
 <CA+P7+xrNiK168rXX3SwwmQFPR6i4iA0nhFdfHKL7wqwtwvnEPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 08:53:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIANb-0000AT-Ea
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 08:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbbGWGxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 02:53:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:33952 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750896AbbGWGxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 02:53:15 -0400
Received: (qmail 14551 invoked by uid 102); 23 Jul 2015 06:53:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jul 2015 01:53:14 -0500
Received: (qmail 10281 invoked by uid 107); 23 Jul 2015 06:53:18 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jul 2015 02:53:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jul 2015 23:53:11 -0700
Content-Disposition: inline
In-Reply-To: <CA+P7+xrNiK168rXX3SwwmQFPR6i4iA0nhFdfHKL7wqwtwvnEPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274483>

On Wed, Jul 22, 2015 at 11:32:49PM -0700, Jacob Keller wrote:

> Agreed. Fix the plumbing instead and document how/why to use it
> instead of the porcelain. We might do better to help clearly document
> which commands are porcelain and which are plumbing maybe by
> referencing which plumbings to use in place of various porcelain
> commands. I know, for example, that git status already does this.

"man git" already has such a list (which is generated from the
annotations in command-list.txt). But I agree that it would probably be
helpful to point people directly from "git log" to "git rev-list" and
vice versa.

-Peff
