From: Jeff King <peff@github.com>
Subject: Re: [RFH] eol=lf on existing mixed line-ending files
Date: Fri, 8 Apr 2011 12:06:16 -0400
Message-ID: <20110408160616.GA32709@sigill.intra.peff.net>
References: <20110407231556.GA10868@sigill.intra.peff.net>
 <4D9ED714.80307@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Mislav Marohnic <mislav@github.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 18:06:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8ECY-0001dc-Op
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 18:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757424Ab1DHQGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 12:06:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47197
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757396Ab1DHQGV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 12:06:21 -0400
Received: (qmail 1028 invoked by uid 107); 8 Apr 2011 16:07:07 -0000
Received: from 205.158.58.41.ptr.us.xo.net (HELO sigill.intra.peff.net) (205.158.58.41)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 12:07:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 12:06:16 -0400
Content-Disposition: inline
In-Reply-To: <4D9ED714.80307@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171133>

On Fri, Apr 08, 2011 at 11:36:20AM +0200, Michael J Gruber wrote:

> > [1] The one thing still puzzling me about the jquery repo is how they
> > managed to make so many commits (including ones to mixed line ending
> > files) without seeing the dirty working tree state and committing it. Is
> > there some combination of config that makes this not happen?
> 
> When did they introduce the .gitattributes file?
> Also, maybe they're jgit users.

The gitattributes file was introduced in 2009, and there are several
commits to mixed line-ending files between then and now. So it seems
unlikely that they just won the race condition over and over.

I don't know whether they could be using jgit.

-Peff
