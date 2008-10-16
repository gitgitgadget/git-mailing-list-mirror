From: Jeff King <peff@peff.net>
Subject: Re: --diff-filter=T does not list x changes
Date: Thu, 16 Oct 2008 06:22:01 -0400
Message-ID: <20081016102201.GB20762@sigill.intra.peff.net>
References: <871vyhbsys.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Thu Oct 16 12:23:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqQ0m-0000QH-PU
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 12:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbYJPKWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 06:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbYJPKWG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 06:22:06 -0400
Received: from peff.net ([208.65.91.99]:3835 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108AbYJPKWF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 06:22:05 -0400
Received: (qmail 6240 invoked by uid 111); 16 Oct 2008 10:22:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 16 Oct 2008 06:22:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2008 06:22:01 -0400
Content-Disposition: inline
In-Reply-To: <871vyhbsys.fsf@cup.kalibalik.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98362>

On Wed, Oct 15, 2008 at 08:42:35PM +0200, Anders Melchiorsen wrote:

> From documentation, I would expect --diff-filter to list changes in
> the execute bit, but it does not. I hear on #git that this is
> intended, though I still do not know how to filter on the execute bit.
> Is it impossible?

Looking at the code, I think it's impossible, and one would have to add
a new --diff-filter letter. However, at the very least, the
documentation should clarify this situation. The --diff-filter
explanation says:

  Select only files [...] have their type (mode) changed (T) [...]

which to me indicates that your test case should work. 

-Peff
