From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Handle core.symlinks=false case in merge-recursive.
Date: Sat, 3 Mar 2007 21:44:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703032143350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200703032032.47158.johannes.sixt@telecom.at>
 <Pine.LNX.4.63.0703032110200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200703032139.12869.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Mar 03 21:44:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNb5Z-0007t4-8p
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 21:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbXCCUoS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 15:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbXCCUoS
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 15:44:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:35377 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932334AbXCCUoS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 15:44:18 -0500
Received: (qmail invoked by alias); 03 Mar 2007 20:44:16 -0000
X-Provags-ID: V01U2FsdGVkX18dnhIwf7QdSiAyUmCjBT4IHjrW9RNCTG70k4pQDn
	ncpBUHHYQr6lX3
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200703032139.12869.johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41325>

Hi,

On Sat, 3 Mar 2007, Johannes Sixt wrote:

> On Saturday 03 March 2007 21:11, Johannes Schindelin wrote:
> > I think regardless of the value of core.symlinks, merging symbolic 
> > links does not make sense at all.
> 
> No doubt about that. Currently, the version of the "current" branch 
> remains in the working tree. My patch does not change this behavior at 
> all, it just does not call symlink(2), but allocates a regular file.

Oh, I misunderstood! All is well, then. (I had the impression you put 
conflict markers into the file.)

Ciao,
Dscho
