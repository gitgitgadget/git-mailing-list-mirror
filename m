From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 15:47:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705251539260.4648@racer.site>
References: <11800866643203-git-send-email-hjemli@gmail.com> 
 <Pine.LNX.4.64.0705251157450.4648@racer.site> 
 <8c5c35580705250646h12f4f30bt301f4c4bdc2ad530@mail.gmail.com> 
 <Pine.LNX.4.64.0705251451530.4648@racer.site>
 <8c5c35580705250716j27695a01kd1db222be6c7eac7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 16:48:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrb5E-0001Ob-08
	for gcvg-git@gmane.org; Fri, 25 May 2007 16:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbXEYOrz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 10:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759678AbXEYOrz
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 10:47:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:42632 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752169AbXEYOry (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 10:47:54 -0400
Received: (qmail invoked by alias); 25 May 2007 14:47:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 25 May 2007 16:47:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ubg1u13uu5gSFuXQ+8BZIpJJv+LUJLWTuWg5XzV
	j4R46WgP4L0HgJ
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580705250716j27695a01kd1db222be6c7eac7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48384>

Hi,

On Fri, 25 May 2007, Lars Hjemli wrote:

> On 5/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Fri, 25 May 2007, Lars Hjemli wrote:
> > > On 5/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > > All in all, I like it: it is short, to the point, and it should do 
> > > > the job (maybe with a few enhancements like "--update" without 
> > > > arguments means _all_ submodules).
> > >
> > > Well, it does (or should) update all initialized submodules, but 
> > > maybe that's not what you meant?
> > 
> > Oops. I meant "init".
> 
> Hmm, it does (or should) clone all submodules if you run 'git submodule 
> --init' (no paths specified). Did it fail for you?

I don't have any superproject to try with ;-)

Actually, I missed the "$@" in modules_init. You might want to change the 
documentation, though, since it suggests (at least to yours truly) that 
you _need_ to pass a path with "--init".

Even happier,
Dscho
