From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for
 disconnected transfer
Date: Fri, 16 Feb 2007 23:51:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702162348380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <28763990.2658921171630394111.JavaMail.root@vms064.mailsrvcs.net>
 <45D628E9.20605@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 23:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIBv1-0000qP-N1
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 23:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbXBPWvE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 17:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbXBPWvE
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 17:51:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:47906 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751615AbXBPWvB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 17:51:01 -0500
Received: (qmail invoked by alias); 16 Feb 2007 22:51:00 -0000
X-Provags-ID: V01U2FsdGVkX1+l0M82Q4ylYP2eox+Uk0edbzWpkCluSdV4LIJR+x
	nbLA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D628E9.20605@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39956>

Hi,

On Fri, 16 Feb 2007, Mark Levedahl wrote:

> Mark Levedahl wrote:
> > > Also as Shawn pointed out, the script too heavily depends on GNU 
> > > tar.  Can we do something about it
> > >     
> This one is easy, make tmp a directory, then build the tar file in that
> directory so the archive members don't include the tmp name, then just move
> the tar file to where it is needed...

Why not just get rid of this unneeded dependency? It is _unneeded_. Maybe 
you never suffered dependency hell (this is the only way I can explain 
your resistance). It is _good_ to get rid of dependencies.

Ah whatever, if you don't just get rid of that tar dependency, I'll just 
do it.

Ciao,
Dscho
