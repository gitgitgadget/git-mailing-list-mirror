From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 13:26:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711261325440.27959@racer.site>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
 <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 26 14:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwdzY-0001pP-1C
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 14:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbXKZN05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 08:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752862AbXKZN04
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 08:26:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:56665 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752855AbXKZN04 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 08:26:56 -0500
Received: (qmail invoked by alias); 26 Nov 2007 13:26:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 26 Nov 2007 14:26:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aNaMnlbwabcj7S8wetCLtDZ6wv2EyiBWTL0qRLu
	G/RIHE3hx6mOnw
X-X-Sender: gene099@racer.site
In-Reply-To: <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66072>

Hi,

On Mon, 26 Nov 2007, Benoit Sigoure wrote:

> On Nov 26, 2007, at 10:02 AM, Wincent Colaiuta wrote:
> 
> > In using "git-rebase --interactive" to re-order commits you occasionally get
> > conflicts and will see a message like this:
> > 
> > 	When commiting, use the option '-c %s' to retain authorship and
> > message
> > 
> > I was thinking that it might be nice to stash away this commit id somewhere
> > in GIT_DIR so that the user didn't have to explicitly remember it, and add a
> > new switch to git-commit that could be used to automatically use that
> > stashed commit id, something like:
> > 
> > 	git commit --retain
> > 
> > Although I most often see this kind of message in interactive rebasing, the
> > message is generated in builtin-revert.c when cherry-picking, so you can
> > also see it in any other situation where you're cherry picking and there's a
> > conflict.
> > 
> > What do people think? Would this be a nice usability improvement? Or is it
> > adding clutter?
> 
> 
> I'm not sure but I think this message is just some unwanted (misleading)
> noise, since when you rebase, once you solve the conflicts, you git-rebase
> --continue, you don't git-commit.

Yep.  It is on my TODO list since a long time, but I am just as glad 
somebody else is doing it.  But I have to agree with Hannes that using an 
environment variable is cleaner, more elegant and shorter.

Ciao,
Dscho
