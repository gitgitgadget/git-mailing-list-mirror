From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Fri, 26 Jul 2013 17:24:38 -0400
Message-ID: <20130726212438.GA1388@sigill.intra.peff.net>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
 <20130726191631.GD29799@sigill.intra.peff.net>
 <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 23:24:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2pVQ-0006KA-Od
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 23:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870Ab3GZVYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 17:24:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:60787 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932810Ab3GZVYk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 17:24:40 -0400
Received: (qmail 9062 invoked by uid 102); 26 Jul 2013 21:24:40 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 16:24:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 17:24:38 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231205>

On Sat, Jul 27, 2013 at 02:47:47AM +0530, Ramkumar Ramachandra wrote:

> >   2. Skip this commit and continue the rest of the cherry-pick sequence.
> 
> Nope, this is unsupported afaik.

Ah. I don't mind improving the message in the meantime, but it sounds
like this is a deficiency in sequenced cherry-pick that needs addressed
eventually.

Your patch is just swapping out "git reset" for "cherry-pick --abort",
so I think that is a good improvement in the meantime.

-Peff
