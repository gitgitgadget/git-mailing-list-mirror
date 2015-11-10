From: Jeff King <peff@peff.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it
 to ignore instead?
Date: Tue, 10 Nov 2015 07:26:26 -0500
Message-ID: <20151110122625.GB14418@sigill.intra.peff.net>
References: <CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
 <20151030001000.GA2123@sigill.intra.peff.net>
 <CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
 <20151030005057.GA23251@sigill.intra.peff.net>
 <CAM-tV-8qSVJFOxLQt9SaYK_WqpxixzPArJnAK=3tHU9inM9Law@mail.gmail.com>
 <20151030210849.GA7149@sigill.intra.peff.net>
 <CAM-tV-9CNO_hqnweFpLaRHx4xEA32CPRdq56y6vYMWqURV9kgg@mail.gmail.com>
 <20151109155342.GB27224@sigill.intra.peff.net>
 <CAM-tV--hBSdCJckCnMtKgkQB2f_3eN8sXHdFWwg2hzb6s7ufxw@mail.gmail.com>
 <20151110122501.GA14418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Noam Postavsky <npostavs@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Nov 10 13:26:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw80P-0006gV-Bp
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 13:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbbKJM03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 07:26:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:55501 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751080AbbKJM02 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 07:26:28 -0500
Received: (qmail 24901 invoked by uid 102); 10 Nov 2015 12:26:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Nov 2015 06:26:28 -0600
Received: (qmail 26317 invoked by uid 107); 10 Nov 2015 12:26:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Nov 2015 07:26:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Nov 2015 07:26:26 -0500
Content-Disposition: inline
In-Reply-To: <20151110122501.GA14418@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281118>

On Tue, Nov 10, 2015 at 07:25:02AM -0500, Jeff King wrote:

> > Introduce new option "credentialCache.ignoreSIGHUP" which stops
> > git-credential-cache--daemon from quitting on SIGHUP.  This is useful
> > when "git push" is started from Emacs, because all child
> > processes (including the daemon) will receive a SIGHUP when "git push"
> > exits.
> > ---
> 
> Can you add a signed-off-by here (see the "sign-off" section in
> Documentation/SubmittingPatches).

To clarify: just telling me it's OK to add your sign-off is fine here. I
can add it (and fix up the style thing) as I apply.

-Peff
