From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Mon, 29 Oct 2012 17:26:43 -0400
Message-ID: <20121029212643.GA20513@sigill.intra.peff.net>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
 <20121029085045.GA5023@sigill.intra.peff.net>
 <CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 22:27:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSwrK-0004Xc-Tm
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 22:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757515Ab2J2V0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 17:26:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43023 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756505Ab2J2V0p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 17:26:45 -0400
Received: (qmail 23614 invoked by uid 107); 29 Oct 2012 21:27:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 17:27:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 17:26:43 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208638>

On Mon, Oct 29, 2012 at 03:56:39PM +0100, Felipe Contreras wrote:

> >> I've ported the tests from hg-git and made sure that the output from remote-hg
> >> matches the output of hg-git. With these extensive tests I would consider this
> >> one ready for wide use. Not only do the tests pass, I've compared the generated
> >> repos of a few projects, and the SHA-1's are exactly the same :)
> >
> > Sounds cool. Unfortunately, the test script hangs for me, after starting
> > up xxdiff (!).
> >
> > pstree reveals that it is "hg" that starts it, but I didn't investigate
> > beyond that.
> 
> Yeah, the test script is not ready for merging, it needs to check for
> python, hg, and hg-git.
> 
> Do you have hg-git installed?

No. But it's important that it fail gracefully; I can't even take it in
pu if I can't run the test suite in a sane way.

I may try to figure it out later myself, but it's not a super high
priority for me.

-Peff
