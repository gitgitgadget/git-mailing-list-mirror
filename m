From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: Windows binaries for qgit 2.0
Date: Mon, 17 Dec 2007 10:44:25 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171042520.9446@racer.site>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com> 
 <fk2juf$t25$1@ger.gmane.org>  <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>
  <fk2p0f$961$1@ger.gmane.org>  <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com>
  <fk2q1f$bbh$1@ger.gmane.org>  <e5bfff550712160242v54ce284emd31a29964770179c@mail.gmail.com>
  <fk3153$rtb$1@ger.gmane.org> <e5bfff550712161426y101c77efl4f5321d3440fed3f@mail.gmail.com>
 <fk5grp$7il$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Abdelrazak Younes <younes.a@free.fr>
X-From: git-owner@vger.kernel.org Mon Dec 17 11:45:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4DT5-0008JY-74
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 11:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764328AbXLQKol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 05:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764010AbXLQKol
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 05:44:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:47895 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762954AbXLQKok (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 05:44:40 -0500
Received: (qmail invoked by alias); 17 Dec 2007 10:44:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 17 Dec 2007 11:44:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18f7WpObQ4f2b0ivye8fWfFo/fJnzoiynJQLYfzsE
	91VUQntJ1ve0bo
X-X-Sender: gene099@racer.site
In-Reply-To: <fk5grp$7il$2@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68534>

Hi,

On Mon, 17 Dec 2007, Abdelrazak Younes wrote:

> Marco Costalba wrote:
> > On Dec 16, 2007 12:11 PM, Abdelrazak Younes <younes.a@free.fr> wrote:
> > > Actually you might prefer to just use the LyX dependencies package that
> > > we provide for Windows developers, it contains Qt. I paste here the
> > > relevant part of our 'INSTALL.Win32':
> > > 
> > 
> > Thanks, I've tried it but without success because I need MSVC 2005
> > installed, and currently is not.
> 
> Right.
> 
> > 
> > Anyhow for now I have produced a version with mingw that seems more or
> > less to work, when I have a bit of time I will install MSVC 2005 and
> > try if with that compiler is better...
> 
> I would like to help you with that but I can't retrieve the repository:
> 
> $ git clone git://git.kernel.org/pub/scm/qgit/qgit4.git qgit4.git
> Initialized empty Git repository in d:/devel/git/qgit4/qgit4.git/.git/
> git.kernel.org[0: 130.239.17.7]: errno=Invalid argument
> git.kernel.org[1: 199.6.1.166]: errno=Bad file descriptor
> git.kernel.org[2: 204.152.191.8]: errno=Bad file descriptor
> git.kernel.org[3: 204.152.191.40]: errno=Bad file descriptor
> fatal: unable to connect a socket (Bad file descriptor)
> fetch-pack from 'git://git.kernel.org/pub/scm/qgit/qgit4.git' failed.
> 
> $ git clone http://git.kernel.org/pub/scm/qgit/qgit4.git qgit4.git
> Initialized empty Git repository in d:/devel/git/qgit4/qgit4.git/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?
> 
> $ git --version
> git version 1.5.3.6.1791.gfd264
> 
> 'git clone ssh://...' seems to work but I guess I need a login and password?
> 
> Maybe I am doing something wrong here? Sorry, my first time ever with git...
> 
> Abdel.
> 
> PS: Sorry for the cross posting but I guess this issue is maybe of
> interest to msysgit people.

Why would anything that has to do with MSVC2005 be interesting to msysGit?  
Note the "msys" part of "msysGit".

FWIW a member of our team works on compiling/including qgit into msysGit.  
But definitely not using closed-source compilers.  I would violently 
oppose that.

Ciao,
Dscho
