From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] expand --pretty=format color options
Date: Sun, 18 Jan 2009 12:37:53 -0500
Message-ID: <20090118173753.GB17434@coredump.intra.peff.net>
References: <20090117153846.GB27071@coredump.intra.peff.net> <49736331.8010003@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 18 18:40:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LObcF-0004eC-DO
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 18:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765577AbZARRh4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 12:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762473AbZARRhz
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 12:37:55 -0500
Received: from peff.net ([208.65.91.99]:43028 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762182AbZARRhz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 12:37:55 -0500
Received: (qmail 22136 invoked by uid 107); 18 Jan 2009 17:37:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Jan 2009 12:37:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Jan 2009 12:37:53 -0500
Content-Disposition: inline
In-Reply-To: <49736331.8010003@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106249>

On Sun, Jan 18, 2009 at 06:13:21PM +0100, Ren=C3=A9 Scharfe wrote:

> Another step would be for --pretty=3Dformat to respect the color conf=
ig,
> i.e. it shouldn't print any colour codes if colouring is turned off o=
r
> if set to auto while writing to file or pipe.

That makes sense to me. In theory, we could offer an "always use this
color" and a "conditionally use this color" substitution. But I don't
really see why anyone would want the "always use this color" one (they
could just say --color, then).

-Peff
