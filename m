From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] show: obey --textconv for blobs
Date: Mon, 22 Apr 2013 11:29:05 -0400
Message-ID: <20130422152905.GA11886@sigill.intra.peff.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
 <5a8c85faddf7f93ca16d284bde415a32dd76779a.1366389739.git.git@drmicha.warpmail.net>
 <20130420040643.GB24970@sigill.intra.peff.net>
 <51729A6D.3030501@drmicha.warpmail.net>
 <20130421033710.GA18890@sigill.intra.peff.net>
 <7vwqrupoy2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 17:29:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUIg6-0004h2-0X
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 17:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268Ab3DVP3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 11:29:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:46219 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711Ab3DVP3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 11:29:08 -0400
Received: (qmail 18913 invoked by uid 102); 22 Apr 2013 15:29:15 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 22 Apr 2013 10:29:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2013 11:29:05 -0400
Content-Disposition: inline
In-Reply-To: <7vwqrupoy2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222027>

On Mon, Apr 22, 2013 at 08:25:41AM -0700, Junio C Hamano wrote:

> True.  Applying textconv to otherwise unreadable blobs is often
> useful, but I agree that it is unexpected if it is done by default,
> especially given that many people have learned to do:
> 
> 	git show HEAD~4:binary-gob >old-binary-gob
> 
> to recover old version of binary contents to a temporary file when
> checking the sanity of or restoring the breakage in the new one.
> 
> It of course does _not_ forbid
> 
> 	git show --textconv HEAD~4:binary-gob | less
> 
> but I doubt it is a good idea to turn it on by default this late in
> the game.

Exactly. I certainly do not mind it as an option, and I am on the fence
regarding it as a default (I think it might have been a sane thing to do
from the start, but at this point the change-of-behavior makes me
hesitate). So I am perfectly willing to go either way, depending on what
others think.

I'm going to be out of email contact the rest of the week, so I'll let
you two talk it out. :)

-Peff
