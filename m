From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: splitting large patch files into smaller ones
Date: Thu, 23 Aug 2007 10:43:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708231042120.20400@racer.site>
References: <200708221929.l7MJTgiL012452@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Erez Zadok <ezk@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Aug 23 11:44:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO9Ea-0001Yl-D1
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 11:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761560AbXHWJoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 05:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761636AbXHWJoH
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 05:44:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:48891 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761560AbXHWJoF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 05:44:05 -0400
Received: (qmail invoked by alias); 23 Aug 2007 09:44:03 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp041) with SMTP; 23 Aug 2007 11:44:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Y/pdHXkrYbuqZBiz00Dob+sA2gXxr+OKofmfUMA
	ueEzDRN21uz4s9
X-X-Sender: gene099@racer.site
In-Reply-To: <200708221929.l7MJTgiL012452@agora.fsl.cs.sunysb.edu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56485>

Hi,

On Wed, 22 Aug 2007, Erez Zadok wrote:

> I was looking around for a tool that would allow me to split a large 
> patch file into individual snippets and couldn't find one.  So I wrote 
> one in perl.  It takes a patch file and creates individual small files, 
> one for each combination of a filename listed in the patch, and a patch 
> snippet (starting with an '@@' line).  Each '@@' snippet gets an index 
> number and a new filename, prefixed with the appropriate header ("diff 
> ...", ---, and +++ lines) so it's a valid patch file on its own.

You can do that with "git add -i" and with "git gui" AFAIK.  I even 
started some code to split hunks in "git gui", but it was pointed out that 
that code was not complete, and I did not have time to finish it.

Ciao,
Dscho
