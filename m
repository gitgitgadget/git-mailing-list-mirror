From: Jeff King <peff@peff.net>
Subject: Re: git:// protocol over SSL/TLS
Date: Sat, 28 Dec 2013 04:37:51 -0500
Message-ID: <20131228093751.GD21109@sigill.intra.peff.net>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
 <20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
 <CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
 <87mwjm4c3s.fsf@igel.home>
 <vpqwqiqpe80.fsf@anie.imag.fr>
 <CAErtv25URyB3znN1CMd87374NUjaSFvg=cee_-c=s8bB2j052A@mail.gmail.com>
 <20131227183958.b8e55d7e3c8c38b46137ea9c@domain007.com>
 <CAErtv25uWbsH15yohh+6Jun3eD51dZzvj7udoBf14_EwXzSUPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Git List <git@vger.kernel.org>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 10:38:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwqLH-0003U9-1m
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 10:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086Ab3L1Jhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 04:37:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:51504 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752481Ab3L1Jhx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 04:37:53 -0500
Received: (qmail 1270 invoked by uid 102); 28 Dec 2013 09:37:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Dec 2013 03:37:53 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Dec 2013 04:37:51 -0500
Content-Disposition: inline
In-Reply-To: <CAErtv25uWbsH15yohh+6Jun3eD51dZzvj7udoBf14_EwXzSUPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239765>

On Fri, Dec 27, 2013 at 08:47:54PM +0600, Sergey Sharybin wrote:

> > The web server software has nothing to do with HTTP[S] used by Git being
> > "smart", I think, it just has to be set up properly.
> 
> Misunderstood git doc then which says "it has to be Apache, currently
> - other CGI servers don't work, last I checked".

Do you happen to remember where you saw that claim? If the manual in
git's Documentation/ directory says that, I'd like to fix it.

I added sample lighttpd config to "git help http-backend" a while back.
I tested it at the time, but I do not currently run a lighttpd git
server at all.

-Peff
