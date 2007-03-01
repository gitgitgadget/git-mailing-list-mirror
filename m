From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 19:41:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703011941020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070228151516.GC57456@codelabs.ru> <20070301120042.GD63606@codelabs.ru>
 <Pine.LNX.4.63.0703011802130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200703011831.29321.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Eygene Ryabinkin <rea-git@codelabs.ru>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 19:41:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMqE1-0003kP-KR
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 19:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965502AbXCASlk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 13:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965504AbXCASlj
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 13:41:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:37146 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965502AbXCASlj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 13:41:39 -0500
Received: (qmail invoked by alias); 01 Mar 2007 18:41:37 -0000
X-Provags-ID: V01U2FsdGVkX18YP/1qdN4YI8Nxp7JP6F0PfhMbqxZL3pvjnVZT1L
	AGpH4u7hnv4PEf
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200703011831.29321.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41116>

Hi,

On Thu, 1 Mar 2007, Andy Parkins wrote:

> On Thursday 2007, March 01, Johannes Schindelin wrote:
> 
> > The problem is: Git does not track files, but rather trees. So, there
> > is no sane way to add an Id.
> 
> > If the file is too big, your colleague can run it herself and send
> > you the object name (it is a 40 character hex string, but the first 8
> > or so should really be sufficient).
> 
> So when you say "there is no sane way to add an Id", you meant "here is 
> a perfect string that would act as an Id"?  ;-)

Got it.

So, in a very real sense, we have file ids. Even tree ids. And commit ids.

Ciao,
Dscho
