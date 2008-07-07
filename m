From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Mon, 7 Jul 2008 16:21:00 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807071620030.18205@racer>
References: <20080701150119.GE5852@joyeux> <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de> <20080706160758.GA23385@jhaampe.org> <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness>
 <20080707062142.GA5506@jhaampe.org> <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com> <alpine.DEB.1.00.0807071533240.18205@racer> <alpine.DEB.1.00.0807071537070.18205@racer> <20080707145726.GI3696@joyeux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Sylvain Joyeux <sylvain.joyeux@dfki.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 17:24:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFsZI-0004q0-3K
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 17:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbYGGPW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 11:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753784AbYGGPW5
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 11:22:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:45953 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753685AbYGGPW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 11:22:57 -0400
Received: (qmail invoked by alias); 07 Jul 2008 15:22:54 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp062) with SMTP; 07 Jul 2008 17:22:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gT7MghcUgh4Hr7xfQjk0VcC1KTMHAlw1SJHQse8
	Irpo8/rOxENmFt
X-X-Sender: gene099@racer
In-Reply-To: <20080707145726.GI3696@joyeux>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87624>

Hi,

On Mon, 7 Jul 2008, Sylvain Joyeux wrote:

> > > Thus, I'd say the best fix would be to find a way to have "git pull" or 
> > > "git fetch" in the supermodule also do a fetch in the submodule.
> > If I am actively working on the submodule, the supermodule has _no 
> > business_ trying to wreck my state.
> 
> Is it possible to make 'fetch' only .. well .. fetch objects, without 
> updating any refs ? In that case it would wreck no state as no state 
> would be updated.

You have no business sneaking a fetch into an operation that does not need 
one.  Period.

If that is _still_ not enough to convince you: think about sitting in a 
plane, high above the clouds.  Yes, we try to support that mode of 
operation.

Hthf,
Dscho
