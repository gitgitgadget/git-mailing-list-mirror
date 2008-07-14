From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [git pull] core/softirq for v2.6.27
Date: Mon, 14 Jul 2008 18:46:15 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807141844160.8950@racer>
References: <20080714144243.GA21079@elte.hu> <20080714092215.0efd7fa3.akpm@linux-foundation.org> <20080714163141.GA21068@elte.hu> <20080714094422.e7ae255a.akpm@linux-foundation.org> <alpine.LFD.1.10.0807140948220.3305@woody.linux-foundation.org>
 <alpine.LFD.1.10.0807141019010.3305@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ingo Molnar <mingo@elte.hu>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 19:47:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIS8s-0004u5-AN
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 19:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbYGNRqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 13:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYGNRqR
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 13:46:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:42445 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753626AbYGNRqR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 13:46:17 -0400
Received: (qmail invoked by alias); 14 Jul 2008 17:46:15 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp063) with SMTP; 14 Jul 2008 19:46:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Wjd9GMj+W5Y2wrzaP19Uf7MxI6jtBe13ABY+gl6
	MI94llMnCdmUhl
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LFD.1.10.0807141019010.3305@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88438>

Hi,

On Mon, 14 Jul 2008, Linus Torvalds wrote:

> 	git log --pretty='format:commit %H
> 	Author: %an <%ae>
> 	
> 	  %s (%h)
> 	' $@ | git shortlog

Surely you meant

 	git log --pretty='format:commit %H%nAuthor: %an <%ae>%n%n    %s (%h)' \
		$@ | git shortlog

Note that I do not think it would be all that hard to teach shortlog the 
--pretty option.

Ciao,
Dscho
