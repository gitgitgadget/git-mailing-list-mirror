From: Jeff King <peff@peff.net>
Subject: Re: combined diff does not detect binary files and ignores -diff
 attribute
Date: Mon, 23 May 2011 14:11:47 -0400
Message-ID: <20110523181147.GA26035@sigill.intra.peff.net>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
 <4DDA618E.4030604@drmicha.warpmail.net>
 <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 20:12:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOZbh-0002Xs-FU
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 20:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165Ab1EWSLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 14:11:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51225
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756213Ab1EWSLu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 14:11:50 -0400
Received: (qmail 22159 invoked by uid 107); 23 May 2011 18:13:53 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 14:13:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 14:11:47 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174259>

On Mon, May 23, 2011 at 11:17:14AM -0400, Jay Soffian wrote:

> > We know, but we somehow got stuck, see:
> >
> > http://permalink.gmane.org/gmane.comp.version-control.git/171613
> >
> > I don't have the time to follow up on this currently, it got out of
> > proportion.
> 
> Drat, seems like the perfect being the enemy of the good there. I
> wonder if Junio's patch in that thread isn't good enough for now.

I'll have a patch series in a few minutes that at least handles the
binary case. I'll see how painful the textconv bit is on top of that.

-Peff
