From: Jeff King <peff@peff.net>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 21:57:08 -0400
Message-ID: <20071031015708.GA24403@coredump.intra.peff.net>
References: <20071030053732.GA16963@hermes.priv> <fg8h9l$b4n$1@ger.gmane.org> <20071031013856.GA23274@coredump.intra.peff.net> <200710310249.17233.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In2qE-0003BF-B4
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 02:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbXJaB5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 21:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbXJaB5L
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 21:57:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2202 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbXJaB5L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 21:57:11 -0400
Received: (qmail 6635 invoked by uid 111); 31 Oct 2007 01:57:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Oct 2007 21:57:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2007 21:57:08 -0400
Content-Disposition: inline
In-Reply-To: <200710310249.17233.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62777>

On Wed, Oct 31, 2007 at 02:49:16AM +0100, Jakub Narebski wrote:

> > ...which is a quoting mechanism, and it's not even one commonly used in
> > emails (i.e., people have written "parse a URL from this text" scripts
> > for RFC-encoded URLs, but _not_ for shell quoting).
> 
> I don't think RFC-encoding is quoting mechanism used in emails, either.

That's funny, because I have hundreds of mails where that is the case,
and none where people used shell-quoting.  Most URLs don't _need_ any
encoding, so we don't notice either way. But are you honestly telling me
that if you needed to communicate a URL with a space via email, you
would write:

  'http://foo.tld/url with a space'

rather than:

  http://foo.tld/url+with+a+space

?

I think the latter is much more common, if only because of the fact that
copy and paste from most browsers' location bars gives the encoded
version.

-Peff
