From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH 1/5] Introduces for_each_revision() helper
Date: Sun, 29 Apr 2007 10:04:33 -0300
Organization: Mandriva
Message-ID: <20070429100433.414bae15@gnut>
References: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
	<1177693212202-git-send-email-lcapitulino@mandriva.com.br>
	<Pine.LNX.4.64.0704280446180.12006@racer.site>
	<20070428115059.GA4888@steel.home>
	<20070428130201.27630ed4@gnut>
	<20070428164836.GA6646@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, junkio@cox.net,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 15:04:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi958-0008LC-G0
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 15:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbXD2NEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 09:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268AbXD2NEr
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 09:04:47 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:48823 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbXD2NEq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 09:04:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 0AA5518677;
	Sun, 29 Apr 2007 10:04:45 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id i7stTRc73xB1; Sun, 29 Apr 2007 10:04:40 -0300 (BRT)
Received: from gnut (unknown [189.4.50.224])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 5ACFB1866E;
	Sun, 29 Apr 2007 10:04:39 -0300 (BRT)
In-Reply-To: <20070428164836.GA6646@steel.home>
X-Mailer: Claws Mail 2.7.2 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45824>

Em Sat, 28 Apr 2007 18:48:36 +0200
Alex Riesen <raa.lkml@gmail.com> escreveu:

| Luiz Fernando N. Capitulino, Sat, Apr 28, 2007 18:02:01 +0200:
| > > Look at what list_for_each_* macros did to the source of Linux kernel.
| > 
| > BTW, I was considering using Linux kernel's linked list
| > implementation in git, since we have some linked lists around.
| 
| Do you have some definite place in mind? It's just that the kernel
| lists where intentionally kept very simple, so the list
| implementations in git probably are as close to the kernel's as it
| sanely possible, at which point bringing them in wont change much.

 The ones I've looked at, looks like any other linked list I've
seen in other (not badly written) programs out there.

| > But I think people won't like it.
| 
| It depends on what you change and how you do it. Show us

 Yeah, I want to port some of them to see whether it's
worth doing.

 I've ported the list.h already:

http://repo.or.cz/w/git/libgit-gsoc.git?a=commit;h=e389611fc24843d465ef150b361f5b200068e507
