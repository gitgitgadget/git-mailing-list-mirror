From: Fredrik Tolf <fredrik@dolda2000.com>
Subject: Re: how do you "force a pull"?
Date: Sun, 26 Aug 2007 21:02:54 +0200
Message-ID: <m34pimdspt.fsf@pc7.dolda2000.com>
References: <20070825111946.GA7122@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 26 21:03:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPNOO-0007Ep-5G
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 21:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbXHZTDV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 15:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbXHZTDU
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 15:03:20 -0400
Received: from main.gmane.org ([80.91.229.2]:40812 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbXHZTDU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 15:03:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPNOC-0004Wt-Ms
	for git@vger.kernel.org; Sun, 26 Aug 2007 21:03:12 +0200
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 21:03:12 +0200
Received: from fredrik by 1-1-3-7a.rny.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 21:03:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-3-7a.rny.sth.bostream.se
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:qk7vWXVMYMejdLK9f7Ua5yHPa6M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56710>

Jing Xue <jingxue@digizenstudio.com> writes:

> I am working in repo1, and make a savepoint commit and pack up and leave.
>
> On another machine, I have a clone of repo1 (repo2). So I pull from
> repo1, "git reset --soft HEAD" to get rid of the savepoint commit, and start working in repo2.
>
> A while later I realize the earlier commit was actually a good commit
> point. But I can no longer pull it again from repo1. It keeps giving me
> the "Cannot merge" fatal error. "-f" doesn't help.

This is probably not as good an answer as David Watson's suggestion,
but if what you want is to commit your current code while still having
your savepoint commit in the history, shouldn't you be able to commit
your current code and then use git-rebase to rebase it onto the
savepoint commit?

Fredrik Tolf
