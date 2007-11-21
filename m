From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Wed, 21 Nov 2007 14:42:06 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711211441000.27959@racer.site>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site>
 <2348F06A-F9A2-4A8F-8501-D0B696F34388@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 15:42:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuqmf-0002Bg-2S
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 15:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbXKUOmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 09:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755068AbXKUOmK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 09:42:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:34762 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753777AbXKUOmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 09:42:09 -0500
Received: (qmail invoked by alias); 21 Nov 2007 14:42:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 21 Nov 2007 15:42:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19L6PEW6lFLwPoL7lKMocBMBl9esaY7gIKPd+FmMx
	HWEGlLKYUhQZH4
X-X-Sender: gene099@racer.site
In-Reply-To: <2348F06A-F9A2-4A8F-8501-D0B696F34388@adacore.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65657>

Hi,

On Wed, 21 Nov 2007, Geert Bosch wrote:

> On Nov 20, 2007, at 22:40, Johannes Schindelin wrote:
> > 	Oh, and it relies on "int" being castable to void * and vice
> > 	versa.  Is anybody aware of a platform where this can lead to
> > 	problems?
> 
> Like any 64-bit system? int is 32 bit and void * is 64. So, casting a 
> pointer to an int drops half the bits. When you convert it back it will 
> point to a funny place...

Have you even read the patch?  Like I pointed out in my reply to Hannes, I 
only need the guarantee that

	i == (int)(void *)i

for all integers i.

Ciao,
Dscho
