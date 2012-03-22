From: Jeff King <peff@peff.net>
Subject: Re: Push from specific directory.
Date: Thu, 22 Mar 2012 19:27:23 -0400
Message-ID: <20120322232723.GA15676@sigill.intra.peff.net>
References: <BLU0-SMTP471329E4F80CD64A569A4F7B1410@phx.gbl>
 <20120322225747.GB14874@sigill.intra.peff.net>
 <4F6BB425.2010807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Anjib Mulepati <anjibcs@hotmail.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 00:27:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SArPn-0005xE-74
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 00:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760160Ab2CVX10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 19:27:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57047
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289Ab2CVX10 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 19:27:26 -0400
Received: (qmail 7374 invoked by uid 107); 22 Mar 2012 23:27:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 19:27:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 19:27:23 -0400
Content-Disposition: inline
In-Reply-To: <4F6BB425.2010807@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193732>

On Thu, Mar 22, 2012 at 06:22:13PM -0500, Neal Kreitzinger wrote:

> >You have a repository inside a repository. So when you are in (c),
> >you will be pushing the commits from (c), not from (a). I'm not
> >really sure what you are trying to accomplish with that.
> >
> See this thread for the "cons" of nested git repos: (I don't think
> there are any "pros".)
> http://thread.gmane.org/gmane.comp.version-control.git/190372

Nested git repos are OK. I use one inside my git.git checkout to hold
meta-information and scripts (and I know Junio does the same thing). But
I mark the sub-repository as ignored in the parent repository.  What's
insane is trying to track the same set of files from two different
repositories. And I think that is the confusing case in the thread you
mentioned.

-Peff
