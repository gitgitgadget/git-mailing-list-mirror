From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Sun, 18 Jan 2009 10:39:29 -0500
Message-ID: <20090118153928.GA16664@coredump.intra.peff.net>
References: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com> <alpine.DEB.1.00.0901161513400.3586@pacific.mpi-cbg.de> <636ecac0901160634r586c72a0r9bb63c6f019f5bff@mail.gmail.com> <7vhc3x1874.fsf@gitster.siamese.dyndns.org> <20090118094113.GE11992@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonas =?utf-8?Q?Flod=C3=A9n?= <jonas@floden.nu>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:41:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZlf-0006bN-KB
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764729AbZARPjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762902AbZARPjb
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:39:31 -0500
Received: from peff.net ([208.65.91.99]:59468 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762659AbZARPjb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:39:31 -0500
Received: (qmail 21351 invoked by uid 107); 18 Jan 2009 15:39:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Jan 2009 10:39:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Jan 2009 10:39:29 -0500
Content-Disposition: inline
In-Reply-To: <20090118094113.GE11992@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106228>

On Sun, Jan 18, 2009 at 10:41:13AM +0100, Stephan Beyer wrote:

> > Looks sane except that I do not think you need printf nor the leading
> > blank line, i.e.
> > 
> > 	echo "Patch failed at $msgnum ($FIRSTLINE)"
> 
> Hmm, IIRC if $FIRSTLINE contains \n or something like that, it will
> interpret this as newline in some shell/echo implementations.
> 
> So printf "...%s..." "$FOO" is always sane for user input.

Yes, I'm surprised Junio doesn't remember the mass conversions we already had
to do (4b7cc26a and 293623ed). But looking at the date, I guess it _has_
been a year and a half. :)

-Peff
