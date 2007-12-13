From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 13 Dec 2007 12:25:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712131224340.27959@racer.site>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com> 
 <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com> 
 <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com> 
 <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com> 
 <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com> 
 <20071212041002.GN14735@spearce.org>  <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>
  <20071212052329.GR14735@spearce.org>  <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com>
  <Pine.LNX.4.64.0712121814260.27959@racer.site>
 <31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com>
 <Pine.LNX.4.64.0712121931050.27959@racer.site> <4760E0CF.1030805@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jason Sewall <jasonsewall@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Dec 13 13:26:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2n8f-00048E-JJ
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 13:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbXLMMZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 07:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbXLMMZl
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 07:25:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:38642 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750925AbXLMMZk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 07:25:40 -0500
Received: (qmail invoked by alias); 13 Dec 2007 12:25:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 13 Dec 2007 13:25:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rULZZCZ1raGO6canOvphFA7nuTLSZRqXCTuQG06
	itkEncFqQc3x+Z
X-X-Sender: gene099@racer.site
In-Reply-To: <4760E0CF.1030805@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68142>

Hi,

On Thu, 13 Dec 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > When you select the context menu item "Split Hunk" in the diff area,
> > git-gui will now split the current hunk so that a new hunk starts at
> > the current position.
> > 
> > For this to work, apply has to be called with --unidiff-zero, since
> > the new hunks can start or stop with a "-" or "+" line.
> 
> NACK! --unidiff-zero eats your data.

Did I not make crystal clear that I intended this patch to be cleaned up 
first, to not need unidiff-zero?

If so, my sincerest apologies.

THIS PATCH IS NOT MEANT FOR APPLICATION, BUT FOR JASON TO PLAY WITH.

Ciao,
Dscho
