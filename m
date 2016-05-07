From: Jeff King <peff@peff.net>
Subject: Re: Portability of git shell scripts?
Date: Fri, 6 May 2016 22:53:20 -0400
Message-ID: <20160507025320.GA31460@sigill.intra.peff.net>
References: <CALR6jEh5dAcnqiyo4kXkj+8imfQQd0nT=baPOW_qbJpJwmFsyw@mail.gmail.com>
 <20160504212028.GG21259@sigill.intra.peff.net>
 <CALR6jEiWQUO0WsOVah2O+9-j2Qx7juYjP7cb1v+P=Ey0oqQszg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Sat May 07 05:00:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aysTk-0002nW-9f
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 05:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758979AbcEGCxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 22:53:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:35571 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758921AbcEGCxY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 22:53:24 -0400
Received: (qmail 13816 invoked by uid 102); 7 May 2016 02:53:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 May 2016 22:53:23 -0400
Received: (qmail 2773 invoked by uid 107); 7 May 2016 02:53:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 May 2016 22:53:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 May 2016 22:53:20 -0400
Content-Disposition: inline
In-Reply-To: <CALR6jEiWQUO0WsOVah2O+9-j2Qx7juYjP7cb1v+P=Ey0oqQszg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293872>

On Fri, May 06, 2016 at 06:57:45PM +0200, Armin Kunaschik wrote:

> > Right. Any modern-ish Bourne shell will do, so moving to bash is one
> > way to fix it.
> 
> My last compile of git 2.2.2 did far better than the current 2.8.2. So
> it looks like there were more recent changes that broke portability.

If you have a working version and a non-working version, the results of
"git bisect" would be very helpful to find the change (or the output of
the test run with "-v -i" to show what's going on in the failing test).

-Peff
