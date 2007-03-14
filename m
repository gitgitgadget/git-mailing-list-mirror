From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 13:31:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703141329460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com> 
 <Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org> 
 <Pine.LNX.4.63.0703140216480.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0703131831390.9690@woody.linux-foundation.org> 
 <Pine.LNX.4.63.0703140237270.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0703140137i6d0df44aua9205e81249570ea@mail.gmail.com> 
 <Pine.LNX.4.63.0703141301210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0703140526p454ee85fk74dcd76fb684217c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 13:32:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRSe9-0005TS-2F
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 13:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbXCNMbv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 08:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbXCNMbv
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 08:31:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:41188 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161219AbXCNMbu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 08:31:50 -0400
Received: (qmail invoked by alias); 14 Mar 2007 12:31:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 14 Mar 2007 13:31:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pTH5DWGDpiLk1RqW0pomIyNSq2lJVhYp+6ulUGR
	Hw9kEfwueii2MT
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0703140526p454ee85fk74dcd76fb684217c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42205>

Hi,

On Wed, 14 Mar 2007, Alex Riesen wrote:

> We have "PAGER=cat" in test-lib.sh which just disables pager, so gits 
> tests do not have the problem (maybe it was disabled just because of 
> this?).

I don't know if it was disabled just because of this, but I guess that it 
was to prevent interactive tests from stopping with the output of _every_ 
_single_ test until the user quits the pager.

> And if someone has own tests _with_ pager active the one better be aware 
> of what the one doing.

No. This is wrong. The whole purpose of the patch you sent is to meet 
expectations. What you just wrote flies in the face of that.

Ciao,
Dscho
