From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Mon, 7 Jul 2008 17:10:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807071710140.18205@racer>
References: <20080701150119.GE5852@joyeux>  <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org>  <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de>  <20080706160758.GA23385@jhaampe.org>  <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness> 
 <20080707062142.GA5506@jhaampe.org>  <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com>  <alpine.DEB.1.00.0807071533240.18205@racer>  <32541b130807070757s4ba03e28tf4701f479e27b687@mail.gmail.com>  <alpine.DEB.1.00.0807071621300.18205@racer>
 <32541b130807070836n5c6efadu184114f7ed1476e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sylvain Joyeux <sylvain.joyeux@dfki.de>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 18:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFtLQ-0007Ht-O1
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 18:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbYGGQMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 12:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbYGGQMl
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 12:12:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:39214 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753133AbYGGQMl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 12:12:41 -0400
Received: (qmail invoked by alias); 07 Jul 2008 16:12:39 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp029) with SMTP; 07 Jul 2008 18:12:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+OTs1AiA+wb6+j+C4KuKKNTihw6vNIiv6HQHvcP
	BXvh3CGLlUfmTe
X-X-Sender: gene099@racer
In-Reply-To: <32541b130807070836n5c6efadu184114f7ed1476e0@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87630>

Hi,

On Mon, 7 Jul 2008, Avery Pennarun wrote:

> What I suggested was to recursively do "git fetch" in submodules at
> the time of doing fetch or pull operations on the supermodule, in
> order to help ensure that all necessary objects have been fetched.

IMO "git submodule update" is just good enough.

Ciao,
Dscho
