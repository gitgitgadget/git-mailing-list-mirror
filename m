From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Sun, 18 Jan 2009 10:53:50 +0100
Message-ID: <20090118095350.GF11992@leksak.fem-net>
References: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com> <alpine.DEB.1.00.0901161513400.3586@pacific.mpi-cbg.de> <636ecac0901160634r586c72a0r9bb63c6f019f5bff@mail.gmail.com> <7vhc3x1874.fsf@gitster.siamese.dyndns.org> <20090118094113.GE11992@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas =?iso-8859-1?Q?Flod=E9n?= <jonas@floden.nu>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 10:57:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOUOt-0001ob-9x
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 10:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758350AbZARJyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 04:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757450AbZARJyB
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 04:54:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:37910 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756491AbZARJyA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 04:54:00 -0500
Received: (qmail invoked by alias); 18 Jan 2009 09:53:58 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp005) with SMTP; 18 Jan 2009 10:53:58 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/mqCdpDSLmLNcVN0XspaaGWsz1Sd9t+ySmNAkuFz
	SI1lcpjw3kmuq+
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LOULm-0003fw-CC; Sun, 18 Jan 2009 10:53:50 +0100
Content-Disposition: inline
In-Reply-To: <20090118094113.GE11992@leksak.fem-net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106165>

Stephan Beyer wrote:
> Hmm, IIRC if $FIRSTLINE contains \n or something like that, it will
> interpret this as newline in some shell/echo implementations.

Just in case someone wonders but doesn't dare ask:

bash as expected:
	$ echo 'foo\nbar'
	foo\nbar
	$ echo -e 'foo\nbar'
	foo
	bar

But dash:
	$ echo 'foo\nbar'
	foo
	bar
	$ echo -e 'foo\nbar'
	-e foo
	bar

(According to Debian Popularity Contest[1] "dash" is used in more than
10.000 Debian installations, although it doesn't say if it is used for
/bin/sh.)

 1. http://qa.debian.org/popcon.php?package=dash

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
