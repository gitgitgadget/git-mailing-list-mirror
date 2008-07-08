From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Tue, 8 Jul 2008 14:00:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807081358481.18205@racer>
References: <20080706160758.GA23385@jhaampe.org> <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness> <20080707062142.GA5506@jhaampe.org> <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com> <alpine.DEB.1.00.0807071533240.18205@racer>
 <alpine.DEB.1.00.0807071537070.18205@racer> <20080707145726.GI3696@joyeux> <7v8wwd4kvb.fsf@gitster.siamese.dyndns.org> <20080708080042.GB3628@joyeux> <alpine.DEB.1.00.0807081320220.4319@eeepc-johanness> <20080708122244.GE14794@joyeux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Sylvain Joyeux <sylvain.joyeux@dfki.de>
X-From: git-owner@vger.kernel.org Tue Jul 08 15:01:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGCor-0004jf-RV
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 15:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbYGHNAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 09:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbYGHNAU
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 09:00:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:39811 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751656AbYGHNAT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 09:00:19 -0400
Received: (qmail invoked by alias); 08 Jul 2008 13:00:16 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp006) with SMTP; 08 Jul 2008 15:00:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MBEkO9LaMYH6E9x90QrkGthjhjy8zZW3VjEkah3
	kMTOdKZJRuJj7R
X-X-Sender: gene099@racer
In-Reply-To: <20080708122244.GE14794@joyeux>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87759>

Hi,

On Tue, 8 Jul 2008, Sylvain Joyeux wrote:

> [somebody wrote]
>
> > [somebody else wrote]
> >
> > > What I was missing is, given the current discussion, a git-submodule 
> > > fetch alike to what Avery was proposing, which fetches all 
> > > submodules in one command. Having to do the fetch/update manually 
> > > for each submodule is really cumbersome -- I have around 30 modules 
> > > in the superproject.
> > 
> > Did I not suggest "git submodule update" earlier?  AFAIR this updates 
> > all submodules that have been initialized.
> 
> ... and checkouts the commit registered in the superproject. Therefore 
> neither git-submodule status nor git-submodule summary can give an idea 
> of "what's new in submodules"

Yeah, now I get what you are saying.  So you want a "git submodule peek" 
or some such.

Ciao,
Dscho
