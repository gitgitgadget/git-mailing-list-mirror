From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [TOY PATCH] git wrapper: show similar command names for an
 unknown command
Date: Fri, 6 Jun 2008 00:00:55 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806052358580.21190@racer>
References: <alpine.DEB.1.00.0806050747000.21190@racer> <484853B1.80509@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1894355281-1212706864=:21190"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Fri Jun 06 01:03:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4OUH-0006SQ-D8
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 01:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbYFEXCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 19:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752850AbYFEXCY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 19:02:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:55070 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752411AbYFEXCY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 19:02:24 -0400
Received: (qmail invoked by alias); 05 Jun 2008 23:02:21 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp028) with SMTP; 06 Jun 2008 01:02:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gXclsQHzgYUIQszTDKHuqsaEJJcYri7rJK2qMkx
	HkdFvMRhZ02703
X-X-Sender: gene099@racer
In-Reply-To: <484853B1.80509@dirk.my1.cc>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83992>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1894355281-1212706864=:21190
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 5 Jun 2008, Dirk Süsserott wrote:

> This is really cool, especially for people that do not know the 
> different commands by heart -- like me. I often know there's a command 
> that's spelled somehow like X but I don't exactly remember. Your patch 
> seems perfect for that situation. :-)

Heh.

> Keen on seeing it in a future release. Thanks in advance. Did someone 
> suggest it or was it your very own idea?

Maybe someone suggested it in the past.  It just happened that I wanted to 
procrastinate, and levenshtein.c in my personal fork came before my eyes.  
This was the next best thing I could think of doing with it.

In the course I realized that my extension to take swaps into account was 
already known as the Damerau-Levenshtein distance, so I even learnt 
something in the process ;-)

Ciao,
Dscho

--8323329-1894355281-1212706864=:21190--
