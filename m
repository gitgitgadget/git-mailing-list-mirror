From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Sun, 18 Jan 2009 18:44:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181843230.3586@pacific.mpi-cbg.de>
References: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com> <alpine.DEB.1.00.0901161513400.3586@pacific.mpi-cbg.de> <636ecac0901160634r586c72a0r9bb63c6f019f5bff@mail.gmail.com> <7vhc3x1874.fsf@gitster.siamese.dyndns.org> <20090118094113.GE11992@leksak.fem-net>
 <20090118153928.GA16664@coredump.intra.peff.net> <alpine.DEB.1.00.0901181711090.3586@pacific.mpi-cbg.de> <20090118170711.GA17055@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Jonas_Flod=E9n?= <jonas@floden.nu>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 18 18:45:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LObiD-0007N5-TF
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 18:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933683AbZARRoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 12:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933670AbZARRoF
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 12:44:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:53898 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932735AbZARRoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 12:44:03 -0500
Received: (qmail invoked by alias); 18 Jan 2009 17:44:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 18 Jan 2009 18:44:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cwNtsv92cSLwnGnf2n8NDXI33W/aYuwiD7dknPv
	Gl3+O9CFS/mdCB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090118170711.GA17055@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106250>

Hi.

On Sun, 18 Jan 2009, Jeff King wrote:

> On Sun, Jan 18, 2009 at 05:17:43PM +0100, Johannes Schindelin wrote:
> 
> > The name "FIRSTLINE" suggests that it is indeed a first line, and 
> > consequently cannot contain a newline.
> 
> It is not "this is a problem because it might contain a newline" but 
> "this is a problem because it might contain an escape sequence, _an 
> example_ of which is a \n newline." So the question is whether you can 
> guarantee that $FIRSTLINE does not contain a backslash. Which I don't 
> think is the case here.

Oh.  Okay, so I was wrong.  But only because dash's echo behaves in a 
strange way: it makes "-e" a noop?

Ciao,
Dscho
