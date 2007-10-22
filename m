From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Mon, 22 Oct 2007 16:00:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221558230.25221@racer.site>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> 
 <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>
  <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
 <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se>
 <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se>
 <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se>
 <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 22 17:01:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjymC-0007Se-ML
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 17:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbXJVPA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 11:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbXJVPA5
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 11:00:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:49157 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750956AbXJVPA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 11:00:56 -0400
Received: (qmail invoked by alias); 22 Oct 2007 15:00:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 22 Oct 2007 17:00:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SFVVavWFSaS9Y4KM2+HHPADou3pyW1Uzj97b/qo
	Kq/IYXq9/C0dvU
X-X-Sender: gene099@racer.site
In-Reply-To: <471CB443.9070606@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62018>

Hi,

On Mon, 22 Oct 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> > On Mon, 22 Oct 2007, Andreas Ericsson wrote:
> > 
> > > If I were to suggest any improvements, it'd be to change the 
> > > semantics of git-pull to always update the local branches set up to 
> > > be merged with the remote tracking branches when they, prior to 
> > > fetching, pointed to the same commit, such that when
> > > 
> > > $ git show-ref master
> > > d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/heads/master
> > > d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/remotes/origin/master
> > > 
> > > refs/heads/master gets set to refs/remotes/origin/master post-fetch.
> > 
> > In general, this should fail.  Because you are expected to have local 
> > changes in the local branches.
> 
> 
> BS argument.

Aha.  So you want to make sure that the local branches are no longer 
"purely" local.  And you want to stop updating them when unpushed changes 
are in the local branches.

Seems I cannot help you.

Ciao,
Dscho
