From: Jeff King <peff@peff.net>
Subject: Re: [BUG REPORT] "git ls-remote http://git.domain.com/repo.git
	HEAD" doesn't work
Date: Sat, 14 Jun 2008 05:19:00 -0400
Message-ID: <20080614091900.GA22538@sigill.intra.peff.net>
References: <loom.20080614T065448-251@post.gmane.org> <20080614071011.GA29699@glandium.org> <7vprqkh423.fsf@gitster.siamese.dyndns.org> <loom.20080614T074854-525@post.gmane.org> <20080614090244.GA1262@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sven <svoop@delirium.ch>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Jun 14 11:20:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7RvV-0006sj-1u
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 11:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbYFNJTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 05:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754684AbYFNJTF
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 05:19:05 -0400
Received: from peff.net ([208.65.91.99]:3064 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754227AbYFNJTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 05:19:03 -0400
Received: (qmail 6934 invoked by uid 111); 14 Jun 2008 09:19:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 14 Jun 2008 05:19:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jun 2008 05:19:00 -0400
Content-Disposition: inline
In-Reply-To: <20080614090244.GA1262@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84996>

On Sat, Jun 14, 2008 at 11:02:44AM +0200, Mike Hommey wrote:

> > How likely is it that ls-remote HEAD is added for HTTP as well rather than
> > stripped for all protocols?
> 
> When someone sends a patch ;)

I'm not sure I can bring myself to wait for that. After all, it could
take nearly negative seven weeks:

  $ git log -1 --pretty=tformat:'%s (%ar)' be885d96
  Make ls-remote http://... list HEAD, like for git://... (7 weeks ago)

-Peff
