From: Jeff King <peff@peff.net>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Mon, 31 Aug 2009 15:08:27 -0400
Message-ID: <20090831190827.GA4876@sigill.intra.peff.net>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net>
 <vpqskf8z0rj.fsf@bauges.imag.fr>
 <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com>
 <20090831164146.GA23245@coredump.intra.peff.net>
 <fabb9a1e0908311012q4cea2d51i2c2f0cbceac0cab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:08:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiCF2-0005dn-Uy
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 21:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbZHaTI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 15:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbZHaTI2
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 15:08:28 -0400
Received: from peff.net ([208.65.91.99]:58272 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866AbZHaTI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 15:08:27 -0400
Received: (qmail 26272 invoked by uid 107); 31 Aug 2009 19:08:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 31 Aug 2009 15:08:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2009 15:08:27 -0400
Content-Disposition: inline
In-Reply-To: <fabb9a1e0908311012q4cea2d51i2c2f0cbceac0cab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127492>

On Mon, Aug 31, 2009 at 07:12:44PM +0200, Sverre Rabbelier wrote:

> On Mon, Aug 31, 2009 at 18:41, Jeff King<peff@peff.net> wrote:
> > IIRC, the message you are seeing comes when the _server_ is an older
> > version of git. It is harmless, though.
> 
> Mhhhh, is it some weird interaction between 'empty repository' patch
> and old server versions, or did this happen too before my patch was
> applied?

I think the former. I thought it was discussed before, but the only
reference I can find is this (see the end of the email):

  http://article.gmane.org/gmane.comp.version-control.git/107626

and I don't see any followup for that specific part of the mail.

-Peff
