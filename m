From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Tue, 26 Jan 2010 12:01:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001261200010.4641@intel-tinevez-2-302>
References: <201001250155.47664.robin.rosenberg@dewire.com> <alpine.DEB.1.00.1001251553150.8733@intel-tinevez-2-302> <201001252104.10328.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-586593091-1264503698=:4641"
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 12:03:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZjB4-0001mh-3u
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 12:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab0AZLBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 06:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752976Ab0AZLBm
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 06:01:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:42298 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752321Ab0AZLBl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 06:01:41 -0500
Received: (qmail invoked by alias); 26 Jan 2010 11:01:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp059) with SMTP; 26 Jan 2010 12:01:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TXPpkGU7T9HPas5sFKliHJeT9541D4IhS2u6fw7
	dv2ZcfeD3oKh8m
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <201001252104.10328.robin.rosenberg@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138029>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-586593091-1264503698=:4641
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 25 Jan 2010, Robin Rosenberg wrote:

> måndagen den 25 januari 2010 18.34.01 skrev  Johannes Schindelin:
> > I am also not quite sure if you can get away with having the same offset
> > for both: if I have "C:\blah" and strip off "C:", I always have a
> > directory separator to bounce against, whereas I do not have that if I
> > strip off the two "\\" of a UNC path.  Besides, I maintain that the host
> > name, and maybe even the share name, should not ever be stripped off!
> 
> Advices needed:
> 
> d:somedir (when cwd=d:\msysgit, == /) may be tricky to fix.

This is a totally different issue from the UNC issue you brought up.  May 
I suggest to fix the UNC thing first, and if you feel inclined, take care 
of the relative DOS drive path afterwards?

The relative DOS drive path is also not something I find overly pressing, 
as I work from the Git bash, as you know, which does not translate 
POSIX-style paths into such relative DOS drive paths.

Ciao,
Dscho
--8323329-586593091-1264503698=:4641--
