From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase -i: remove undocumented '--verify' flag
Date: Tue, 23 Nov 2010 09:41:33 -0500
Message-ID: <20101123144133.GA3145@sigill.intra.peff.net>
References: <1290408504-14639-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <vpqoc9hsemy.fsf@bauges.imag.fr>
 <201011221414.15982.trast@student.ethz.ch>
 <vpq8w0lqyf7.fsf@bauges.imag.fr>
 <alpine.DEB.1.10.1011222103290.17721@debian>
 <CA8E4FB8-70F7-415C-85DE-746B1113AE4C@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Nov 23 15:41:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKu42-0004U7-6w
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 15:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019Ab0KWOll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 09:41:41 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33198 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318Ab0KWOlk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 09:41:40 -0500
Received: (qmail 28220 invoked by uid 111); 23 Nov 2010 14:41:35 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 23 Nov 2010 14:41:35 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Nov 2010 09:41:33 -0500
Content-Disposition: inline
In-Reply-To: <CA8E4FB8-70F7-415C-85DE-746B1113AE4C@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161967>

On Mon, Nov 22, 2010 at 06:24:10PM -0800, Kevin Ballard wrote:

> On Nov 22, 2010, at 12:21 PM, Martin von Zweigbergk wrote:
> 
> > (I hope this is the correct way of including a patch. I have only used
> > 'git send-email before'. I noticed that Jeff seems to remove the first
> > three lines and put a '-- 8> --' before, but others do not. What does
> > the mysterious header mean?)
> 
> It's actually 8< or >8, and it's a little ASCII icon of a pair of scissors.
> If a line consists mainly of dashes and scissors then `git am --scissors`
> can split the mail on that line and treat the rest of the body after that
> line as a patch.

Yep. I don't know if Junio actually uses --scissors these days. Before
it existed, he would just snip the parts above the marker manually,
which was not a big deal because he reads his mail in emacs. If that is
still the case, then it doesn't really matter what the marker is, as
long as he recognizes it, and it is not "---", which is the special
marker for splitting commit message from cover letter.

That being said, people other than Junio may apply your patch, so if you
are going to use such a marker, making it look scissor-like is probably
the best thing to do.

-Peff
