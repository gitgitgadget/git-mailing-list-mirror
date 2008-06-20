From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] rebase-i: slight internal improvements
Date: Fri, 20 Jun 2008 13:46:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806201344180.6439@racer>
References: <1213929935-15093-1-git-send-email-s-beyer@gmx.net> <1213929935-15093-2-git-send-email-s-beyer@gmx.net> <1213929935-15093-3-git-send-email-s-beyer@gmx.net> <485B595B.80608@viscovery.net> <20080620080153.GC7369@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 14:49:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9g34-00058z-Lv
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 14:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbYFTMsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 08:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbYFTMsG
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 08:48:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:49289 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752889AbYFTMsF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 08:48:05 -0400
Received: (qmail invoked by alias); 20 Jun 2008 12:48:03 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp049) with SMTP; 20 Jun 2008 14:48:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uRrcz/nDuKs2kiI7I8Y7NouEirHDWSS8Tx/w6Br
	eNwDjmz5Vsryil
X-X-Sender: gene099@racer
In-Reply-To: <20080620080153.GC7369@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85631>

Hi,

On Fri, 20 Jun 2008, Stephan Beyer wrote:

> Looks like *portable* shell programming is no fun :\

That is right.  That's one of the reasons why I prefer moving scripts to 
builtins: prototyping is good and well, but when you need to put it into 
production, where people have all kinds of weird setups (just think of 
dash in Ubuntu!), it is no fun.

Better to use something portable, such as C.

Which is the whole point of your project, right?  You want to turn the 
real engine into a builtin.

So would you not agree that PATCH 2/3 is rather unnecessary?

Ciao,
Dscho
