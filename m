From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 11:54:39 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801161113170.17650@racer.site>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 12:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF6rQ-0005Ln-Uc
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 12:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbYAPLyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 06:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbYAPLyn
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 06:54:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:40094 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751481AbYAPLyn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 06:54:43 -0500
Received: (qmail invoked by alias); 16 Jan 2008 11:54:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 16 Jan 2008 12:54:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6jc03FO/6aVWfIFQct/xv51ibW6wbps9bGPHS1A
	2IEbE2HZhsSrCW
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70655>

Hi,

On Wed, 16 Jan 2008, Petko Manolov wrote:

> Some of my projects require having binary files (firmware and other 
> stuff) somewhere in the tree structure.  Unfortunately these files are 
> big - 50MB and more.  After a couple of new versions arrive (and get 
> committed) i end up with a repository way too big than necessary.
> 
> The nature of these binary files is such that i don't care neither about 
> their history nor older versions.  Hence the question:  is there an easy 
> way to tell git not to bother about the history of these particular 
> files and keep the most recent version only?

Your subject is a little bit misleading, no?  It's not about the 
binariness (git handles binary files just fine, thankyouverymuch), but 
about the not-tracking them.

The answer is no.  You cannot ask git to have the newest version of 
something, but not the old ones.  It contradicts the distributedness of 
git, too.

Hth,
Dscho
