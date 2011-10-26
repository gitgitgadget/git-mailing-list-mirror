From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git grep: be careful to use mutices only when they are
 initialized
Date: Wed, 26 Oct 2011 13:57:27 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1110261356500.32316@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1110251223500.32316@s15462909.onlinehome-server.info> <7vvcrb3c69.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 26 20:57:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ8fP-0004MG-8q
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 20:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884Ab1JZS5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 14:57:30 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:59163 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750714Ab1JZS53 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 14:57:29 -0400
Received: (qmail invoked by alias); 26 Oct 2011 18:57:27 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp010) with SMTP; 26 Oct 2011 20:57:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/20+EUIlT2Z0fhQl2cOp1EdUjCF7THLc3wkirUez
	xx/BfCaGvRnqnG
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <7vvcrb3c69.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184270>

Him

On Wed, 26 Oct 2011, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Rather nasty things happen when a mutex is not initialized but locked 
> > nevertheless. Now, when we're not running in a threaded manner, the 
> > mutex is not initialized, which is correct.
> 
> Thanks; I wonder why pack-objects does not have the same issue, though.

Those tests do not fail here, so I did not investigate.

Ciao,
Johannes
