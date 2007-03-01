From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 21:43:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703012140370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070228151516.GC57456@codelabs.ru> <200703011831.29321.andyparkins@gmail.com>
 <Pine.LNX.4.63.0703011941020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200703011931.32170.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Eygene Ryabinkin <rea-git@codelabs.ru>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 21:43:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMs7Y-0006GZ-0b
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 21:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbXCAUnV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 15:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbXCAUnV
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 15:43:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:48327 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030231AbXCAUnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 15:43:20 -0500
Received: (qmail invoked by alias); 01 Mar 2007 20:43:18 -0000
X-Provags-ID: V01U2FsdGVkX18Ptao0fbQPpZuyHMZgpHtuAsoVv/VNW9aJlek4b0
	QLDN0md9eTR+u1
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200703011931.32170.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41125>

Hi,

On Thu, 1 Mar 2007, Andy Parkins wrote:

> Putting $Id$ $Rev$ in a git managed file would have far more meaning 
> that it does in a CVS managed file.

No. My point was that you do not even have to have an id. The hash of the 
object is the id.

This is obviously much better than the mess of CVS/SVN's file ids. There 
is an option, even, to switch off key expansion, so you can have erroneous 
ids. That just cannot happen with hashes.

Of course, it does not give you any hint about when this file was current. 
But there is no way to tell in distributed development _anyway_. You have 
to look it up, when, and who, changed the file to the current state.

Ciao,
Dscho
