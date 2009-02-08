From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git-sh-setup: Use "cd" option, not /bin/pwd, for
 symlinked work tree
Date: Sun, 8 Feb 2009 21:56:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902082154450.10279@pacific.mpi-cbg.de>
References: <7viqq1hghw.fsf@gitster.siamese.dyndns.org> <1233977068-24861-1-git-send-email-marcel@oak.homeunix.org> <alpine.DEB.1.00.0902071324230.10279@pacific.mpi-cbg.de> <498F2049.9030608@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	ae@op5.se, j.sixt@viscovery.net, git-dev@marzelpan.de,
	win@wincent.com, benji@silverinsanity.com
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Sun Feb 08 21:57:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWGi4-0004hz-Jy
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 21:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbZBHUze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 15:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbZBHUze
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 15:55:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:43198 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753047AbZBHUzd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 15:55:33 -0500
Received: (qmail invoked by alias); 08 Feb 2009 20:55:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 08 Feb 2009 21:55:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/96pAScyD9bolGxrP4oE+4ryxFv3ZFehnZZRMqD5
	Sy6j7YaegVmJZK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <498F2049.9030608@oak.homeunix.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109014>

Hi,

On Sun, 8 Feb 2009, Marcel M. Cary wrote:

> Johannes Schindelin wrote:
> > On Fri, 6 Feb 2009, Marcel M. Cary wrote:
> >> While the "-P" option may be slightly less commonly supported than
> >> /bin/pwd,
> >
> > Does this not suggest that your patch should at least fall back to
> > using /bin/pwd when it was detected that "cd -P" does not work?
> 
> Having the "cd -P" strategy fall back to /bin/pwd negates most of the
> value I saw in using the simpler strategy.
> 
> I haven't found cases where "cd -P" is more correct.

Actually, it was not clear for me how much you researched the portability 
of "cd -P".

As long as it is not proven that your patch keeps working setups working, 
I think you'll have to put in a bit more effort, research it, and then put 
the discussion into the commit message.

Ciao,
Dscho
