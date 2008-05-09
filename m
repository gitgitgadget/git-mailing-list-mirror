From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Added -A option to man page, to match 'git-repack -h'
	output.
Date: Fri, 9 May 2008 00:22:18 -0400
Message-ID: <20080509042218.GB14773@sigill.intra.peff.net>
References: <20080509022451.GA31203@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Fri May 09 06:23:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuK8P-0003Sb-BB
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 06:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbYEIEWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 00:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754495AbYEIEWQ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 00:22:16 -0400
Received: from peff.net ([208.65.91.99]:4769 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687AbYEIEWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 00:22:16 -0400
Received: (qmail 18718 invoked by uid 111); 9 May 2008 04:22:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 09 May 2008 00:22:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 May 2008 00:22:18 -0400
Content-Disposition: inline
In-Reply-To: <20080509022451.GA31203@foursquare.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81598>

On Thu, May 08, 2008 at 10:24:51PM -0400, Chris Frey wrote:

> Simple patch to make documentation match the git-repack help message.

In principle, I think this is a good change; however, if Brandon's
proposal for -A is accepted (see thread 'git gc & deleted branches'),
the documentation should probably mention that unreachables become
loose.

-Peff
