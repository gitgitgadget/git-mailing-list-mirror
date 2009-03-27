From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing stat() with FindFirstFile()
Date: Fri, 27 Mar 2009 03:25:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903270320020.10279@pacific.mpi-cbg.de>
References: <20090321154738.GA27249@jeeves.jpl.local> <200903212055.15026.j6t@kdbg.org> <20090324215416.GB27249@jeeves.jpl.local> <49CB2BA5.1070100@viscovery.net> <20090326213907.GC27249@jeeves.jpl.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-808539799-1238120702=:10279"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Magnus_B=E4ck?= <baeck@swipnet.se>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Mar 27 03:24:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln1kc-0007mD-2B
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 03:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762986AbZC0CW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 22:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762943AbZC0CWz
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 22:22:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:51625 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762054AbZC0CWx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 22:22:53 -0400
Received: (qmail invoked by alias); 27 Mar 2009 02:22:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 27 Mar 2009 03:22:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zMV9YIa5zYciO+/BC+Ha+9KQRbWIpHAFaWkFcfo
	4LF8QZRcVxIQCe
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090326213907.GC27249@jeeves.jpl.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114841>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-808539799-1238120702=:10279
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

Magnus, it is the official policy to reply-to-all on this list.  This has 
been mentioned in the past quite often, and it will be mentioned in the 
future, too.

You actually forced me to manually look up and re-add Hannes' address.  I 
do not appreciate having to waste my time like that.

If that sounds negative, please understand that I am used to the ways of 
this list, and when I am annoyed by somebody not fitting in, then it is 
not totally _my_ mistake.

On Thu, 26 Mar 2009, Magnus Bäck wrote:

> On Thursday, March 26, 2009 at 08:15 CET,
>      Johannes Sixt <j.sixt@viscovery.net> wrote:
> 
> > Magnus Bäck schrieb:
> >
> > > From what I gather the problematic conversion takes place in the 
> > > Win32 layer, in which case we might be able to call the 
> > > ZwQueryDirectoryFile() kernel routine directly via ntdll.dll to 
> > > obtain the file times straight from the file system. Has anyone 
> > > explored that path, and would it be acceptable to make such a 
> > > change?
> >
> > It depends.
> >
> > The disadvantages are that this function is only available on Windows 
> > XP and later and that it is not present in the header files of MinGW 
> > gcc.
> 
> I'd be very surprised if ZwQueryDirectoryFile() hasn't always been 
> around (I just verified ntdll.dll from NT 4.0), so that's not a worry. 
> Don't know why MSDN reports it as introduced in XP.

As the current maintainer of msysGit, I refuse to have something in the 
installer I ship that relies on not-at-all guaranteed interfaces.

> > It's on you to prove that there are advantages that clearly outweigh 
> > these disadvantages.
> 
> All right, I'll see if I can find time to take a look at this. I just 
> wanted to check that it wasn't a project policy or whatever to bypass 
> Win32.

You can do whatever you want... This is Open Source.

However, I will try to stay with the officially supported functionality, 
even if that makes msysGit slower -- Windows will never reach the 
performance levels of Linux anyway.

Ciao,
Dscho

--8323328-808539799-1238120702=:10279--
