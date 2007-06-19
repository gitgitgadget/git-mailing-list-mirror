From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 14:57:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706191456350.4059@racer.site>
References: <18039.52754.563688.907038@lisa.zopyra.com>
 <Pine.LNX.4.64.0706191359160.4059@racer.site> <18039.57290.14570.879740@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 15:57:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0eDH-0005AP-5b
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 15:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbXFSN5l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 09:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbXFSN5l
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 09:57:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:55449 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751438AbXFSN5k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 09:57:40 -0400
Received: (qmail invoked by alias); 19 Jun 2007 13:57:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 19 Jun 2007 15:57:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qpWQ/WVRqSe3NOEJdmkes/jlDUXuvNH6E45nexA
	Z/OcIzQDpcJT+t
X-X-Sender: gene099@racer.site
In-Reply-To: <18039.57290.14570.879740@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50483>

Hi,

On Tue, 19 Jun 2007, Bill Lear wrote:

> On Tuesday, June 19, 2007 at 14:00:07 (+0100) Johannes Schindelin writes:
> >
> >You are missing libiconv.
> 
> Hmm, don't think so:
> 
> % ls -l /usr/local/lib/libiconv*
> -rw-r--r-- 1 root root     789 May 14 13:31 /usr/local/lib/libiconv.la

But you do! Unless you say that gcc should also look in /usr/local/lib for 
libraries.

Ciao,
Dscho
