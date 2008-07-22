From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Build configuration to skip ctime for modification
 test
Date: Tue, 22 Jul 2008 21:17:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807222115440.8986@racer>
References: <20080721173511.GB5387@steel.home> <4885897C.8010401@viscovery.net> <7vy73tltf5.fsf@gitster.siamese.dyndns.org> <20080722193901.GA5113@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 22:18:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLOJS-0001tY-2G
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 22:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbYGVURX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 16:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYGVURW
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 16:17:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:54974 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751820AbYGVURW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 16:17:22 -0400
Received: (qmail invoked by alias); 22 Jul 2008 20:17:20 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp026) with SMTP; 22 Jul 2008 22:17:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1868BBqb2A67Gj4QSgTtm/VgQiw8z+2V97wdGYH9Z
	jkLdCRT4TWmvuG
X-X-Sender: gene099@racer
In-Reply-To: <20080722193901.GA5113@blimp.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89521>

Hi,

On Tue, 22 Jul 2008, Alex Riesen wrote:

> +#ifndef NO_TRUSTABLE_FILEMODE
>  	if (ce->ce_ctime != (unsigned int) st->st_ctime)
>  		changed |= CTIME_CHANGED;
> +#endif

Surely you meant trust_executable_bit instead, right?

Otherwise, if you really want to tell at compile time,I think for clarity 
you have to introduce another #define, since NO_TRUSTABLE_FILEMODE 
definitely says something different than CTIME_IS_USELESS.

Ciao,
Dscho
