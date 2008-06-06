From: Jeff King <peff@peff.net>
Subject: Re: git-clone still broken wrt. unpacking working tree with http
	transport
Date: Fri, 6 Jun 2008 02:14:28 -0400
Message-ID: <20080606061428.GF18257@sigill.intra.peff.net>
References: <0F5C1FC7-258E-44A4-9FE6-AB6696D0B5BE@rapleaf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@rapleaf.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 08:15:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4VEa-0001jq-9e
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 08:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbYFFGOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 02:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753182AbYFFGOj
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 02:14:39 -0400
Received: from peff.net ([208.65.91.99]:3000 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755082AbYFFGOi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 02:14:38 -0400
Received: (qmail 2180 invoked by uid 111); 6 Jun 2008 06:14:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 06 Jun 2008 02:14:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jun 2008 02:14:28 -0400
Content-Disposition: inline
In-Reply-To: <0F5C1FC7-258E-44A4-9FE6-AB6696D0B5BE@rapleaf.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84029>

On Thu, Jun 05, 2008 at 04:48:56PM -0700, Kevin Ballard wrote:

> The new builtin git-clone is still broken in that it doesn't unpack the 
> working tree if the clone happened over http.

Did you try with a git that contains 541fc218?

-Peff
