From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Replace rebase with filtering
Date: Tue, 16 Jan 2007 23:57:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701162357270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45AC3B5D.6080700@midwinter.com>
 <Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45AD2568.4040408@midwinter.com> <45AD2AE7.2010908@midwinter.com>
 <Pine.LNX.4.63.0701162131130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45AD383E.50105@midwinter.com> <Pine.LNX.4.63.0701162218070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <eojh8r$9e6$1@sea.gmane.org> <2696299C-A54D-4A7E-BA3B-029C8E4B278D@silverinsanity.com>
 <Pine.LNX.4.63.0701162350150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwt3mwpll.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 23:57:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6xFO-0006Xm-J4
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 23:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbXAPW5k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 17:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbXAPW5k
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 17:57:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:41899 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751419AbXAPW5j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 17:57:39 -0500
Received: (qmail invoked by alias); 16 Jan 2007 22:57:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 16 Jan 2007 23:57:38 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt3mwpll.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36980>

Hi,

On Tue, 16 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I'd put a simple patch to add the reset to git-merge.sh, but I'm not sure I
> >> understand what --skip is doing in there with a 30 second peek.
> >
> > Better put "git reset --hard" into git-rebase.sh... Just search for 
> > "--skip" and you will find where it has to go.
> 
> I'd later want to allow starting rebase from a dirty working
> tree as long as the rebasing of the entire series would not
> conflict with the local changes, so I would seriously prefer a
> solution without "reset --hard".

Fair enough.

Ciao,
Dscho
