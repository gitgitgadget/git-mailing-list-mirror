From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Basename matching during rename/copy detection
Date: Thu, 21 Jun 2007 14:52:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706211451480.4059@racer.site>
References: <20070621030622.GD8477@spearce.org> <200706211050.03519.andyparkins@gmail.com>
 <Pine.LNX.4.64.0706211252190.4059@racer.site> <200706211344.47560.andyparkins@gmail.com>
 <vpqodj9zcxf.fsf@bauges.imag.fr> <Pine.LNX.4.64.0706211417090.4059@racer.site>
 <vpqfy4lxwvl.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 21 15:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1N5r-0002hp-RH
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 15:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbXFUNw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 09:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbXFUNw4
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 09:52:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:50763 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751827AbXFUNwz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 09:52:55 -0400
Received: (qmail invoked by alias); 21 Jun 2007 13:52:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 21 Jun 2007 15:52:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+phdMjTp+RpeUflcTNz313C7aWLNxSmkNAUnJa/
	LYqYHwz6u8C64q
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqfy4lxwvl.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50626>

Hi,

On Thu, 21 Jun 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Have you checked the files? They are all some blobs in the test scripts. 
> 
> Yes, but how does it make any difference? You still want git to manage
> them properly, don't you?

Yes. And Git explicitely allows what I call stupid. And yes, those 
_identical_ files in the test suit should probably all be folded into 
single files, and the places where they are used should reference _that_ 
single instance.

Ciao,
Dscho
