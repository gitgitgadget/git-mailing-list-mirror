From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/9] builtin-init-db.c: use parse_options()
Date: Sat, 26 Jul 2008 02:55:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807260254010.11976@eeepc-johanness>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-7-git-send-email-barra_cuda@katamail.com> <4888AAB2.5050007@free.fr> <alpine.DEB.1.00.0807241801030.8986@racer> <4889EF3A.6040605@free.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-1285897971-1217033718=:11976"
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sat Jul 26 02:55:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMY44-0006MD-Pm
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 02:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbYGZAyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 20:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbYGZAyR
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 20:54:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:39496 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751922AbYGZAyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 20:54:16 -0400
Received: (qmail invoked by alias); 26 Jul 2008 00:54:14 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp036) with SMTP; 26 Jul 2008 02:54:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185hVI5jQk5GT0gim3oDfZVTto54ZDmwH4QRtwcP/
	i4sM+xuuydco2c
X-X-Sender: user@eeepc-johanness
In-Reply-To: <4889EF3A.6040605@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90141>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-1285897971-1217033718=:11976
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 25 Jul 2008, Olivier Marin wrote:

> Johannes Schindelin a écrit :
> 
> > We rely on shared_repository == 0 for non-shared repositories _almost 
> > everywhere_.
> 
> I think we rely on the fact that PERM_UMASK == 0 and not on the value of 
> shared_repository. Not the same thing.

Just look at all the cases where we ask for "if (shared_repository)".  
And then look where PERM_UMASK is assigned to.  It _is_ the same thing.

Hth,
Dscho

--658432-1285897971-1217033718=:11976--
