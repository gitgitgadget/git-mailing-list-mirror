From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Remove unused variables
Date: Tue, 22 Mar 2011 19:42:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1103221940050.1561@bonsai2>
References: <cover.1300798069.git.johannes.schindelin@gmx.de> <2aeb4f915afaf712c1d5bba46f4010a325ea14c5.1300798069.git.johannes.schindelin@gmx.de> <7v39mfkons.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:42:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q26XA-0005oi-U9
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 19:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671Ab1CVSmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 14:42:20 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:50163 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751103Ab1CVSmT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 14:42:19 -0400
Received: (qmail invoked by alias); 22 Mar 2011 18:42:14 -0000
Received: from pD9EB235B.dip0.t-ipconnect.de (EHLO noname) [217.235.35.91]
  by mail.gmx.net (mp058) with SMTP; 22 Mar 2011 19:42:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+w0Qp1nX+wAZ95reaaHD/RkD7MH0y6btZnjm2+Jh
	I7mui9+8HIdF1b
X-X-Sender: gene099@bonsai2
In-Reply-To: <7v39mfkons.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169760>

Hi,

On Tue, 22 Mar 2011, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Noticed by gcc 4.6.0.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> Thanks.
> 
> I'll cherry pick only some bits, not because the changes in this patch 
> are wrong, but because I know some areas are in flux and I don't want to 
> deal with merge conflicts of the "one side fixed a small bug, the other 
> side majorly rewrote it and made the bug irrelevant" kind.

Understandable. I will have to deal with the merge conflicts, though, as I 
am stuck with 4.6.0 (and self-imposed -Werror, as you might remember) for 
the 64-bit Windows build. So I will keep the remains of the patch after 
rebasing in our 'devel' branch.

Ciao,
Johannes
