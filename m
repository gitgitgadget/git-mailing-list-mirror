From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH RFC] new config option remote.<name>.pushexec
Date: Tue, 16 Jan 2007 16:16:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701161614070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070116150259.GA2439@cepheus>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-2036681274-1168960615=:22628"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 16:17:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6q4K-0005Er-Ud
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 16:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbXAPPQ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 10:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbXAPPQ6
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 10:16:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:36440 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751262AbXAPPQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 10:16:57 -0500
Received: (qmail invoked by alias); 16 Jan 2007 15:16:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 16 Jan 2007 16:16:55 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20070116150259.GA2439@cepheus>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36944>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-2036681274-1168960615=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 16 Jan 2007, Uwe Kleine-König wrote:

> git push --exec=... is fine, but having it to specify every time is
> annoying.

What would you specify? The only sensible thing would be "--exec=blabla" 
where "blabla" is a workalike to git-receive-pack.

IMHO this is just an obscure option for obscure _really_ low-level git 
debugging, so it should not even be mentioned in the man page, let alone 
encouraged.

Ciao,
Dscho

---1148973799-2036681274-1168960615=:22628--
