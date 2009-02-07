From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git-sh-setup: Use "cd" option, not /bin/pwd, for
 symlinked work tree
Date: Sat, 7 Feb 2009 13:25:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902071324230.10279@pacific.mpi-cbg.de>
References: <7viqq1hghw.fsf@gitster.siamese.dyndns.org> <1233977068-24861-1-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	ae@op5.se, j.sixt@viscovery.net, git-dev@marzelpan.de,
	win@wincent.com, benji@silverinsanity.com
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Sat Feb 07 13:28:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVmIj-0004F9-Em
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 13:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbZBGMYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 07:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbZBGMYq
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 07:24:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:44323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752559AbZBGMYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 07:24:46 -0500
Received: (qmail invoked by alias); 07 Feb 2009 12:24:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 07 Feb 2009 13:24:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cCXw827uc3afsDdnBDZD8CPlEN44t+GUc3G3k3p
	dRjWuHPwAOiYI9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1233977068-24861-1-git-send-email-marcel@oak.homeunix.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108845>

Hi,

On Fri, 6 Feb 2009, Marcel M. Cary wrote:

> While the "-P" option may be slightly less commonly supported than
> /bin/pwd,

Does this not suggest that your patch should at least fall back to using 
/bin/pwd when it was detected that "cd -P" does not work?

Ciao,
Dscho
