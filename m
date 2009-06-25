From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Displaying Current Git Aliases
Date: Thu, 25 Jun 2009 18:08:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906251807540.8908@intel-tinevez-2-302>
References: <c115fd3c0906250859q661d2319i463d6eea7e9dbe54@mail.gmail.com> <4D088847-3CD8-4DD2-B129-A8FC3B0E20D0@wincent.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-177862972-1245946120=:8908"
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:10:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJrWq-00040P-Dm
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 18:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758397AbZFYQIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 12:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758854AbZFYQIk
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 12:08:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:44691 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759063AbZFYQIj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 12:08:39 -0400
Received: (qmail invoked by alias); 25 Jun 2009 16:08:41 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp020) with SMTP; 25 Jun 2009 18:08:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198qCh9PJ989LlatjIstv4e21mR+OVRqnDPCG6hSD
	SHm5O7eepS73M9
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4D088847-3CD8-4DD2-B129-A8FC3B0E20D0@wincent.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122217>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-177862972-1245946120=:8908
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 25 Jun 2009, Wincent Colaiuta wrote:

> El 25/6/2009, a las 17:59, Tim Visher escribió:
> 
> > Can git display a list of all of your current aliases like bash's
> > `alias` command?
> 
> Something like:
> 
>   git config --list | grep alias

Or without a pipe (so you catch the exit status of git config easily):

	git config --get-regexp ^alias\\.

Ciao,
Dscho

--8323329-177862972-1245946120=:8908--
