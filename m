From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add an option for using any HTTP authentication scheme,
 not only basic
Date: Tue, 14 Apr 2009 23:42:29 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904142342130.10279@pacific.mpi-cbg.de>
References: <Pine.LNX.4.64.0904142350140.7479@localhost.localdomain> <alpine.DEB.1.00.0904142307110.10279@pacific.mpi-cbg.de> <Pine.LNX.4.64.0904150007130.7479@localhost.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1271623994-1239745352=:10279"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Tue Apr 14 23:41:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtqNg-0001VI-95
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 23:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401AbZDNVjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 17:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754634AbZDNVjs
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 17:39:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:42430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754981AbZDNVjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 17:39:48 -0400
Received: (qmail invoked by alias); 14 Apr 2009 21:39:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 14 Apr 2009 23:39:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196BFlttD963NPVP10ivLOZSKWCm1RYM2vCaR2z2J
	/hS9ZXwQcJKbKw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <Pine.LNX.4.64.0904150007130.7479@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116579>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1271623994-1239745352=:10279
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 15 Apr 2009, Martin Storsjö wrote:

> On Tue, 14 Apr 2009, Johannes Schindelin wrote:
> 
> > In six months from now, it might be easier to read
> > 
> > #if LIBCURL_VERSION_NUM >= 0x070a06
> > #define LIBCURL_CAN_HANDLE_ANY_AUTH
> > #endif
> > 
> > [...]
> > 
> > #ifdef LIBCURL_CAN_HANDLE_ANY_AUTH
> > [...]
> > 
> > Don't you agree?
> 
> Yeah, absolutely.
> 
> Any comments on the naming of options and env variables? Otherwise, I'll 
> resend an updated version soon.

They sound sensible enough to me!

Thanks,
Dscho

--8323328-1271623994-1239745352=:10279--
