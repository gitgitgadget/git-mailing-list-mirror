From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Fri, 16 Dec 2011 14:32:53 -0500
Message-ID: <20111216193253.GD19924@sigill.intra.peff.net>
References: <20111216110000.GA15676@sigill.intra.peff.net>
 <A8E08CC616E248EC8F9000DD86F228E0@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 20:33:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbdWe-0005wQ-JL
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 20:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760606Ab1LPTc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 14:32:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44283
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab1LPTc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 14:32:56 -0500
Received: (qmail 7231 invoked by uid 107); 16 Dec 2011 19:39:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Dec 2011 14:39:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2011 14:32:53 -0500
Content-Disposition: inline
In-Reply-To: <A8E08CC616E248EC8F9000DD86F228E0@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187307>

On Fri, Dec 16, 2011 at 07:26:00PM -0000, Philip Oakley wrote:

> >+ "*.m diff=objc",
> 
> There is a conflict here with the Matlab community which also uses
> "*.m" files for its scripts and code.
> They fit the "It's not that hard to do, but it's an extra step that
> the user might not even know is an option." rationale.
> 
> If the objc.m is used as a default it must be overidable easily, and
> listed in the appropriate documentation to mitigate the "might not
> even know" risk.

It is easily overridable; just put your own "*.m" (or anything that
matches your files) entry into your gitattributes file. I'm more
concerned that people will start getting worse results than with the
default, and not know how to fix it.

If you have some Matlab files, would you mind doing diffs with the
default driver and with the objc driver, and comment on how good or bad
the results are?

-Peff
