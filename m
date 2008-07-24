From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf
 has not been set
Date: Thu, 24 Jul 2008 13:39:34 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241334340.8986@racer>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <alpine.DEB.1.00.0807230229410.8986@racer> <719E03C0-E8C3-4C35-AE9C-9BD5A7BCDF03@zib.de> <20080723114022.GP2925@dpotapov.dyndns.org>
 <FCAEAB20-750E-47B9-B58D-9BB0CB1EEAFF@zib.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-650875929-1216903175=:8986"
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 14:40:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM07g-0008PH-Ho
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 14:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757267AbYGXMje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 08:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757246AbYGXMjd
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 08:39:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:60370 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754245AbYGXMjc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 08:39:32 -0400
Received: (qmail invoked by alias); 24 Jul 2008 12:39:31 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp022) with SMTP; 24 Jul 2008 14:39:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ate8//jUaQXhcAv/+CcpfE4y53eNG78uQ4Q6TZy
	iR92hbhCwqedz2
X-X-Sender: gene099@racer
In-Reply-To: <FCAEAB20-750E-47B9-B58D-9BB0CB1EEAFF@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89873>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-650875929-1216903175=:8986
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 24 Jul 2008, Steffen Prohaska wrote:

> Dscho,
> Is the following your use case?
> 
> "I am the maintainer of this project.  I know that this project needs
>  crlf conversion, because it is a cross-platform project.  Therefore,
>  I want to force crlf conversion for this specific project, even if
>  the user did not configure core.autocrlf=input on Unix."

No.

My use case is this: a few users work on Windows (Cygwin), others on 
MacOSX, yet others on Linux.

We often integrate files from somewhere else, and them Windows guys love 
to edit their files with their anachronistic proprietary crap tools that 
add CRs where CRs no belongee.

Also, the Windows guys (being Windows guys) cannot be bothered to read 
documentation, so they did not set autocrlf.

> Your patch provides a solution, though not a very comfortable one.  With
> your patch applied, you could explicitly list all files (or filetypes)
> that are text and mark them with 'crlf'.

Why should I want to do that?  I do not _want_ CRs.  And them Windows guys 
do not need them either; they are often not even aware that their crap 
tools introduce them.

> You could also specify 'crlf=input', but I don't understand why you want 
> to specify this.

That's what I do.  And _I_ need to understand why ;-)

Well, seems I will just continue shouting "why did you commit that 
CR-ridden file?" and get shouted back with "why does this §&%&%&!° Git 
tool not fix it for me automatically?  Even _Subversion_ can do it."

Ciao,
Dscho
--8323329-650875929-1216903175=:8986--
