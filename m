From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 3/6] verify-commit: scriptable commit signature
 verification
Date: Fri, 13 Jun 2014 07:50:04 -0400
Message-ID: <20140613115004.GF14066@sigill.intra.peff.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
 <48984553eb1d9ac53dd4b9604af568e22c735109.1402655839.git.git@drmicha.warpmail.net>
 <20140613111945.GC14066@sigill.intra.peff.net>
 <539AE476.4030205@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 13:50:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvPzq-0006aU-B3
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 13:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbaFMLuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 07:50:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:43415 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750817AbaFMLuG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 07:50:06 -0400
Received: (qmail 23473 invoked by uid 102); 13 Jun 2014 11:50:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 06:50:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 07:50:04 -0400
Content-Disposition: inline
In-Reply-To: <539AE476.4030205@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251551>

On Fri, Jun 13, 2014 at 01:45:58PM +0200, Michael J Gruber wrote:

> I sneekily fix this in 6/6... I thought 3/6 is on next already, too late
> for a real v2. Otherwise I would put 6/6 before everything else.

Ah, yeah, I assumed we were still re-rolling (and it looks like you're
just on pu so far).

> About the peeling I'm not so sure, since there's a difference between a
> signed tag pointing to a commit and a signed commit.

There is, but "verify-commit" is always going to verify the commit, no?
Not peeling will always result in an error, and never do anything
useful.

I admit it's probably not going to come up too often, though. And I
don't have any argument beyond "it makes sense to me", so I won't push
for it further.

-Peff
