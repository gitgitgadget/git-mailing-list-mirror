From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Make cherry-pick use rerere for conflict
 resolution.
Date: Mon, 11 Aug 2008 12:19:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808111218160.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1218368935-31124-1-git-send-email-ams@toroid.org> <alpine.DEB.1.00.0808110111430.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080811023053.GA9144@toroid.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 12:16:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSURj-0005Gv-E2
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 12:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbYHKKPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 06:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbYHKKPN
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 06:15:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:51906 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751108AbYHKKPM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 06:15:12 -0400
Received: (qmail invoked by alias); 11 Aug 2008 10:15:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 11 Aug 2008 12:15:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19E0HsPZRVE8GV/gf+I0aLY43kCKJRTjM2jGgR2Pl
	1miNt+ViNCvhSQ
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080811023053.GA9144@toroid.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91926>

Hi,

On Mon, 11 Aug 2008, Abhijit Menon-Sen wrote:

> It was a dark and stormy night. Sam struggled to keep his eyelids open
> as he integrated yet another gigantic patch series. Ever the optimist,
> he'd pulled in the changes, only to discover several merge conflicts.
> But the night was young then, and he'd fixed them all by hand.
> 
> It was only later that he noticed many lousy, one-line commit messages.
> Undaunted, he reset his branch and began to cherry-pick patches, giving
> them a once-over, writing a comment here, squashing the odd grotesque
> hack there, and writing sensible commit messages more often than not.
> 
> But even that was hours ago, and each new but oh-so-familiar conflict
> ate into his determination like maggots through decaying meat; and Sam
> was beginning to question the wisdom of staying in this fruit business.
> His whiskey was running low, and time was running out.
> 
> "If only", thought Sam, "If only cherry-pick would..."

Nice try.

I have tried the whole dark and lonely night to find where in the git.git 
history we have some equally enlightening commit message.

So in essence, it is nice what you wrote, but not a commit message.  
Please imitate the style of existing commit messages, especially if you 
want to have your patch applied.

Ciao,
Dscho
