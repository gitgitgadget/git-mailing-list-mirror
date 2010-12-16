From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] completion: add missing configuration variables
Date: Thu, 16 Dec 2010 09:28:16 -0500
Message-ID: <20101216142816.GB9945@sigill.intra.peff.net>
References: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20101215130046.GB25647@sigill.intra.peff.net>
 <alpine.DEB.1.10.1012151931030.25560@debian>
 <20101216124235.GA32636@neumann>
 <alpine.DEB.1.10.1012160810440.25560@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 15:28:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTEoj-000682-9f
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 15:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194Ab0LPO2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 09:28:20 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40770 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756088Ab0LPO2T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 09:28:19 -0500
Received: (qmail 31316 invoked by uid 111); 16 Dec 2010 14:28:18 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 16 Dec 2010 14:28:18 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Dec 2010 09:28:16 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1012160810440.25560@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163808>

On Thu, Dec 16, 2010 at 08:14:54AM +0100, Martin von Zweigbergk wrote:

> > On Wed, Dec 15, 2010 at 08:44:45PM +0100, Martin von Zweigbergk wrote:
> > > On Wed, 15 Dec 2010, Jeff King wrote:
> > > > As an aside, I would think "--unset" should actually choose from the set
> > > > of configured variables for completion (i.e., "git config --list | cut
> > > > -d= -f1"). But that would obviously be a separate patch.
> > > 
> > > Good point. I'll put it on my todo.
> > 
> > It already works that way since 0065236 (bash completion: complete
> > variable names for "git config" with options, 2009-05-08).
> 
> Nice. Thanks. Removed from my todo :-). Then I don't see any reason at
> all to keep color.grep.external and add.ignore-errors.

Agreed. Thanks.

-Peff
