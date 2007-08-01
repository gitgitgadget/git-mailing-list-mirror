From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] rebase -i: handle --continue more like non-interactive
 rebase
Date: Wed, 1 Aug 2007 16:57:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708011654510.14781@racer.site>
References: <Pine.LNX.4.64.0707080300440.4093@racer.site>
 <20070712222640.GA30532@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 17:58:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGGaz-0000Cv-Ux
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 17:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761085AbXHAP5x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 11:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761084AbXHAP5w
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 11:57:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:52206 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760730AbXHAP5u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 11:57:50 -0400
Received: (qmail invoked by alias); 01 Aug 2007 15:57:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 01 Aug 2007 17:57:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/hntx/i+DhFtVh9cVUIOO6zPPCuoKloqRzHs1GRD
	oJdLymMecDx4c9
X-X-Sender: gene099@racer.site
In-Reply-To: <20070712222640.GA30532@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54445>

Hi,

On Fri, 13 Jul 2007, Alex Riesen wrote:

> Johannes Schindelin, Sun, Jul 08, 2007 04:01:29 +0200:
> > Non-interactive rebase requires the working tree to be clean, but
> > applies what is in the index without requiring the user to do it
> > herself.  Imitate that, but (since we are interactive, after all)
> > fire up an editor with the commit message.
> 
> Could we also have "git rebase <base> <branch>"?

Don't we do that already?  AFAICT it is already in the synopsis, ever 
since rebase -i was introduced into the "next" branch, on June 25...

Ciao,
Dscho
