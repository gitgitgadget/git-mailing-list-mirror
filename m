From: Nicolas Pitre <nico@cam.org>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 11:34:25 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705171130030.24220@xanadu.home>
References: <20070515201006.GD3653@efreet.light.src>
 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
 <Pine.LNX.4.64.0705161232120.6410@racer.site>
 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
 <Pine.LNX.4.64.0705170152470.6410@racer.site>
 <20070517010335.GU3141@spearce.org>
 <alpine.LFD.0.99.0705162309310.24220@xanadu.home>
 <Pine.LNX.4.64.0705171143350.6410@racer.site>
 <alpine.LFD.0.99.0705170954200.24220@xanadu.home>
 <46a038f90705170824g4ef8c800w826ada3964b711a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 17:34:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hoi01-0002mN-Pb
	for gcvg-git@gmane.org; Thu, 17 May 2007 17:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053AbXEQPef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 11:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756000AbXEQPef
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 11:34:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56265 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906AbXEQPee (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 11:34:34 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JI60008OZ9DFZF0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 May 2007 11:34:25 -0400 (EDT)
In-reply-to: <46a038f90705170824g4ef8c800w826ada3964b711a@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47532>

On Fri, 18 May 2007, Martin Langhoff wrote:

> On 5/18/07, Nicolas Pitre <nico@cam.org> wrote:
> > And if you have 1) the permission and 2) the CPU power to execute such a
> > cgi on the server and obviously 3) the knowledge to set it up properly,
> > then why aren't you running the Git daemon in the first place?
> 
> And you probably _are_ running git daemon. But some clients may be on
> shitty connections that only allow http. That's one of the scenarios
> we're discussing.

That's not what I'm disputing at all.

I'm disputing the vertue of an HTTP solution involving a cgi with Git 
bundles vs an HTTP solution involving static file range serving.  The 
clients on shitty connections don't care either ways.


Nicolas
