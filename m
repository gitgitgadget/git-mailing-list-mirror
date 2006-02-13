From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 04:39:38 -0500
Message-ID: <20060213093938.GC11053@mythryan2.michonline.com>
References: <20060213002502.5c23122c.akpm@osdl.org> <7virrj1v44.fsf@assigned-by-dhcp.cox.net> <20060213013205.4ba47836.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 10:41:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8aCl-0000P8-FF
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 10:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWBMJk2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 04:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbWBMJk2
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 04:40:28 -0500
Received: from mail.autoweb.net ([198.172.237.26]:458 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751257AbWBMJkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 04:40:25 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F8aBx-0002oS-Gb; Mon, 13 Feb 2006 04:40:22 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F8aBv-0003iz-Ve; Mon, 13 Feb 2006 04:40:21 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1F8aBb-0004Dt-38; Mon, 13 Feb 2006 04:39:59 -0500
To: Andrew Morton <akpm@osdl.org>
Content-Disposition: inline
In-Reply-To: <20060213013205.4ba47836.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Spam-Score: -4.4
X-Spam-Report: Spam detection software, running on the system "h4x0r5.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Mon, Feb 13, 2006 at 01:32:05AM -0800, Andrew Morton
	wrote: > Junio C Hamano <junkio@cox.net> wrote: > > > > As humans, we
	can tell that it is not very plausible that the > > EXTRAVERSION change
	caused whatever breakage you are chasing, > > but sorry, from your log,
	I think bisect is doing the right > > thing. > > I don't think humans
	are well-suited to using git. > > My current theory is that I was
	bisecting Linus's tree all along. > > What is the correct way in which
	to switch to git-netdev-all in preparation > for performing the
	bisection? [...] 
	Content analysis details:   (-4.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16059>

On Mon, Feb 13, 2006 at 01:32:05AM -0800, Andrew Morton wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> >
> > As humans, we can tell that it is not very plausible that the
> >  EXTRAVERSION change caused whatever breakage you are chasing,
> >  but sorry, from your log, I think bisect is doing the right
> >  thing.
> 
> I don't think humans are well-suited to using git.
> 
> My current theory is that I was bisecting Linus's tree all along.
> 
> What is the correct way in which to switch to git-netdev-all in preparation
> for performing the bisection?

First, use "git branch" to show you what branches exist, the * will mark
the current one.

Then "git checkout $branch" to switch to one that exists, or "git
checkout -b $newbranch $sourcebranch" to create a new branch starting
from $sourcebranch (which can also be a random commit/tag/etc).

-- 

Ryan Anderson
  sometimes Pug Majere
