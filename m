From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Wed, 21 Nov 2007 14:01:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711211209080.27959@racer.site>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <4743E1D6.4010308@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 15:02:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuq8p-0001Rp-T3
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 15:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbXKUOBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 09:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753477AbXKUOBF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 09:01:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:35011 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753218AbXKUOBE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 09:01:04 -0500
Received: (qmail invoked by alias); 21 Nov 2007 14:01:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 21 Nov 2007 15:01:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VJWMvFUeVhXQsa8e0ev7Pk/lS3orFRYslSNNV5u
	dOxklo1F+gFg4c
X-X-Sender: gene099@racer.site
In-Reply-To: <4743E1D6.4010308@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65651>

Hi,

On Wed, 21 Nov 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > 	Oh, and it relies on "int" being castable to void * and vice versa.
> >     Is anybody aware of a platform where this can lead to problems?
> 
> Win64?

Is this really a problem?  I mean, all I need is that i == (int)(void *)i.

My doubts came from platforms where you can access memory only aligned to 
4-byte chunks, and that it _may_ be possible that some of them do not even 
store the least significant two bits.

Ciao,
Dscho

P.S.: I'll try to read up on ptrint_t, as suggested by Shawn.
