From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Tue, 23 Oct 2007 11:58:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710231155321.25221@racer.site>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
 <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se>
 <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se>
 <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se>
 <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se>
 <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 23 12:59:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkHU5-0004zQ-SX
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 12:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbXJWK71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 06:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbXJWK71
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 06:59:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:59292 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751655AbXJWK70 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 06:59:26 -0400
Received: (qmail invoked by alias); 23 Oct 2007 10:59:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 23 Oct 2007 12:59:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ycAYdpicy4DxIw/uqkmZKG1gcCsZUyhI2bQZ3df
	wEomC/kca9yv0m
X-X-Sender: gene099@racer.site
In-Reply-To: <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62125>

Hi,

On Tue, 23 Oct 2007, Steffen Prohaska wrote:

> 
> On Oct 23, 2007, at 1:35 AM, Jakub Narebski wrote:
> 
> > 2. Git can do a merge with conflicts _only_ if that branch is checked 
> > out.
> 
> Andreas' proposal contains an important requirement that avoids this 
> problem. His proposal states "when they, prior to fetching, pointed to 
> the same commit [the head in remotes pointed to]". That is only 
> fast-forwards are needed, which never have merge conflicts.

You know what I do not like with this proposal?  The whole _point_ of this 
discussion is to make git _easier_.  Go ahead, try to explain to a 
complete git newbie the proposed behaviour.  I have a pound here which 
says that there is _no_ _way_ that this newbie says "well, that's easy".

Some people may not get this, but git has a reputation of being 
complicated, and my "BS" argument was, is, and will be, that we should 
keep clear and simple semantics, because they are the _only_ way to battle 
that reputation.

Ciao,
Dscho
