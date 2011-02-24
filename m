From: Jeff King <peff@peff.net>
Subject: Re: [feature request] embed original commit info in cherry-pick
Date: Thu, 24 Feb 2011 14:12:14 -0500
Message-ID: <20110224191214.GC4318@sigill.intra.peff.net>
References: <4D66A3C9.7050001@genband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris Friesen <chris.friesen@genband.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 20:12:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psgbw-0003Ea-8Z
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 20:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258Ab1BXTMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 14:12:16 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:36746 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756243Ab1BXTMP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 14:12:15 -0500
Received: (qmail 26932 invoked by uid 111); 24 Feb 2011 19:12:15 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 19:12:15 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 14:12:14 -0500
Content-Disposition: inline
In-Reply-To: <4D66A3C9.7050001@genband.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167851>

On Thu, Feb 24, 2011 at 12:30:33PM -0600, Chris Friesen wrote:

> 
> If I cherry-pick a  bugfix from a more recent version of a project, it
> would be useful to have an indication somewhere in the commit
> information of where it originally came from.
> 
> That way, if I then upgrade to a newer version of the software it
> becomes obvious that I don't need to worry about porting that commit
> forwards because it's already been handled upstream.
> 
> As it stands, it's not immediately obvious what was cherry-picked vs
> what was developed locally.

Have you tried cherry-pick -x?

-Peff
