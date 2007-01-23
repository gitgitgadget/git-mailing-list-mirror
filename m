From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 18:07:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231805100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at>
 <200701231506.32396.andyparkins@gmail.com>
 <Pine.LNX.4.63.0701231614490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701231624.41716.andyparkins@gmail.com>
 <Pine.LNX.4.63.0701231732120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0701230852270.32200@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 18:08:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9P7t-0004PA-Dc
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 18:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095AbXAWRIB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 12:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933097AbXAWRIB
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 12:08:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:42693 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933095AbXAWRIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 12:08:00 -0500
Received: (qmail invoked by alias); 23 Jan 2007 17:07:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 23 Jan 2007 18:07:51 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0701230852270.32200@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37552>

Hi,

On Tue, 23 Jan 2007, Linus Torvalds wrote:

> On Tue, 23 Jan 2007, Johannes Schindelin wrote:
> > 
> > Yes. But it _does_ have a dependency on perl and bash. For example, when 
> > you merge git-merge-one-file is spawned -- a bash script.
> 
> That's just disgusting. I thought we fixed it, but apparently we only did 
> so for git-merge-recursive. Hmm?
> 
> All the other uses seem to be just a case of
> 
> 	git-merge-index -o git-merge-one-file -a
> 
> and wouldn't it be beautiful if the default action for git-merge-index (if 
> you do _not_ specify a merger program) was to do the simple one-file 
> three-way merge that we can already do for real merges?

If you think that's a new dream:

http://article.gmane.org/gmane.comp.version-control.git/32046/match=git-merge-one-file

Ciao,
Dscho
