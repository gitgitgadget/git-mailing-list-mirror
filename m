From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Windows binaries for qgit 2.0
Date: Mon, 17 Dec 2007 19:13:16 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171911070.9446@racer.site>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com> 
 <fk2juf$t25$1@ger.gmane.org>  <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>
  <fk2p0f$961$1@ger.gmane.org>  <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com>
  <fk2q1f$bbh$1@ger.gmane.org>  <e5bfff550712160242v54ce284emd31a29964770179c@mail.gmail.com>
  <fk3153$rtb$1@ger.gmane.org>  <e5bfff550712161426y101c77efl4f5321d3440fed3f@mail.gmail.com>
  <fk5grp$7il$2@ger.gmane.org> <e5bfff550712171105k62b90853w1c5eed64bd11fb23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Abdelrazak Younes <younes.a@free.fr>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 20:16:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4LPY-0006Zp-Gh
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 20:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624AbXLQTNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 14:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755496AbXLQTNb
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 14:13:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:56562 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753937AbXLQTNb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 14:13:31 -0500
Received: (qmail invoked by alias); 17 Dec 2007 19:13:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 17 Dec 2007 20:13:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/QBQkzJS/7Oamyrm55c7d7kaOWlaYsxCE7+gC7y
	BsKAMc9j3H8gYs
X-X-Sender: gene099@racer.site
In-Reply-To: <e5bfff550712171105k62b90853w1c5eed64bd11fb23@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68603>

Hi,

On Mon, 17 Dec 2007, Marco Costalba wrote:

> On Dec 17, 2007 10:51 AM, Abdelrazak Younes <younes.a@free.fr> wrote:
> >
> > I would like to help you with that but I can't retrieve the repository:
> >
> > $ git clone git://git.kernel.org/pub/scm/qgit/qgit4.git qgit4.git
> > Initialized empty Git repository in d:/devel/git/qgit4/qgit4.git/.git/
> > git.kernel.org[0: 130.239.17.7]: errno=Invalid argument
> > git.kernel.org[1: 199.6.1.166]: errno=Bad file descriptor
> > git.kernel.org[2: 204.152.191.8]: errno=Bad file descriptor
> > git.kernel.org[3: 204.152.191.40]: errno=Bad file descriptor
> > fatal: unable to connect a socket (Bad file descriptor)
> > fetch-pack from 'git://git.kernel.org/pub/scm/qgit/qgit4.git' failed.

This looks familiar.  It happens when there was no response to the 4 IPs 
of git.kernel.org.  This might be due to a firewall which blocks git://

> > $ git clone http://git.kernel.org/pub/scm/qgit/qgit4.git qgit4.git 
> > Initialized empty Git repository in d:/devel/git/qgit4/qgit4.git/.git/ 
> > Cannot get remote repository information. Perhaps 
> > git-update-server-info needs to be run there?
> 
> Well, perhaps, but to clone with git protocol you don't need that.

It is generally a good idea to provide the server-info for dumb protocols, 
because not everybody is fortunate enough (like you, evidently, because 
you do not seem to care all that much...) to control her outbound firewall 
restrictions.

Ciao,
Dscho
