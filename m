From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should 'git config' support key with dot such as 'a.b'
Date: Fri, 14 Mar 2008 11:39:40 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803141138340.24600@racer.site>
References: <46dff0320803140124t1469defsf7002f720cf2002e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 11:40:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja7Kk-0007bu-Gw
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 11:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbYCNKjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 06:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbYCNKjj
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 06:39:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:51537 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752670AbYCNKjj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 06:39:39 -0400
Received: (qmail invoked by alias); 14 Mar 2008 10:39:37 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp010) with SMTP; 14 Mar 2008 11:39:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/Jp4VnAE/PnyEzGjjI6pEwCJtb+ngtxRrezIVDT
	NUOfy9JE39sZS3
X-X-Sender: gene099@racer.site
In-Reply-To: <46dff0320803140124t1469defsf7002f720cf2002e@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77203>

Hi,

On Fri, 14 Mar 2008, Ping Yin wrote:

> I find it is so annoying to write submodule definition as follows
> (yeah, only url, without path)
> 
> ------------------------------
> [submodule 'crawler']
>     url = url1
> [submodule 'search']
>     url = url2
> ------------------------------
> 
> I think the following form is more simple
> ---------------------------------
> [submodule]
>      crawler.url = url1
>      search.url = url2
> ---------------------------------
> 
> So, could we support such simpler form?

I don't like it at all.  Historically, we had much stricter rules on the 
variable names than the second part of the section names.

Also, your suggestion would make things even more confusing than beginners 
already complain Git is.

Ciao,
Dscho
