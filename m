From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] remote-curl: let users turn off smart http
Date: Thu, 20 Sep 2012 14:12:31 -0400
Message-ID: <20120920181231.GA19204@sigill.intra.peff.net>
References: <20120920165938.GB18655@sigill.intra.peff.net>
 <20120920170517.GB18981@sigill.intra.peff.net>
 <7va9wkbmyc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 20:12:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TElEw-0005JO-Op
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 20:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab2ITSMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 14:12:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51665 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333Ab2ITSMd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 14:12:33 -0400
Received: (qmail 18355 invoked by uid 107); 20 Sep 2012 18:12:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Sep 2012 14:12:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2012 14:12:31 -0400
Content-Disposition: inline
In-Reply-To: <7va9wkbmyc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206066>

On Thu, Sep 20, 2012 at 10:53:15AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I added the config item as remote.foo.smarthttp. You could also allow
> > "http.$url.smart" (and just "http.smart", for that matter), which could
> > be more flexible if you have multiple remotes pointing to the same
> > broken server.
> 
> What would the user experience be when we introduce "even smarter"
> http server protocol extension?  Will we add remote.foo.starterhttp?

I would hope that it would actually be negotiated reliably at the
protocol level so we do not have to deal with this mess again.

> Perhaps
> 
>     remote.$name.httpvariants = [smart] [dumb]
> 
> to allow users to say "smart only", "dumb only", or "smart and/or
> dumb" might be more code but less burden on the users.

I don't mind that format if we are going that direction, but is there
anybody who actually wants to say "smart only?"

-Peff
