From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Fri, 16 Jan 2009 15:14:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901161513400.3586@pacific.mpi-cbg.de>
References: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1268579091-1232115259=:3586"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Jonas_Flod=E9n?= <jonas@floden.nu>
X-From: git-owner@vger.kernel.org Fri Jan 16 15:14:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNpTG-0002sG-QV
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 15:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763207AbZAPONZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 09:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760385AbZAPONZ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 09:13:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:57903 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760059AbZAPONY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 09:13:24 -0500
Received: (qmail invoked by alias); 16 Jan 2009 14:13:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 16 Jan 2009 15:13:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BKAojSa/BgIohdSEHXsZUC4Jt/cCW78dmNYgD0f
	kOjbW1ZZQr94tk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105962>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1268579091-1232115259=:3586
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 16 Jan 2009, Jonas Flodén wrote:

>  	then
>  		echo Patch failed at $msgnum.
> +		printf '\nFailed to apply: %s\n' "$FIRSTLINE"
>  		stop_here_user_resolve $this

Maybe

-  		echo Patch failed at $msgnum.
+  		echo Patch failed at $msgnum($FIRSTLINE).

Hmm?

Ciao,
Dscho

--8323328-1268579091-1232115259=:3586--
