From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 02:30:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003100222190.7596@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302> <fabb9a1e1003091648q103ffa9co805233b57ddb3cc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-238412562-1268184615=:7596"
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 02:23:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpAdc-0003uC-Nl
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 02:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147Ab0CJBW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 20:22:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:41235 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753304Ab0CJBW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 20:22:57 -0500
Received: (qmail invoked by alias); 10 Mar 2010 01:22:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 10 Mar 2010 02:22:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zPqApWn5zzp299rJlW7ocx33fLViz4QSYvGxr7p
	HtxuuTpzQHS7Ao
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e1003091648q103ffa9co805233b57ddb3cc0@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-238412562-1268184615=:7596
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 10 Mar 2010, Sverre Rabbelier wrote:

> On Tue, Mar 9, 2010 at 19:24, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > - Comes with Git-Cheetah (on 32-bit Windows only, for now).
> 
> Oooh, cool! I gotta try this out at my university and see if it works,
> if it does we can tell the sysadmis to remove TortoiseGit and install
> Git-Cheetah instead :D.

:-)

There is a lot of opportunity to improve this (and there is a lot of 
opportunity for me to review patches, there are still some I have to look 
at closely).

> > - git gui now fully supports themed widgets (thanks Pat Thoyts and 
> >   Heiko  Voigt).
> 
> I remember from reading a thread about this (I think) a while ago that 
> the default themed widget was the usual tcl/tk stuff, what do I have to 
> do to get a different theme? Perhaps even, dare I say it, a native 
> windows look?

Good news: you do not need to do anything, gitk and git gui should now 
look like native applications out of the box.

> > - Substantially speeded up startup time from cmd unless 
> >   NO_FSTAB_THREAD is  set (thanks Johannes Sixt).
> 
> Sweet, any numbers?

Yes: http://article.gmane.org/gmane.comp.version-control.msysgit/7986

Basically, if you are not running Git from Git Bash, but from cmd.exe, 
every single call to MSys programs (such as sh.exe, perl.exe, sed.exe, 
etc) will take 100ms extra.

> Also, why would I need to set NO_FSTAB_THREAD?

When you want to access a USB stick that you plugged in after starting Git 
Bash.

> Thank you for all the hard work Dscho, keep it up!

Feedback like this is always very much appreciated! :-)

> Thank you to the people working on msysgit as well, it looks like the 
> day is coming fast that I can say "Git on windows? It Just Works (TM)"
> :).

Oh, I would not be too sure about that...

Ciao,
Dscho

--8323328-238412562-1268184615=:7596--
