From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 12:48:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806241246500.9925@racer>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>  <1214306517.6441.10.camel@localhost> <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Kestenholz <mk@spinlock.ch>, git@vger.kernel.org
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 13:51:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB73U-00022o-V3
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 13:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935AbYFXLuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 07:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbYFXLuY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 07:50:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:44275 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753365AbYFXLuX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 07:50:23 -0400
Received: (qmail invoked by alias); 24 Jun 2008 11:50:21 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp055) with SMTP; 24 Jun 2008 13:50:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qi1RQQPeqlxKnRx9oL77nmuv/IzS4tzI4HYfKoq
	eFepmkyArdGtp4
X-X-Sender: gene099@racer
In-Reply-To: <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86038>

Hi,

On Tue, 24 Jun 2008, Erez Zilber wrote:

> On Tue, Jun 24, 2008 at 2:21 PM, Matthias Kestenholz <mk@spinlock.ch> wrote:
> > On Tue, 2008-06-24 at 14:15 +0300, Erez Zilber wrote:
> >
> >> [root@kd001 t]# git-clone http://kites/pub/git/erez.zilber/my_test.git
> >> Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_test/.git/
> >> Cannot get remote repository information.
> >> Perhaps git-update-server-info needs to be run there?
> >>
> >
> > Maybe you should run git-update-server-info in the repository on the
> > server?
> 
> Forgot to mention - I tried to run git-update-server-info from the
> repository on the server.

No, you did not.  Otherwise, the message would not appear.  It can be that 
you have _another_ repository on the server, but running 
update-server-info there does not help.

> I got the same results. BTW - if it works OK with ssh, I can only guess 
> that git-update-server-info won't help for http. right?

Wrong again.  ssh transport is special, and does not need the information 
update-server-info provides.

Hth,
Dscho
