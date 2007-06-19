From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: builtin-fetch code with messy history
Date: Tue, 19 Jun 2007 12:51:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706191249480.4059@racer.site>
References: <Pine.LNX.4.64.0706190255430.4740@iabervon.org> 
 <Pine.LNX.4.64.0706191037590.4059@racer.site> 
 <81b0412b0706190313g74765babk38309dd838f3f585@mail.gmail.com> 
 <Pine.LNX.4.64.0706191210020.4059@racer.site>
 <81b0412b0706190447y37c3aedbya42b7a3d5703322c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 13:51:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0cEw-0003OH-Pi
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 13:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818AbXFSLvO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 07:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756817AbXFSLvO
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 07:51:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:50728 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756795AbXFSLvN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 07:51:13 -0400
Received: (qmail invoked by alias); 19 Jun 2007 11:51:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 19 Jun 2007 13:51:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6jgA9Gqz6OhdRwYYOdAX1mNJdwX6wqXEjq34xVZ
	KAPipkU1Fwm4q5
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0706190447y37c3aedbya42b7a3d5703322c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50473>

Hi,

On Tue, 19 Jun 2007, Alex Riesen wrote:

> On 6/19/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > Maybe this is the right time to cut off branches/* and remotes/*?
> > >
> > > Seconded. Don't use the remotes/ since some months now.
> > > But... isn't a git package with code of something like 1.4.4 is still
> > > in some major distributions?
> > 
> > Yes, AFAICT it is Ubuntu "the most up-to-date distro there is". At least
> > many questions on the list and in IRC suggest that.
> > 
> > So, how about checking (at least for a year) in builtin-fetch, if
> > "branches/" or "remotes/" exist, and fail, with a nice message how to move
> > to config-based remotes?
> 
> ...by suggesting to use a nice conversion script which we don't
> have.

git.git/contrib/remotes2config.sh

IIRC it was explicitely asked to leave branches/* out of that script, but 
the original version had it, and it should be easy to include it again.

> BTW, as far as I can see, git-remote reads old configuration just fine,
> so it probably will a very simple script: read all and write all. Well,
> the "all" part of it can be a bit complicated, but aside from that...

Ciao,
Dscho
