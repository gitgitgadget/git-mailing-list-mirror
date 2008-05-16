From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Replace in-place sed in t7502-commit
Date: Fri, 16 May 2008 05:56:07 -0400
Message-ID: <20080516095606.GA25045@sigill.intra.peff.net>
References: <7vwslwgdyi.fsf@gitster.siamese.dyndns.org> <1210897303-80828-1-git-send-email-git-dev@marzelpan.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, sbejar@gmail.com
To: Marcel Koeppen <git-dev@marzelpan.de>
X-From: git-owner@vger.kernel.org Fri May 16 11:57:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwwgP-0001XW-BN
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 11:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbYEPJ4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 05:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbYEPJ4J
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 05:56:09 -0400
Received: from peff.net ([208.65.91.99]:4448 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003AbYEPJ4I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 05:56:08 -0400
Received: (qmail 13090 invoked by uid 111); 16 May 2008 09:56:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 16 May 2008 05:56:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 May 2008 05:56:07 -0400
Content-Disposition: inline
In-Reply-To: <1210897303-80828-1-git-send-email-git-dev@marzelpan.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82262>

On Fri, May 16, 2008 at 02:21:43AM +0200, Marcel Koeppen wrote:

> The in-place mode of sed used in t7502-commit is a non-POSIX extension.
> That call of sed is replaced by a more portable version using a
> temporary file.

Thanks, this fixes a similar issue on FreeBSD (which is probably the
same sed).

-Peff
