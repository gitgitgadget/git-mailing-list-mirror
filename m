From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-rerere: fix conflict markers parsing
Date: Mon, 7 Jul 2008 14:02:20 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807071400180.18205@racer>
References: <1215434568-30456-1-git-send-email-dkr+ml.git@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Mon Jul 07 15:06:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFqPc-0000Bf-OY
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 15:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbYGGNER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 09:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbYGGNER
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 09:04:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:56639 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754106AbYGGNEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 09:04:16 -0400
Received: (qmail invoked by alias); 07 Jul 2008 13:04:14 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp063) with SMTP; 07 Jul 2008 15:04:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+r5GBRBcurkIrCcU8a+sR1Cv3885jB8SauRAush5
	UWFSmYZ25i3EYj
X-X-Sender: gene099@racer
In-Reply-To: <1215434568-30456-1-git-send-email-dkr+ml.git@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87604>

Hi,

On Mon, 7 Jul 2008, Olivier Marin wrote:

> From: Olivier Marin <dkr@freesurf.fr>
> 
> When a conflicting file contains a line that begin with "=======", rerere
> failed to parse conflict markers. This result to a wrong preimage file and
> an unexpected error for the user.
> 
> This patch enforce parsing rules so that markers match in the right order
> and update tests to match the above fix.

So what about

	<<<<<<< This hunk contains =====
	anythin
	=======

	Hello
	=======
	somethin else
	>>>>>>> problem!


If you fix it, I think you should do it properly, and analyze the index.

Ciao,
Dscho
