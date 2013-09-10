From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Regression in e02ca72: git svn rebase is broken on Windows
Date: Tue, 10 Sep 2013 18:52:57 +0200
Message-ID: <522F4E69.5070501@kdbg.org>
References: <17231378818848@web5m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tvangeste <i.4m.l33t@yandex.ru>
X-From: git-owner@vger.kernel.org Tue Sep 10 18:53:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRBc-0003FE-Oz
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 18:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835Ab3IJQxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 12:53:04 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:9678 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751872Ab3IJQxD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 12:53:03 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 75DE3130059;
	Tue, 10 Sep 2013 18:52:59 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8EAD719F5EC;
	Tue, 10 Sep 2013 18:52:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <17231378818848@web5m.yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234443>

Am 10.09.2013 15:14, schrieb Tvangeste:
> After bisecting this problem I ended up with the mentioned commit
> that completely breaks git-svn for me on Windows (mingw/msys version).
> 
> ==========
> #> git svn rebase
> warning: unable to access '': Invalid argument
> warning: unable to access '': Invalid argument
> fatal: unable to access '../../../../w:/work/my/repo.git/.git/config': Invalid argument
> fatal: index file open failed: Invalid argument
> Cannot rebase: You have unstaged changes.
> Please commit or stash them.
> rebase refs/remotes/trunk: command returned error: 1
> ==========

Can you please run the command with GIT_TRACE=2?

-- Hannes
