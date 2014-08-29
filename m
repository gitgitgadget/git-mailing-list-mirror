From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] fsck: check tag objects' headers
Date: Fri, 29 Aug 2014 19:43:27 -0400
Message-ID: <20140829234327.GF24834@peff.net>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
 <alpine.DEB.1.00.1408281646530.990@s15462909.onlinehome-server.info>
 <xmqqlhq88fyb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 01:43:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNVpN-0001ft-Kt
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 01:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbaH2Xna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 19:43:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:33498 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbaH2Xn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 19:43:29 -0400
Received: (qmail 13382 invoked by uid 102); 29 Aug 2014 23:43:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 18:43:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 19:43:27 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhq88fyb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256204>

On Thu, Aug 28, 2014 at 02:25:16PM -0700, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > We inspect commit objects pretty much in detail in git-fsck, but we just
> > glanced over the tag objects. Let's be stricter.
> >
> > This work was sponsored by GitHub Inc.
> 
> Is it only this commit, or all of these patches in the series?
> Does GitHub want their name sprinkled over all changes they sponsor?

GitHub does not really care either way. I think it is well-known that we
sponsor some git development (i.e., pretty much everything I and Michael
work on), and we do not need that fact sprinkled in the commit history.

But we are also happy for that fact to be transparent if it changes
people's opinions on whether the patch is a good idea (i.e., to know
that Johannes has some motive beyond just "I think this is the right
thing to do"; I hope he _also_ thinks it is the right thing to do or
would not post the series, of course).

Personally, I think the cover letter is a good place for such things.

-Peff
