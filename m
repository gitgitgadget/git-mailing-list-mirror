From: Jeff King <peff@peff.net>
Subject: Re: [GSOC] Contributing to git.
Date: Fri, 30 Mar 2012 01:26:31 -0400
Message-ID: <20120330052631.GB11648@sigill.intra.peff.net>
References: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 07:26:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDUMO-0004pC-GS
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 07:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346Ab2C3F0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 01:26:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40016
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306Ab2C3F0e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 01:26:34 -0400
Received: (qmail 10981 invoked by uid 107); 30 Mar 2012 05:26:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 01:26:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 01:26:31 -0400
Content-Disposition: inline
In-Reply-To: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194328>

On Fri, Mar 30, 2012 at 08:19:29AM +0530, jaseem abid wrote:

> 	1. Where can I find general instructions on "Contributing to git? "
> more specifically, gitweb?

Documentation/SubmittingPatches in the git.git repository.

> 	2. Where can I find coding standards for git? I am looking for the
> git version of this document.

Documentation/CodingGuidelines

> 	3. Is JavaScript code unit tested? I cant find much docs regarding
> this anywhere.

Jakub can answer this much better than I can, but I suspect the answer
is "no". We hardly have any javascript at all, and I doubt the gitweb
tests cover the javascript bits.

If there is going to be a javascript-heavy SoC project, I think part of
that should probably be adding some automated testing infrastructure.

-Peff
