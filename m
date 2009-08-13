From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: msysGit and SCons: broken?
Date: Thu, 13 Aug 2009 23:54:20 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908132353380.8306@pacific.mpi-cbg.de>
References: <4A772A43.8070503@dirk.my1.cc> <alpine.DEB.1.00.0908040010220.8306@pacific.mpi-cbg.de> <4A7B32EA.2080505@dirk.my1.cc> <4A846A5A.4000000@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1070618631-1250200460=:8306"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Thu Aug 13 23:54:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbiFH-0003Ix-A9
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 23:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbZHMVxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 17:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753715AbZHMVxk
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 17:53:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:59944 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753706AbZHMVxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 17:53:39 -0400
Received: (qmail invoked by alias); 13 Aug 2009 21:53:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp010) with SMTP; 13 Aug 2009 23:53:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19u4Jpn3mhuPGvWtyDpv1h75flsgKPIgV3Xa7hXsP
	zQORkPUfW8PJoF
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A846A5A.4000000@dirk.my1.cc>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125883>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1070618631-1250200460=:8306
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 13 Aug 2009, Dirk Süsserott wrote:

> Am 06.08.2009 21:45 schrieb Dirk Süsserott:
> > Am 04.08.2009 00:13 schrieb Johannes Schindelin:
> > > On Mon, 3 Aug 2009, Dirk Süsserott wrote:
> > >
> > > How does your SCons call relate to Git?  Do you call it from the Git Bash?
> > > Do you call it from cmd.exe directly?  Is Git/bash in your PATH?
> > 
> > I used to call SCons from Git-bash and it worked. After Git's upgrade (or
> > some other unknown change) I did the same and it didn't work from Git-bash,
> > but it still worked from cmd.exe. Git-bash ist not in my PATH when I run
> > cmd.exe.
> 
> If someone had the same or a similar problem: I tracked it down and 
> found a solution. The problem was that I tried to run a Windows program 
> from git-bash. The Windows program then faces the bash's $PATH with a 
> different separator (':' vs. ';') and a different root directory ('/c/' 
> vs. 'C:/').

I cannot believe that.  I actually run a Windows program very often, from 
Git Bash, and PATH is correctly converted all the time.

Ciao,
Dscho
--8323328-1070618631-1250200460=:8306--
