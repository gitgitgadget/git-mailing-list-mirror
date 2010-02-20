From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/4] utf8.c: strbuf'ify strbuf_add_wrapped_text()
Date: Sat, 20 Feb 2010 10:03:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002201001290.20986@pacific.mpi-cbg.de>
References: <4B7F0D08.6040608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-379316882-1266656615=:20986"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Feb 20 09:56:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nil8x-0007OT-6E
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 09:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab0BTI4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 03:56:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:43884 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752719Ab0BTI4t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 03:56:49 -0500
Received: (qmail invoked by alias); 20 Feb 2010 08:56:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 20 Feb 2010 09:56:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+h+MolOv2hQIk3ufuOUEHVsGsArTyQZ0ptMVQv9o
	KML1Gy50LbdzbX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B7F0D08.6040608@lsrfire.ath.cx>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.69999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140520>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-379316882-1266656615=:20986
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 19 Feb 2010, René Scharfe wrote:

> The strbuf parameter of strbuf_add_wrapped_text() in utf8.c is
> optional; if it's missing, results are directly written to stdout.

The reasoning for it is my private 'git-fmt' program, which can reformat 
really large text files that I did not want to be read in fully, 
converted, and written out fully.

But as I am the only user of this feature, it makes sense to simplify the 
code.

Ciao,
Dscho

--8323328-379316882-1266656615=:20986--
