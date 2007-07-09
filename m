From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix "git log --parent -m" from emitting duplicated parent
 info
Date: Mon, 9 Jul 2007 02:15:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707090214280.4248@racer.site>
References: <e5bfff550707080737j56c161bdrf0c079b61877085b@mail.gmail.com>
 <7vd4z2za2g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 03:22:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7hxZ-0001tT-HK
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 03:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676AbXGIBWj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 21:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757624AbXGIBWj
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 21:22:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:37494 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756450AbXGIBWi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 21:22:38 -0400
Received: (qmail invoked by alias); 09 Jul 2007 01:22:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 09 Jul 2007 03:22:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18EAQMyIMEENWuXSXxWWj4JbAw0Yc2/jrX2T5leKK
	X03AqPPUhO/R1n
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4z2za2g.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51940>

Hi,

On Sun, 8 Jul 2007, Junio C Hamano wrote:

> I wonder why we did not actually remove the duplicate parents
> >from "commit->parents" list after history simplification when we
> originally did 88494239, instead of filtering only on the output
> path.  Anybody remember the reason?

I do not have that commit here.

Ciao,
Dscho
