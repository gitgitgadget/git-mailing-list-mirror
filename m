From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-relink doesn't work on bare repos
Date: Tue, 4 Mar 2008 15:03:15 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041501500.22527@racer.site>
References: <slrnfsp5vi.sa5.jgoerzen@katherina.lan.complete.org> <BAYC1-PASMTP07875E628BE4BA7D43175FAE100@CEZ.ICE> <200803040834.14099.jgoerzen@complete.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 16:06:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWYh8-0000JU-O2
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 16:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768AbYCDPEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 10:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757241AbYCDPEE
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 10:04:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:35543 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755768AbYCDPED (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 10:04:03 -0500
Received: (qmail invoked by alias); 04 Mar 2008 15:04:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 04 Mar 2008 16:04:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ur2hj9LYuA/lrNgcdUKl+fzLeMzVe4mPleLZ8bL
	NWrmHBB65n4KaR
X-X-Sender: gene099@racer.site
In-Reply-To: <200803040834.14099.jgoerzen@complete.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76095>

Hi,

On Tue, 4 Mar 2008, John Goerzen wrote:

> On Tue March 4 2008 1:09:59 am Sean wrote:
> 
> > repos follow the general naming convention of ending in .git relink 
> > will work.  That is, if your bare repos are named repo.git rather than 
> > just repo.
> 
> I never do that because I think it's silly to have to type .git 
> everytime ;-)

Well, it is a convention, and if you choose not to follow it, that's what 
you get.

> If I give people a git:// url, they already know it's a Git repo, I 
> figure.

So you must use "--git-dir" _everytime_ you are working with Git inside 
the repo.

It's not like relink has to be performed several times per hour.

Ciao,
Dscho

