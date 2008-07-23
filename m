From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Wait help.autocorrect deciseconds before running corrected
 command
Date: Wed, 23 Jul 2008 17:57:05 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807231756380.8986@racer>
References: <alpine.DEB.1.00.0807222100150.8986@racer> <20080722203730.GC5113@blimp.local> <20080722210354.GD5113@blimp.local> <alpine.DEB.1.00.0807222207110.8986@racer> <20080722212633.GF5113@blimp.local> <alpine.DEB.1.00.0807222242160.8986@racer>
 <7vsku1jz4u.fsf@gitster.siamese.dyndns.org> <20080723164109.GA5283@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 18:58:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhfC-0000oG-Qn
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbYGWQ5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYGWQ5G
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:57:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:38733 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752029AbYGWQ5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:57:05 -0400
Received: (qmail invoked by alias); 23 Jul 2008 16:57:03 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp056) with SMTP; 23 Jul 2008 18:57:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1877v8TitM7IkOh6PXBCHpgDMf4KTgqSX0Z/SWXVU
	7WzUnZj5sH3iEq
X-X-Sender: gene099@racer
In-Reply-To: <20080723164109.GA5283@blimp.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89711>

Hi,

On Wed, 23 Jul 2008, Alex Riesen wrote:

> +		if (autocorrect > 0) {
> +			fprintf(stderr, "in %0.1f seconds automatically...\n",
> +				(float)autocorrect/10.0);
> +			poll(NULL, 0, autocorrect * 100);
> +		}

What?  No countdown?  No fancy sounds when the time ran up?

Ciao,
Dscho
