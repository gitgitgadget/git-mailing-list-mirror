From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Big project, slow access!
Date: Fri, 18 Sep 2009 16:19:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909181612040.24133@xanadu.home>
References: <ffb2c0280909181138r7fde8722n80be4bdf95864c37@mail.gmail.com>
 <a4c8a6d00909181205x6b8c348ct270fba6d27df5604@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_vWBK7TbddxEJj83Evgx9HQ)"
Cc: Toan Pham <tpham3783@gmail.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 22:20:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mojw1-0006op-Gv
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 22:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758543AbZIRUTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 16:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758212AbZIRUTs
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 16:19:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27786 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757539AbZIRUTp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 16:19:45 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQ60035FOGZL2J0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 18 Sep 2009 16:19:48 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <a4c8a6d00909181205x6b8c348ct270fba6d27df5604@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128811>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_vWBK7TbddxEJj83Evgx9HQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Fri, 18 Sep 2009, Thiago Farina wrote:

> On Fri, Sep 18, 2009 at 3:38 PM, Toan Pham <tpham3783@gmail.com> wrote:
> > Hi,
> >
> > I use git to maintain a project that is at least 8 gigs in size.
> > The project is a Linux from Scratch repository that includes source
> > codes to approximately 2000 open source projects,
> > gcc tool-chain, 1000+ configurations for different software packages,
> > source code for different kernel versions,
> > and many linux distributions/flavors resulted from this LFS build environment.
> >
> > The git's object repository is now 4.6 gigs and consists of approx.
> > 610,000 files and folders.
> > The speed of git is now terribly slow.  Each time I use basic commands
> > like 'git status' or 'git diff',
> > it would take at least 5 minutes for git to give me back a result.
> > Again, the machine that i run git on is a P4 3.2 gig-hertz with HT.
> >
> > would  someone please recommend on how i can optimize git's performance?
> > Git is so slow, are there better ways to manage a project like this?
> Git is so slow? What you expect with 4.6 gigs? It take some time to do
> the things. And it is not slow. It is very fast, and it was created
> with this goal, to be more fast than others VCS.

I wrote some piece of the code in Git and I do know how it is 
possible for git to become very slow.  Denying it is not the way to go.


Nicolas

--Boundary_(ID_vWBK7TbddxEJj83Evgx9HQ)--
