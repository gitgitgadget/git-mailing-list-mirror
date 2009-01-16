From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Fri, 16 Jan 2009 17:27:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901161726440.3586@pacific.mpi-cbg.de>
References: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com>  <alpine.DEB.1.00.0901161513400.3586@pacific.mpi-cbg.de> <636ecac0901160634r586c72a0r9bb63c6f019f5bff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-456516095-1232123221=:3586"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Jonas_Flod=E9n?= <jonas@floden.nu>
X-From: git-owner@vger.kernel.org Fri Jan 16 17:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNrXg-0002E1-De
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 17:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759758AbZAPQ0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 11:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758993AbZAPQ0K
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 11:26:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:55910 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758094AbZAPQ0J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 11:26:09 -0500
Received: (qmail invoked by alias); 16 Jan 2009 16:26:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 16 Jan 2009 17:26:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gBz89q8Rgx5DNdjZrH298NUC3frCeULA6Pw5J0Z
	wOtIxstKVslW1T
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <636ecac0901160634r586c72a0r9bb63c6f019f5bff@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105972>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-456516095-1232123221=:3586
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 16 Jan 2009, Jonas Flodén wrote:

> Johannes Schindelin wrote:
> > Maybe
> >
> > -               echo Patch failed at $msgnum.
> > +               echo Patch failed at $msgnum($FIRSTLINE).
> 
> How about this instead. Though the line could get very long.
> This makes the line stand out a little more.

Fine by me!

Ciao,
Dscho
--8323328-456516095-1232123221=:3586--
