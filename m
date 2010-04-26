From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] wt-status: take advice.statusHints seriously
Date: Mon, 26 Apr 2010 15:10:56 -0400
Message-ID: <20100426191056.GB10772@coredump.intra.peff.net>
References: <c7003ec93f4ea01be80fbba08d2ed5544fa0df4d.1271968072.git.git@drmicha.warpmail.net>
 <7v39yo53mt.fsf@alter.siamese.dyndns.org>
 <86a4d8e5df80008c5c2b3ff4f2a5842ad1f58dc4.1271968072.git.git@drmicha.warpmail.net>
 <q2ibe6fef0d1004222115gcdd8fd81xce8993508bfa9f5d@mail.gmail.com>
 <4BD155D0.5080402@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 26 21:11:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Ti3-0000Mv-U3
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 21:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615Ab0DZTLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 15:11:00 -0400
Received: from peff.net ([208.65.91.99]:39219 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090Ab0DZTK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 15:10:58 -0400
Received: (qmail 13370 invoked by uid 107); 26 Apr 2010 19:11:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Apr 2010 15:11:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Apr 2010 15:10:56 -0400
Content-Disposition: inline
In-Reply-To: <4BD155D0.5080402@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145850>

On Fri, Apr 23, 2010 at 10:09:52AM +0200, Michael J Gruber wrote:

> Tay Ray Chuan venit, vidit, dixit 23.04.2010 06:15:
> > Hi,
> > 
> > On Fri, Apr 23, 2010 at 4:30 AM, Michael J Gruber
> > <git@drmicha.warpmail.net> wrote:
> >>                else if (s->untracked.nr)
> >> -                       printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
> >> +                       printf("nothing added to commit but untracked files present%s\n",
> >> +                               advice_status_hints
> >> +                               ? " (use \"git add\" to track)" : "");
> > 
> > while we're at it, perhaps we could put the hints on its own line,
> 
> I don't think I'm the only one to turn sour at every encounter with the
> phrase "while we're at it". I did fix one extraneous space in code
> "while I was at it", yes, but:

Just my 2 cents, but I find "while we're at it" comments are taken much
better when accompanied by a patch (either squashable or to be applied
on top). :)

-Peff
