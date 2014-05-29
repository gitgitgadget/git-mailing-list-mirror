From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sideband.c: Get rid of ANSI sequences for non-terminal
 shell
Date: Thu, 29 May 2014 13:45:16 -0400
Message-ID: <20140529174516.GA10865@sigill.intra.peff.net>
References: <81E85F13A4BE084BAF4B1AA24173EDA012924D8B@JWPKEXMBX03.corp.checkfree.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"j6t@kdbg.org" <j6t@kdbg.org>, "nico@cam.org" <nico@cam.org>,
	"junkio@cox.net" <junkio@cox.net>,
	"kusmabite@gmail.com" <kusmabite@gmail.com>,
	"mnaoumov@gmail.com" <mnaoumov@gmail.com>
To: "Naumov, Michael (North Sydney)" <Michael.Naumov@Fiserv.com>
X-From: git-owner@vger.kernel.org Thu May 29 19:45:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq4OP-0005v3-4b
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 19:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934378AbaE2RpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 13:45:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:33571 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932984AbaE2RpT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 13:45:19 -0400
Received: (qmail 9734 invoked by uid 102); 29 May 2014 17:45:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 12:45:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 13:45:16 -0400
Content-Disposition: inline
In-Reply-To: <81E85F13A4BE084BAF4B1AA24173EDA012924D8B@JWPKEXMBX03.corp.checkfree.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250395>

On Wed, May 28, 2014 at 03:12:15AM +0000, Naumov, Michael (North Sydney) wrote:

> Some git tools such as GitExtensions for Windows use environment
> variable TERM=msys which causes the weird ANSI sequence shown for the
> messages returned from server-side hooks
> We add those ANSI sequences to help format sideband data on the user's
> terminal. However, GitExtensions is not using a terminal, and the ANSI
> sequences just confuses it. We can recognize this use by checking
> isatty().
> See https://github.com/gitextensions/gitextensions/issues/1313 for
> more details

Please wrap your commit messages (and emails) at something reasonable to
fit on an 80-char terminal with indentation (I usually use 60, but
anything <= 72 is probably fine).

Other than that, I think the patch looks fine.

> P.S. I gave up trying to send this letter from gmail, it eats my tab character
> P.S 2. Sorry, my tab character has been eaten again!

This version looks OK to me (and applies via git-am).

-Peff
