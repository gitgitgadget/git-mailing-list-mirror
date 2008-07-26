From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Build configuration to skip ctime for modification
 test
Date: Sat, 26 Jul 2008 02:57:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness>
References: <4885897C.8010401@viscovery.net> <7vy73tltf5.fsf@gitster.siamese.dyndns.org> <20080722193901.GA5113@blimp.local> <alpine.DEB.1.00.0807222115440.8986@racer> <20080722203128.GB5113@blimp.local> <7vr69lihkt.fsf@gitster.siamese.dyndns.org>
 <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local> <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org> <20080725055547.GA3699@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 02:57:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMY69-0006l2-0b
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 02:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbYGZA4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 20:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbYGZA4Z
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 20:56:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:36718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751935AbYGZA4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 20:56:25 -0400
Received: (qmail invoked by alias); 26 Jul 2008 00:56:23 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp016) with SMTP; 26 Jul 2008 02:56:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VRDIIwiCV2DIL/pQZ0qZ6v98y+Ct+o2EeNj2EMY
	vKVhkqUr/dd4wN
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080725055547.GA3699@blimp.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90142>

Hi,

On Fri, 25 Jul 2008, Alex Riesen wrote:

> But, given the fact, that somewhere sometimes its very-very annoying to 
> have even one (un)changed file, something must be done about it. Maybe 
> just direct
> 
> [...]
> 	trustctime = false

... which is all Junio and I were asking all along: a separate way to ask 
for ignoring ctime; not just DWIM it on top of the executable bit.

Ciao,
Dscho
