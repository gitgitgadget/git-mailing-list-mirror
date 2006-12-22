From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Fri, 22 Dec 2006 20:25:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612222023400.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612220318320.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm9g7duz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 20:25:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxq11-0000z3-V4
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 20:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbWLVTZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 14:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbWLVTZE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 14:25:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:37608 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752302AbWLVTZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 14:25:03 -0500
Received: (qmail invoked by alias); 22 Dec 2006 19:25:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 22 Dec 2006 20:25:01 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzm9g7duz.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35198>

Hi,

On Thu, 21 Dec 2006, Junio C Hamano wrote:

> (2) What does this do when the index is unmerged?

	$ git show :
	a1: unmerged (f16f906ab60483c100d1241dfc39868de9ec9fcb)
	a1: unmerged (cf84443e49e1b366fac938711ddf4be2d4d1d9e9)
	a1: unmerged (fd7923529855d0b274795ae3349c5e0438333979)
	fatal: ambiguous argument ':': unknown revision or path not in the 
	working tree. Use '--' to separate paths from revisions

We could be a bit nicer, but I think the first three lines speak for 
themselves. This is all stderr BTW.

Ciao,
Dscho
