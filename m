From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 6 Jun 2013 18:22:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org> <rmivc5rp9w2.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 18:23:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukcxn-0006Js-EX
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 18:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab3FFQWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 12:22:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:60440 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147Ab3FFQWy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 12:22:54 -0400
Received: from mailout-de.gmx.net ([10.1.76.16]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MKfbV-1UmXpz2Wdb-0023S8 for
 <git@vger.kernel.org>; Thu, 06 Jun 2013 18:22:52 +0200
Received: (qmail invoked by alias); 06 Jun 2013 16:22:52 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp016) with SMTP; 06 Jun 2013 18:22:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Jc09U61uJt5z7cz+yQVhMdBYZtMfK0EmCgPJJF/
	3+t/yeeiSc/r6J
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <rmivc5rp9w2.fsf@fnord.ir.bbn.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226511>

Hi Greg,

On Thu, 6 Jun 2013, Greg Troxel wrote:

> As one of the people who helps maintain git packages in pkgsrc, my
> initial reaction is negative to adding a ruby dependency.

My initial reaction, too. It was hard enough to get Perl included with Git
for Windows (because of that pesky Subversion dependency).

As you can see from the commit history, I was the primary force behind
trying to get everything "core" in Git away from requiring scripting
languages (I think it is an awesome thing to provide APIs for as many
languages as possible, but a not-so-cool thing to use more than one
language in the core code). It does not seem that anybody picked up that
task when I left, though.

Ciao,
Johannes
