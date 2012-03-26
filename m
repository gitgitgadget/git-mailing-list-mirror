From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] push: Provide situational hints for non-fast-forward
 errors
Date: Mon, 26 Mar 2012 16:11:22 -0400
Message-ID: <20120326201122.GA24138@sigill.intra.peff.net>
References: <20120320043133.GA2755@gmail.com>
 <20120323214114.GB18198@sigill.intra.peff.net>
 <20120326192001.GB32387@gmail.com>
 <20120326195150.GA13098@sigill.intra.peff.net>
 <7vk427nn4v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christopher Tiwald <christiwald@gmail.com>, git@vger.kernel.org,
	zbyszek@in.waw.pl, Matthieu.Moy@grenoble-inp.fr, drizzd@aon.at
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 22:11:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCGGL-0003N9-8v
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 22:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635Ab2CZULZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 16:11:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60178
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090Ab2CZULY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 16:11:24 -0400
Received: (qmail 17052 invoked by uid 107); 26 Mar 2012 20:11:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 16:11:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 16:11:22 -0400
Content-Disposition: inline
In-Reply-To: <7vk427nn4v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193972>

On Mon, Mar 26, 2012 at 01:05:52PM -0700, Junio C Hamano wrote:

> > Your patch is already in 'next', so we will have to build on top rather
> > than squashing. So here it is with an actual commit message:
> 
> If the patch were already in 'next', we would have to build on top, but I
> thought I kept it out of 'next' because I knew this deserved a bit more
> review time.  Perhaps I screwed up, or you are reading the history
> incorrectly?
> 
> 	... goes and looks ...

Oops, you're right. I don't know why I thought it was, and obviously I
should check before speaking next time. :)

> I'm however tempted to keep this follow-up patch as separate without
> squashing.

Either way is fine with me.

BTW, I was on a semi-vacation when Christopher posted the patch, so I
missed out on most of the timely review. But I really like how it ended
up; it's exactly what I was hoping for when we discussed this a month or
two ago. So thanks for working on it, Christopher.

-Peff
