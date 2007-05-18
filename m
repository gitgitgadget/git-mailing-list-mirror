From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 10:01:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705180958390.6410@racer.site>
References: <20070515201006.GD3653@efreet.light.src>
 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
 <Pine.LNX.4.64.0705161232120.6410@racer.site>
 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
 <Pine.LNX.4.64.0705170152470.6410@racer.site> <20070517010335.GU3141@spearce.org>
 <alpine.LFD.0.99.0705162309310.24220@xanadu.home> <Pine.LNX.4.64.0705171143350.6410@racer.site>
 <alpine.LFD.0.99.0705170954200.24220@xanadu.home> <20070517200431.GA3079@efreet.light.src>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1970487718-1179478912=:6410"
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri May 18 11:02:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoyLp-0007Rr-LM
	for gcvg-git@gmane.org; Fri, 18 May 2007 11:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbXERJCI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 05:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754864AbXERJCI
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 05:02:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:55496 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754297AbXERJCG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 05:02:06 -0400
Received: (qmail invoked by alias); 18 May 2007 09:02:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 18 May 2007 11:02:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ciXZHcYgcuc6uj8SuM5RLHYvdnZBfaC1mRUrUhO
	abNtknwVnaU6ok
X-X-Sender: gene099@racer.site
In-Reply-To: <20070517200431.GA3079@efreet.light.src>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47583>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1970487718-1179478912=:6410
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 17 May 2007, Jan Hudec wrote:

> On Thu, May 17, 2007 at 10:41:37 -0400, Nicolas Pitre wrote:
>
> > And if you have 1) the permission and 2) the CPU power to execute such 
> > a cgi on the server and obviously 3) the knowledge to set it up 
> > properly, then why aren't you running the Git daemon in the first 
> > place?  After all, they both boil down to running git-pack-objects and 
> > sending out the result.  I don't think such a solution really buys 
> > much.
> 
> Yes, it does. I had 2 accounts where I could run CGI, but not separate 
> server, at university while I studied and now I can get the same on 
> friend's server. Neither of them would probably be ok for serving larger 
> busy git repository, but something smaller accessed by several people is 
> OK. I think this is quite common for university students.

1) This has nothing to do with the way the repo is served, but how much 
you advertise it. The load will not be lower, just because you use a CGI 
script.

2) you say yourself that git-daemon would have less impact on the load:

> > [...]
> >
> > Et voilà.  Oh, and of course update your local refs from the 
> > remote's.
> > 
> > Actually there is nothing really complex in the above operations. And 
> > with this the server side remains really simple with no special setup 
> > nor extra load beyond the simple serving of file content.
> 
> On the other hand the amount of data transfered is larger, than with the 
> git server approach, because at least the indices have to be transfered 
> in entirety.

Ciao,
Dscho

--8323584-1970487718-1179478912=:6410--
