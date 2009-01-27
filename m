From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Windows: Fix intermittent failures of t7701
Date: Tue, 27 Jan 2009 17:42:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271740320.3586@pacific.mpi-cbg.de>
References: <497F076F.8060509@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 17:43:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRr20-00063p-7o
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 17:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbZA0Qlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 11:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbZA0Qly
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 11:41:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:60190 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753016AbZA0Qly (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 11:41:54 -0500
Received: (qmail invoked by alias); 27 Jan 2009 16:41:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 27 Jan 2009 17:41:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+p3SMa5r2phaWHiqh2GCirGKzOdTNWsWQcOwv8iO
	dQB4QNcvCyRlZB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <497F076F.8060509@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107360>

Hi,

On Tue, 27 Jan 2009, Johannes Sixt wrote:

> We want to catch failures of test-chmtime; but since it appears in a 
> pipe, we cannot access its exit code. Therefore, we at least make sure 
> that it prints time stamps of all files that are passed on its command 
> line.

I use this trick in my valgrind series:

	($PROGRAM; echo $? > exit.code) | $OTHER_PROGRAM &&
	test 0 = "$(cat exit.code)"

Ciao,
Dscho
