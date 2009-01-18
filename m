From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Sun, 18 Jan 2009 12:07:11 -0500
Message-ID: <20090118170711.GA17055@coredump.intra.peff.net>
References: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com> <alpine.DEB.1.00.0901161513400.3586@pacific.mpi-cbg.de> <636ecac0901160634r586c72a0r9bb63c6f019f5bff@mail.gmail.com> <7vhc3x1874.fsf@gitster.siamese.dyndns.org> <20090118094113.GE11992@leksak.fem-net> <20090118153928.GA16664@coredump.intra.peff.net> <alpine.DEB.1.00.0901181711090.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonas =?utf-8?Q?Flod=C3=A9n?= <jonas@floden.nu>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 18:08:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOb8k-0002VS-CV
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 18:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbZARRHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 12:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759455AbZARRHP
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 12:07:15 -0500
Received: from peff.net ([208.65.91.99]:53287 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbZARRHN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 12:07:13 -0500
Received: (qmail 21895 invoked by uid 107); 18 Jan 2009 17:07:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Jan 2009 12:07:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Jan 2009 12:07:11 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901181711090.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106243>

On Sun, Jan 18, 2009 at 05:17:43PM +0100, Johannes Schindelin wrote:

> > Yes, I'm surprised Junio doesn't remember the mass conversions we 
> > already had to do (4b7cc26a and 293623ed). But looking at the date, I 
> > guess it _has_ been a year and a half. :)
> 
> Hey, be nice to Junio.  Have you seen the amount of mails on this list 
> recently?  I think Junio's the only one really reading all of them; even 
> if you were right, he would be entitled to a nicer reminder.

I didn't mean to be mean. On the contrary, I was surprised because _he_
usually is the one reminding _me_ about such fixes. I guess Junio is
human, after all. :)

> But you are wrong.  And Stephan is wrong, too.
> 
> The name "FIRSTLINE" suggests that it is indeed a first line, and 
> consequently cannot contain a newline.

It is not "this is a problem because it might contain a newline" but "this
is a problem because it might contain an escape sequence, _an example_
of which is a \n newline." So the question is whether you can guarantee
that $FIRSTLINE does not contain a backslash. Which I don't think is the
case here.

-Peff
