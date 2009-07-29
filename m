From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Git for Windows 1.6.4
Date: Thu, 30 Jul 2009 00:20:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907300018451.8306@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0907292331090.8306@pacific.mpi-cbg.de> <46d6db660907291503o6979ef9fvbef5d25fa4318e37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-874360427-1248906045=:8306"
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:20:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWHVp-0001kd-IS
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 00:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbZG2WUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 18:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320AbZG2WUe
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 18:20:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:35295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752890AbZG2WUd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 18:20:33 -0400
Received: (qmail invoked by alias); 29 Jul 2009 22:20:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 30 Jul 2009 00:20:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19r6PpwzxBrVDmKwBDBcC5yJSCdLueuK5qa0aZgRE
	UnmmCzaZolx46v
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <46d6db660907291503o6979ef9fvbef5d25fa4318e37@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124398>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-874360427-1248906045=:8306
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 30 Jul 2009, Christian MICHON wrote:

> On Wed, Jul 29, 2009 at 11:40 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> >
> > this mail informs you that Git for Windows 1.6.4 is out.  It is less 
> > well tested than the previous versions, mainly because I was busy with 
> > other things and asked for help with testing on the msysGit mailing 
> > list and I am very impatient.
> 
> I'm still too busy, but since I saw your email arriving live and I've
> Vista here, I kept some minutes for you :)
> 
> >
> > Git Release Notes (Git-1.6.4-preview20090729)
> > Last update: 29 July 2009
> >
> 
> bad news: here the installation complains around the end (all default answers)

Uh oh.

> "Could not set CR/LF behavior: core.autoCRLF true"
> 
> Using git gui works, calling gitk from it works.
> But git bash initiates a shell complaining:
> 
> ====================================================================
> -------------------------------------------------------
> Building and Installing Git
> -------------------------------------------------------
> sh.exe": cd: /git: No such file or directory

Ah, you are not installing Git for Windows, but msysGit.

Now the question is if full or net.

I will not guess, especially since I am dead tired after that hour it 
always takes to make a new release.

> Apparently, git binaries are not in the path. I'll check on a winXP
> and win2003 environments asap.

Pff.

I think it is the lack of libcrypto.dll and libssl.dll.  And now I know 
you used the net installer.

As I said, would have been nice to be precise.

Ciao,
Dscho

--8323328-874360427-1248906045=:8306--
