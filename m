From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [MinGW PATCH] git clone was failing with 'invalid object name
 HEAD' if ran from cmd.exe directly
Date: Mon, 6 Aug 2007 23:48:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708062346120.14781@racer.site>
References: <BD28FA320B7749FFBE3135FE92380BCE@ntdev.corp.microsoft.com> 
 <Pine.LNX.4.64.0708061134380.14781@racer.site> 
 <a1bbc6950708061455v459182cei3fb6b3b518d4b176@mail.gmail.com> 
 <Pine.LNX.4.64.0708062255420.14781@racer.site>
 <a1bbc6950708061532t45fb0cf4w716971260b0640ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 00:48:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIBNc-0006G0-Vd
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 00:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbXHFWst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 18:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbXHFWss
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 18:48:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:35433 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932121AbXHFWsr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 18:48:47 -0400
Received: (qmail invoked by alias); 06 Aug 2007 22:48:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 07 Aug 2007 00:48:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ZZt1xUJPZuvJRCt0O5iq5JluylGHJogemVf3Atc
	tX8hZyuk3Ld82B
X-X-Sender: gene099@racer.site
In-Reply-To: <a1bbc6950708061532t45fb0cf4w716971260b0640ae@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55182>

Hi,

On Mon, 6 Aug 2007, Dmitry Kakurin wrote:

> On 8/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > > Does it mean that fork of a fork does not work on repo.or.cz?
> >
> > Yes, at the moment it does not work.  Therefore I set up 
> > git/mingw4msysgit.git, for the time being.
> 
> That's too bad. I was thinking about adopting distributed dev model for 
> MinGW port of Git: we all would fork off mingw.git on repo.or.cz and 
> then we would pull from each other instead of exchanging patches thru 
> e-mail. Personally I don't like email patch exchange process.

We can still do that.  Just set up a fork of _git.git_, and initialise it 
with mingw4msysgit.git.

> Can this problem on repo.or.cs be fixed? Did Petr reply?

I think it can.  But Pasky seems to be extraordinarily busy these days.  
So no, I got no reply besides a message on IRC that he'll try to do 
something about the situation tonight.

Ciao,
Dscho
