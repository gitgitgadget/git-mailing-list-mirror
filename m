From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] read_directory(): infrastructure for pathname
 character set conversion
Date: Fri, 15 May 2009 00:19:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905150018070.26154@pacific.mpi-cbg.de>
References: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain> <alpine.LFD.2.01.0905141342520.3343@localhost.localdomain> <alpine.LFD.2.01.0905141346440.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 15 00:19:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4jH6-0003su-AL
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 00:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbZENWT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 18:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbZENWT2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 18:19:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:55688 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753016AbZENWT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 18:19:28 -0400
Received: (qmail invoked by alias); 14 May 2009 22:19:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 15 May 2009 00:19:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uEgFd2szubioUF/dBQ2A6GOINflpduknsP1wMSG
	PZzHTShmsIAQRd
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.01.0905141346440.3343@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119229>

Hi,

On Thu, 14 May 2009, Linus Torvalds wrote:

> The use of "//" as the filesystem path component separator may be odd,

Hopefully it will not bite us on Windows: "//fileserver/x" is different 
from "/fileserver/x" there: the former tries to access the share "x" of 
samba server "fileserver", while the latter will expand to "C:\Program 
Files\Git\fileserver\x" (or wherever you installed Git).

Ciao,
Dscho
