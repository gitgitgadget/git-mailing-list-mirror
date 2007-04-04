From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 4 Apr 2007 18:22:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0704041819340.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200704041414.14797.andyparkins@gmail.com> <4613A974.60808@dawes.za.net>
 <200704041540.59977.andyparkins@gmail.com> <4613C97C.9050600@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 18:22:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ8FX-0005iQ-UM
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 18:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbXDDQWR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 12:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbXDDQWR
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 12:22:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:42914 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753561AbXDDQWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 12:22:16 -0400
Received: (qmail invoked by alias); 04 Apr 2007 16:22:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 04 Apr 2007 18:22:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18q2bIsjWAqqSFoTovhdN+BzUNKQtXzA43/k5V6Fw
	yjzVaPWE7ugxLy
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <4613C97C.9050600@dawes.za.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43752>

Hi,

On Wed, 4 Apr 2007, Rogan Dawes wrote:

> Andy Parkins wrote:
>
> > As an example: compress a file, change a byte, compress it again, 
> > perform a binary diff; what is that diff telling you about the change?  
> > (My answer is: not much).
> 
> Well, at least as much as the resulting sizes tell you, if not more.

The subtle difference: your approach is _expensive_ in terms of CPU time, 
while the byte change approach is _dirt cheap_.

Since it seems that there are gazillions of examples where one or the 
other (or both) do not make sense, I'd rather have the fast one.

HOWEVER, there is something I really would like to have, namely a clear 
distinction between new file / deleted file, and 0->n / n->0 changes.

Ciao,
Dscho
