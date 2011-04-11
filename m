From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git rebase --continue automatic --skip?
Date: Mon, 11 Apr 2011 08:10:52 +0200
Message-ID: <20110411061052.GD30820@m62s10.vlinux.de>
References: <BANLkTi=Vc6kB5fvZrqMwDD+yHFb5qENQ8g@mail.gmail.com>
 <20110409000351.GA7445@sigill.intra.peff.net>
 <20110409130309.GC30820@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skillzero@gmail.com,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 11 08:11:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9AL3-0001Uf-Hc
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 08:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab1DKGK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 02:10:59 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:50413 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751315Ab1DKGK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 02:10:59 -0400
Received: (qmail invoked by alias); 11 Apr 2011 06:10:57 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp040) with SMTP; 11 Apr 2011 08:10:57 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19QR+I/xApQW0AAPKGxxscLxbzH8Y8hjWIbCA9gOn
	jc4pWfwnHYYMSf
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id E81C8D400C; Mon, 11 Apr 2011 08:10:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110409130309.GC30820@m62s10.vlinux.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171306>

On Sat, Apr 09, 2011 at 03:03:09PM +0200, Peter Baumann wrote:
> On Fri, Apr 08, 2011 at 08:03:51PM -0400, Jeff King wrote:
> > On Fri, Apr 08, 2011 at 01:30:01PM -0700, skillzero@gmail.com wrote:
> > 
> > > Is there a way to make git rebase --continue automatically do a --skip
> > > if a conflict resolution ends up not needing the patch? Normally, git
> > > rebase will just silently skip a patch if it's not needed, but if a
> > > patch results in a conflict and I use git mergetool and end up
> > > deleting all the changes, git rebase --continue stops and makes me
> > > explicitly use --skip.

[ ... patch left out ... ]

> > 
> > I put it in rebase and not straight into "git am", as I'm not sure that
> > "am" would want to share the same behavior. I'm not sure why we haven't
> > done this up until now. Maybe there is some corner case I'm not thinking
> > of where the user would want to do something besides skip when we hit
> > this situation. I dunno.
> > 
> 
> This was mentioned before on the list (sorry, don't have a reference, 
> but it was a long time ago). AFAIR the reason it wasn't implemented yet is that
> you will lose the commit message, which might contain precious information.
> But with reflogs this shouldn't be a problem anymore.
> 

I actually managed to find the thread I was remembering:

http://thread.gmane.org/gmane.comp.version-control.git/62854/focus=62907

-Peter
