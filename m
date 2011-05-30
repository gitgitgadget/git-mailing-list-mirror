From: Jeff King <peff@peff.net>
Subject: Re: Git global usage and tests
Date: Mon, 30 May 2011 12:12:30 -0400
Message-ID: <20110530161230.GA25291@sigill.intra.peff.net>
References: <754E784F-51C6-4B8D-B15D-3FF8B7AF1321@gmail.com>
 <20110530153620.GA24431@sigill.intra.peff.net>
 <B369AA28-DEF2-48F3-8E4E-F387E8A57D26@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Romain Geissler <romain.geissler@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 18:12:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR554-0004WH-LI
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 18:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450Ab1E3QMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 12:12:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52878
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757156Ab1E3QMc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 12:12:32 -0400
Received: (qmail 17044 invoked by uid 107); 30 May 2011 16:12:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 May 2011 12:12:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 May 2011 12:12:30 -0400
Content-Disposition: inline
In-Reply-To: <B369AA28-DEF2-48F3-8E4E-F387E8A57D26@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174760>

On Mon, May 30, 2011 at 06:10:20PM +0200, Romain Geissler wrote:

> > Have you considered pulling the parse-options parser from git into
> > libgit2? It's one of the more modularized and lib-ified bits of code in
> > git already.
> 
> Yes and No. We have already copied some code from git : parse-option,
> the error handling functions, a part of the run-command block and a
> part of the compatibility layer. To my mind, there is no reason to
> pull it into libgit2 as it's only a client feature that works on
> strings, and libgit2 does not aim at being a client, only a git
> library.

Yeah, good point. Definitely it should not be part of the libgit2
library itself.

-Peff
