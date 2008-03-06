From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git add -a
Date: Thu, 6 Mar 2008 12:35:58 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803061235060.15786@racer.site>
References: <e29894ca0803060223p6de78b1br1aab956c2c99fc1f@mail.gmail.com>  <200803061146.00500.barra_cuda@katamail.com> <e29894ca0803060257u19c98074t789f87e1f8c120e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-329444853-1204803359=:15786"
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 12:37:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXEOq-00006J-G6
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 12:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbYCFLf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 06:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbYCFLf7
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 06:35:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:56886 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753460AbYCFLf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 06:35:58 -0500
Received: (qmail invoked by alias); 06 Mar 2008 11:35:56 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp025) with SMTP; 06 Mar 2008 12:35:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+b6xwrq86bFwdyvjJTlbvGkAcpUzF+0IStu0sUro
	fkQeAovHAFlEF4
X-X-Sender: gene099@racer.site
In-Reply-To: <e29894ca0803060257u19c98074t789f87e1f8c120e7@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76377>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-329444853-1204803359=:15786
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 6 Mar 2008, Marc-André Lureau wrote:

> Hi,
> 
> On Thu, Mar 6, 2008 at 12:46 PM, Michele Ballabio
> <barra_cuda@katamail.com> wrote:
> >
> >  There's "git add -u". It should do what you want.
> >
> 
> Thanks for this answer :) I wonder why "-u" and not "-a".. After all
> git commit "-a" could be "-s" if we follow that distinction
> (Update/Stage/All).

Probably because some people would expect "git add -a" to do the same as 
"git add .", i.e. add _all_ files (even the untracked ones), as opposed to 
"git add -u", which updates all _tracked_ files.

Hth,
Dscho

--8323584-329444853-1204803359=:15786--
