From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Mon, 7 Jul 2008 15:34:32 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807071533240.18205@racer>
References: <20080701150119.GE5852@joyeux>  <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org>  <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de>  <20080706160758.GA23385@jhaampe.org>  <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness> 
 <20080707062142.GA5506@jhaampe.org> <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sylvain Joyeux <sylvain.joyeux@dfki.de>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 16:38:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFrqM-0002iI-PH
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 16:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbYGGOg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 10:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYGGOg2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 10:36:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:54806 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753326AbYGGOg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 10:36:28 -0400
Received: (qmail invoked by alias); 07 Jul 2008 14:36:26 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp030) with SMTP; 07 Jul 2008 16:36:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/F6ddlUaLFLZrGRtORBxoA9aWj46083YyjmXmsqZ
	IbBOfSIqYZgDx5
X-X-Sender: gene099@racer
In-Reply-To: <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87615>

Hi,

On Mon, 7 Jul 2008, Avery Pennarun wrote:

> The trick here, I think, is that there's only one time the submodule 
> should be linked to a commit you don't actually have.  It should only 
> happen if your parent module (supermodule) has been updated, but you 
> haven't recently done a fetch in the submodule.

Noooooo!

If I am actively working on the submodule, the supermodule has _no 
business_ trying to wreck my state.

Hth,
Dscho
