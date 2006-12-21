From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: specify charset for commits (Was: [PATCH] Fix documentation
 copy&paste typo)
Date: Thu, 21 Dec 2006 10:51:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
 <20061219141618.GA2539@cepheus> <7vac1jre1u.fsf@assigned-by-dhcp.cox.net>
 <20061221085907.GA2244@cepheus>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-393969666-1166694704=:19693"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 10:51:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxKac-0000zr-Or
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 10:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422908AbWLUJvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 04:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422920AbWLUJvr
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 04:51:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:44277 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422908AbWLUJvq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 04:51:46 -0500
Received: (qmail invoked by alias); 21 Dec 2006 09:51:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 21 Dec 2006 10:51:44 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20061221085907.GA2244@cepheus>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35044>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-393969666-1166694704=:19693
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 21 Dec 2006, Uwe Kleine-König wrote:

> Junio C Hamano wrote:
> > Me, keyboard and Emacs screwed up and stored it in ISO-2022
> > instead of UTF-8.  Sorry.
> It's a pity, but too late to change.[1]
> 
> What do you think about a patch that makes git-commit-tree call iconv on
> its input to get it to UTF-8 (or any other charset).

We had this discussion over and over again. Last time (I think) was here:

http://article.gmane.org/gmane.comp.version-control.git/11710

Summary: we do not want to force the use of utf8.

Hth,
Dscho
---1148973799-393969666-1166694704=:19693--
