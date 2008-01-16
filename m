From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 17:52:53 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801161752360.17650@racer.site>
References: <478D79BD.7060006@talkingspider.com> <vpq4pdeum3v.fsf@bauges.imag.fr> <alpine.LSU.1.00.0801161035380.17650@racer.site> <18317.60797.644829.539598@lisa.zopyra.com> <vpq4pderm7k.fsf@bauges.imag.fr> <alpine.LSU.1.00.0801161244390.17650@racer.site>
 <7vd4s1sm7y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Bill Lear <rael@zopyra.com>,
	Mike <fromlists@talkingspider.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:53:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFCS5-0004FL-Sk
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 18:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbYAPRw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 12:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbYAPRw6
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 12:52:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:38941 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751270AbYAPRw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 12:52:57 -0500
Received: (qmail invoked by alias); 16 Jan 2008 17:52:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 16 Jan 2008 18:52:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8zp43AvT8pgN3shcqMR3QIOvNfImjEy49o6OAUJ
	xbisbIUnTTNpph
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4s1sm7y.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70709>

Hi,

On Wed, 16 Jan 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Yes, so you can use
> >> 
> >> $ git --work-tree . --git-dir /some/other/place <some-command>
> >> 
> >> But it's far from the user-friendlyness of a real lightweight 
> >> checkout: you need to provide the --work-tree and --git-dir options 
> >> each time you run git. And making an alias or using the environment 
> >> variables are not really an option if you have more than one 
> >> repository or working tree to deal with.
> >
> > Well, the OP said he did not want _any_ file in the worktree.  So 
> > there's no way around specifying by hand everytime where the git 
> > directory should be.
> 
> Export GIT_DIR and GIT_WORKTREE and you are free to go, right?

Yep.

Ciao,
Dscho
