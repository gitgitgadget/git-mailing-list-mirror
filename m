From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 14:00:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706191359160.4059@racer.site>
References: <18039.52754.563688.907038@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 15:00:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0dJi-000087-Bz
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 15:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbXFSNAR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 09:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754987AbXFSNAR
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 09:00:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:44145 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751027AbXFSNAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 09:00:16 -0400
Received: (qmail invoked by alias); 19 Jun 2007 13:00:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 19 Jun 2007 15:00:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bkfZBVaHbrcV1iE3iJbk3iovBObxWqlPnK6oBH2
	x6xuwFYUiWqrQE
X-X-Sender: gene099@racer.site
In-Reply-To: <18039.52754.563688.907038@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50478>

Hi,

On Tue, 19 Jun 2007, Bill Lear wrote:

> Also breaks (tar fails) if I do the 'make configure; ./configure'
> route.

Then there is a test missing in configure.

> /home/blear/build/git-1.5.2.2/utf8.c:328: undefined reference to `libiconv'

You are missing libiconv.

Ciao,
Dscho
