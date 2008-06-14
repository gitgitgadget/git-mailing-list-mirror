From: Jeff King <peff@peff.net>
Subject: Re: [BUG REPORT]
Date: Sat, 14 Jun 2008 19:37:12 -0400
Message-ID: <20080614233712.GA15269@sigill.intra.peff.net>
References: <loom.20080614T065448-251@post.gmane.org> <20080614071011.GA29699@glandium.org> <7vprqkh423.fsf@gitster.siamese.dyndns.org> <7vlk17horn.fsf@gitster.siamese.dyndns.org> <loom.20080614T181822-325@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sven <svoop@delirium.ch>
X-From: git-owner@vger.kernel.org Sun Jun 15 01:38:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7fK1-0002sa-3M
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 01:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632AbYFNXhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 19:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755635AbYFNXhR
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 19:37:17 -0400
Received: from peff.net ([208.65.91.99]:3168 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755627AbYFNXhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 19:37:16 -0400
Received: (qmail 17348 invoked by uid 111); 14 Jun 2008 23:37:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 14 Jun 2008 19:37:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun 2008 19:37:12 -0400
Content-Disposition: inline
In-Reply-To: <loom.20080614T181822-325@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85053>

[the usual convention on this list is to cc all participants]

On Sat, Jun 14, 2008 at 06:26:00PM +0000, Sven wrote:

> >  (1) I do not think it is unreasonable to change update-server-info
> >      to include HEAD in its output.  That would make ls-remote 
> >      output over all protocols consistent;
> 
> As Jeff said, he has already done this and it will roll with the 
> upcoming release.

To clarify:

 - I didn't do it, Daniel did. I just used git-log to find it (the
   commit is be885d96).

 - That change has nothing to do with update-server-info, but rather
   happens entirely on the client side. And it appears to just manually
   add HEAD to the fetch list.

-Peff
