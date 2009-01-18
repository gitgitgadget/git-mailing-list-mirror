From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Sun, 18 Jan 2009 12:49:41 -0500
Message-ID: <20090118174941.GA22718@coredump.intra.peff.net>
References: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com> <alpine.DEB.1.00.0901161513400.3586@pacific.mpi-cbg.de> <636ecac0901160634r586c72a0r9bb63c6f019f5bff@mail.gmail.com> <7vhc3x1874.fsf@gitster.siamese.dyndns.org> <20090118094113.GE11992@leksak.fem-net> <20090118153928.GA16664@coredump.intra.peff.net> <alpine.DEB.1.00.0901181711090.3586@pacific.mpi-cbg.de> <20090118170711.GA17055@coredump.intra.peff.net> <alpine.DEB.1.00.0901181843230.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonas =?utf-8?Q?Flod=C3=A9n?= <jonas@floden.nu>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 18:51:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LObng-0000X7-6i
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 18:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933966AbZARRto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 12:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764139AbZARRto
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 12:49:44 -0500
Received: from peff.net ([208.65.91.99]:53668 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762996AbZARRtn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 12:49:43 -0500
Received: (qmail 22329 invoked by uid 107); 18 Jan 2009 17:49:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Jan 2009 12:49:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Jan 2009 12:49:41 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901181843230.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106254>

On Sun, Jan 18, 2009 at 06:44:01PM +0100, Johannes Schindelin wrote:

> Oh.  Okay, so I was wrong.  But only because dash's echo behaves in a 
> strange way: it makes "-e" a noop?

Right. "-e" isn't in POSIX at all, and it is a SysV-ism to allow escapes
in any argument (I don't know if "-e" was introduced by GNU people, or
came from elsewhere).

See here for the gory details:

  http://www.opengroup.org/onlinepubs/009695399/utilities/echo.html

-Peff
