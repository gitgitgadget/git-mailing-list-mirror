From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: dashed commands, was Re: disallowing push to currently checked-out
 branch
Date: Mon, 16 Feb 2009 11:50:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902161147390.10279@pacific.mpi-cbg.de>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <20090216035027.GA12689@coredump.intra.peff.net>
 <alpine.DEB.1.10.0902152057500.14911@asgard.lang.hm> <20090216040529.GC12689@coredump.intra.peff.net> <alpine.DEB.1.10.0902152113380.14911@asgard.lang.hm> <20090216043708.GB12986@coredump.intra.peff.net>
 <alpine.DEB.1.10.0902152143430.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 11:50:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ13n-0000q4-0f
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 11:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbZBPKtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 05:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbZBPKtS
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 05:49:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:55991 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751222AbZBPKtR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 05:49:17 -0500
Received: (qmail invoked by alias); 16 Feb 2009 10:49:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 16 Feb 2009 11:49:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19O+gQHxkhORmJsRiIsQEtVGKqrA70Eihsjd0BjT6
	vdKgpAoxfrjrvK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.10.0902152143430.14911@asgard.lang.hm>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110165>

Hi,

On Sun, 15 Feb 2009, david@lang.hm wrote:

> I am not interested in forking git. but I am saying that a backwards 
> incompatible change had better _really_ be worth it, and not just be 
> worth it for the people who live an breath git, but for the users as 
> well (this is a test that the dashed name elimination failed. in spite 
> of a volcal few saying that all the commands in the path were causing 
> problems, most people couldn't understand why the git people wanted to 
> remove them)

Nope.  It was not just because we could.  It was an explicit request by 
more than one person that we do not put 110+ commands into /usr/bin/.

As for your argument that it should be worth for the users: if you are 
really thinking about the users, and not just yourself, you will see that 
the receive.denyCurrentBranch change is required.

BTW there is a timeline.  Junio said already that it will be in 1.7 and 
not earlier.

Ciao,
Dscho
