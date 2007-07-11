From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: test suite fails if sh != bash || tar != GNU tar
Date: Wed, 11 Jul 2007 12:09:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707111209160.4516@racer.site>
References: <7154c5c60707101939sc921b07wef1d14f85086947d@mail.gmail.com> 
 <Pine.LNX.4.64.0707110347580.4047@racer.site> 
 <alpine.LFD.0.999.0707102020020.3412@woody.linux-foundation.org>
 <7154c5c60707102108g59280301pa5c3c0dc3911753d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: David Frech <david@nimblemachines.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 13:17:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8aCK-0002f7-Ph
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 13:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759729AbXGKLR3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 07:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759740AbXGKLR3
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 07:17:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:52731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757126AbXGKLR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 07:17:28 -0400
Received: (qmail invoked by alias); 11 Jul 2007 11:17:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 11 Jul 2007 13:17:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+erlEtXa2etuEa2x4MytJHXszpktcac0slqLlU+s
	wDAOwXp3jiUmFu
X-X-Sender: gene099@racer.site
In-Reply-To: <7154c5c60707102108g59280301pa5c3c0dc3911753d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52151>

Hi,

On Tue, 10 Jul 2007, David Frech wrote:

> On 7/10/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Wed, 11 Jul 2007, Johannes Schindelin wrote:
> > > As for GNU tar, I think that this is easily fixable if you have 
> > > access to non-GNU tar.  We do not use tar _ever_, except for the 
> > > test suite, to verify that things are working as expected.
> > >
> > > If you could put in some time to make the tests work, that would be 
> > > awesome.
> > 
> > Yeah, it would be a good thing to get rid of any bashisms, but to 
> > _keep_ it working somebody would then need to test every once in a 
> > while that it still works ;)
> 
> I'll see what I can do. As I'm planning on running git on both FreeBSD 
> and DragonFly for the forseeable future, and plan to track git's 
> evolution (running stable releases if not more bleeding-edge code), I 
> can run the test suite every time I build a new git.

If you want to, I can help you setting up a nightly cron job to fetch what 
is the current "next", run the tests, and report failures by email.

Ciao,
Dscho
