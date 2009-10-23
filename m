From: Jeff King <peff@peff.net>
Subject: Re: confusion with git diff-tree output
Date: Thu, 22 Oct 2009 20:54:26 -0400
Message-ID: <20091023005426.GA2431@sigill.intra.peff.net>
References: <117f2cc80910211043q3a92a7b6o15464cc049ee33dc@mail.gmail.com>
 <20091021195103.01cef9c4@perceptron>
 <117f2cc80910211523m5c1399aej594398fb6597e5de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Roundy <roundyd@physics.oregonstate.edu>
X-From: git-owner@vger.kernel.org Fri Oct 23 02:54:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N18QZ-0004cm-H0
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 02:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbZJWAy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 20:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbZJWAy0
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 20:54:26 -0400
Received: from peff.net ([208.65.91.99]:46611 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbZJWAy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 20:54:26 -0400
Received: (qmail 29065 invoked by uid 107); 23 Oct 2009 00:58:06 -0000
Received: from 106.sub-70-193-249.myvzw.com (HELO sigill.intra.peff.net) (70.193.249.106)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 22 Oct 2009 20:58:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Oct 2009 20:54:26 -0400
Content-Disposition: inline
In-Reply-To: <117f2cc80910211523m5c1399aej594398fb6597e5de@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131080>

On Wed, Oct 21, 2009 at 06:23:08PM -0400, David Roundy wrote:

> You're right.  I figured I must be overlooking something obvious, and
> that was it.  What surprised me was that -p implies -r, which is not
> documented.  Since the -p output was recursive, I incorrectly presumed
> that this was the default.

It's due to hysterical raisins:

  http://article.gmane.org/gmane.comp.version-control.git/54078

-Peff
