From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0 of 7] [resend] - Improve handling remotes, origin,
 submodules
Date: Mon, 4 Feb 2008 14:48:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041443420.7372@racer.site>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com> <alpine.LSU.1.00.0802032237320.7372@racer.site> <47A68C01.9000600@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 15:49:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM2dV-0004E1-3A
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 15:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016AbYBDOsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 09:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbYBDOsy
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 09:48:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:59421 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756016AbYBDOsx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 09:48:53 -0500
Received: (qmail invoked by alias); 04 Feb 2008 14:48:51 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp054) with SMTP; 04 Feb 2008 15:48:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//xzY+Dtr/B8QyY8ceSOrwZG63Cxulw76VTN2mmr
	81k5gP5uj5rrf1
X-X-Sender: gene099@racer.site
In-Reply-To: <47A68C01.9000600@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72509>

Hi,

On Sun, 3 Feb 2008, Mark Levedahl wrote:

> Johannes Schindelin wrote:
> 
> > As far as I understood, your problem was _purely_ a submodule issue.  
> > I find it utterly unnerving that you keep trying to sneak in 
> > _anything_ unrelated to submodules.
>
> It is not purely about submodules, but in fact about a centralized 
> concept (named "origin") disrupting a distributed workflow using 
> submodules in a distributed version control system.

The "origin" concept has nothing to do with a centralised concept.  It is 
there _purely_ for convenience.  If you want to fetch/pull from somewhere, 
you _have_ to specify from where, _except_ if you use the default.

So your argument here is absolutely bogus.

> > I am getting pretty angry that you keep trying to complicating things 
> > in that area!
>
> It is easy to substitute emotion for sound technical arguments. Please 
> don't, it helps no one.

I take it very personal if you ignore me and my arguments, so please 
don't.  My apologies for answering emotionally.  (I could even say that it 
is easier to ignore sound technical arguments than to substitute emotion 
for them.)

My recommendation: fix submodule, and submodule only.  For your specific 
needs.  Hint: you do not need to introduce core.origin for that (as 
should have become totally obvious by now).

Should something like core.origin still be an issue (which I doubt, for 
the same reason you do not change the _name_ of the environment variable 
$HOME), we can still continue discussing that.

Hth,
Dscho
