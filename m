From: Jeff King <peff@peff.net>
Subject: Re: t0300-credentials: poll failed: invalid argument
Date: Wed, 14 Sep 2011 10:49:32 -0400
Message-ID: <20110914144932.GA12175@sigill.intra.peff.net>
References: <5C993C44-D045-4344-95C1-94D3E6DB0316@silverinsanity.com>
 <20110829174309.GA11524@sigill.intra.peff.net>
 <201109091613.13137.trast@student.ethz.ch>
 <201109141015.58333.trast@student.ethz.ch>
 <C9FED2AA-15CB-4850-B3DA-F4FC12F06EB4@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 16:50:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3qml-0006TJ-RW
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 16:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756738Ab1INOth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 10:49:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42365
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756710Ab1INOtg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 10:49:36 -0400
Received: (qmail 10107 invoked by uid 107); 14 Sep 2011 14:50:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Sep 2011 10:50:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2011 10:49:32 -0400
Content-Disposition: inline
In-Reply-To: <C9FED2AA-15CB-4850-B3DA-F4FC12F06EB4@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181361>

On Wed, Sep 14, 2011 at 10:24:01AM -0400, Brian Gernhardt wrote:

> >>  --- expect-stderr       2011-09-09 14:12:13.000000000 +0000
> >>  +++ stderr      2011-09-09 14:12:13.000000000 +0000
> >>  @@ -1,2 +1,3 @@
> >>   askpass: Username:
> >>   askpass: Password:
> >>  +fatal: poll failed: Invalid argument
> >> 
> >> for each of the tests 15--19.  Is it supposed to be fixed?
> > 
> > Ping?
> 
> Jeff's patch did fix this for me, but it never appears to have made it
> into git.git.  He mentioned something about re-rolling it along with
> some other fixes...  *hint, hint*

Yeah, sorry, I wanted to add some more tests for handling multiple
usernames, and then maybe the helper interface was changing, and then...

There's no reason to hold this up, though. I'll repost it later today.
Promise this time. ;)

-Peff
