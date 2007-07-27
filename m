From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: fix interrupted squashing
Date: Fri, 27 Jul 2007 18:18:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707271817100.14781@racer.site>
References: <20070723225402.GB22513@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0707240005240.14781@racer.site> <20070724200510.GA27610@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0707242139370.14781@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1986573347-1185556712=:14781"
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 19:19:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IETSz-0006Kk-GV
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 19:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765681AbXG0RSn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 13:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765667AbXG0RSn
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 13:18:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:52100 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764006AbXG0RSm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 13:18:42 -0400
Received: (qmail invoked by alias); 27 Jul 2007 17:18:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 27 Jul 2007 19:18:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TnMAIj1mTkHJXPIYhN5xT72QeacPdmUFZko61XN
	KmMCea/9qk1cwl
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707242139370.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53935>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1986573347-1185556712=:14781
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 24 Jul 2007, Johannes Schindelin wrote:

> 
> When a squashing merge failed, the first commit would not be replaced,
> due to "git reset --soft" being called with an unmerged index.
> 
> Noticed by Uwe Kleine-König.

Unfortunately, no Ack from him.

However, I have tested it myself (even unwantedly, when working on the 
work-tree sanitising, and it bit me again; I run 
"master"+branch--new-workdir ATM).

Junio, please apply...

Ciao,
Dscho

--8323584-1986573347-1185556712=:14781--
