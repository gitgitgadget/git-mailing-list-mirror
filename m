From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git-log prints wrong unixtime with --date=format:%s
Date: Wed, 18 May 2016 21:54:55 -0400
Message-ID: <20160519015455.GB24225@sigill.intra.peff.net>
References: <87vb2d37ea.fsf@web.de>
 <8760ucoaus.fsf@web.de>
 <20160518004008.GA20007@sigill.intra.peff.net>
 <20160518005824.GA7120@sigill.intra.peff.net>
 <xmqqvb2bs5f5.fsf@gitster.mtv.corp.google.com>
 <20160518174919.GA5796@sigill.intra.peff.net>
 <87r3cz55mv.fsf@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Heerdegen <michael_heerdegen@web.de>
X-From: git-owner@vger.kernel.org Thu May 19 03:55:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3DB0-00056y-Op
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 03:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbcESBy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 21:54:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:41637 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752643AbcESBy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 21:54:58 -0400
Received: (qmail 10560 invoked by uid 102); 19 May 2016 01:54:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 21:54:58 -0400
Received: (qmail 28624 invoked by uid 107); 19 May 2016 01:54:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 21:54:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 21:54:55 -0400
Content-Disposition: inline
In-Reply-To: <87r3cz55mv.fsf@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295039>

On Thu, May 19, 2016 at 01:05:28AM +0200, Michael Heerdegen wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   3. The epoch times for the latter lines should match.
> 
> FWIW, I think the epoch time is the most practical way to transfer the
> time of a commit into a different program.  When this program wants to
> do it's own date arithmetic with it, unix time is just nice (no time
> format parsing needed).
> 
> That's why it would be good if the unix time values could be relied on.

Oh, I agree that unix times are handy. I just think that "use %at in the
pretty-format, instead of %ad and then %s in the date-format" is not
such a bad workaround.

> Conclusion: in addition to 3., I wished both epoch times were also
> correct per se.

The %at one should be correct, no? If it's not, that's a separate bug.

-Peff
