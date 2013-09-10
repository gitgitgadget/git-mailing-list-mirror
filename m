From: Tvangeste <i.4m.l33t@yandex.ru>
Subject: Re: Regression in e02ca72: git svn rebase is broken on Windows
Date: Tue, 10 Sep 2013 19:44:25 +0200
Message-ID: <94251378835065@web20j.yandex.ru>
References: <17231378818848@web5m.yandex.ru> <522F4E69.5070501@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:53:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJS7X-0008O8-UY
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093Ab3IJRw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:52:56 -0400
Received: from forward13.mail.yandex.net ([95.108.130.120]:59505 "EHLO
	forward13.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395Ab3IJRwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:52:55 -0400
Received: from web20j.yandex.ru (web20j.yandex.ru [5.45.198.61])
	by forward13.mail.yandex.net (Yandex) with ESMTP id C39491414F6;
	Tue, 10 Sep 2013 21:44:25 +0400 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web20j.yandex.ru (Yandex) with ESMTP id 682CF21C113D;
	Tue, 10 Sep 2013 21:44:25 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1378835065; bh=+nkklE9OV3rEhEhEVNd1pPxDuFYfqnF2N+9GTwGH9iQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=NI3QjFD2EJsLd7Yi8Ff5HSb3cMzdAECShJMe3k1VWeU9KHnOknecP8VCt95LJyiE7
	 AdqF4rsEGreXCyOeen6RHl3E0UgVgxM2MNgz9ePElrcoDAYlGY69m3HQ/n1cH21Kl7
	 XK39ZKDVUYnQRsM50CHB1mCHMBRvYcoDKJwPY5dU=
Received: from agsb-5d87fcb4.pool.mediaWays.net (agsb-5d87fcb4.pool.mediaWays.net [93.135.252.180]) by web20j.yandex.ru with HTTP;
	Tue, 10 Sep 2013 21:44:25 +0400
Envelope-From: i-4m-l33t@yandex.ru
In-Reply-To: <522F4E69.5070501@kdbg.org>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234465>

10.09.2013, 18:53, "Johannes Sixt" <j6t@kdbg.org>:
> Can you please run the command with GIT_TRACE=2?

Sure:
#> git --version
trace: built-in: git 'version'
git version 1.8.4.242.gbb80ee0

#> git svn rebase -l
trace: exec: 'git-svn' 'rebase' '-l'
trace: run_command: 'git-svn' 'rebase' '-l'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--show-cdup'
trace: built-in: git 'config' '--bool' '--get' 'svn.fetchall'
trace: built-in: git 'config' '--bool' '--get' 'svn.noauthcache'
trace: built-in: git 'config' '--bool' '--get' 'svn.nocheckout'
trace: built-in: git 'config' '--get' 'svn.authorsprog'
trace: built-in: git 'config' '--bool' '--get' 'svn.dryrun'
trace: built-in: git 'config' '--bool' '--get' 'svn.preservemerges'
trace: built-in: git 'config' '--bool' '--get' 'svn.followparent'
trace: built-in: git 'config' '--bool' '--get' 'svn.useSvmProps'
trace: built-in: git 'config' '--get' 'svn.authorsfile'
trace: built-in: git 'config' '--get' 'svn.username'
trace: built-in: git 'config' '--get' 'svn.repackflags'
trace: built-in: git 'config' '--bool' '--get' 'svn.localtime'
trace: built-in: git 'config' '--int' '--get' 'svn.repack'
trace: built-in: git 'config' '--get' 'svn.ignorepaths'
trace: built-in: git 'config' '--bool' '--get' 'svn.verbose'
trace: built-in: git 'config' '--bool' '--get' 'svn.quiet'
trace: built-in: git 'config' '--int' '--get' 'svn.logwindowsize'
trace: built-in: git 'config' '--get' 'svn.ignorerefs'
trace: built-in: git 'config' '--get' 'svn.configdir'
trace: built-in: git 'config' '--bool' '--get' 'svn.merge'
trace: built-in: git 'config' '--bool' '--get' 'svn.addauthorfrom'
trace: built-in: git 'config' '--bool' '--get' 'svn.useSvnsyncProps'
trace: built-in: git 'config' '--bool' '--get' 'svn.noMetadata'
trace: built-in: git 'config' '--bool' '--get' 'svn.local'
trace: built-in: git 'config' '--get' 'svn.strategy'
trace: built-in: git 'config' '--get' 'svn.includepaths'
trace: built-in: git 'config' '--bool' '--get' 'svn.uselogauthor'
trace: built-in: git 'rev-parse' '--symbolic' '--all'
trace: built-in: git 'config' '-l'
trace: built-in: git 'config' '-l'
trace: built-in: git 'update-index' '--refresh'
trace: built-in: git 'rev-list' '--first-parent' '--pretty=medium' 'HEAD' '--'
trace: built-in: git 'config' '--bool' 'svn.useSvmProps'
trace: built-in: git 'config' '-l'
trace: built-in: git 'for-each-ref' '--format=%(refname)' 'refs/'
trace: built-in: git 'for-each-ref' '--format=%(refname)' 'refs/'
trace: built-in: git 'for-each-ref' '--format=%(refname)' 'refs/'
trace: built-in: git 'for-each-ref' '--format=%(refname)' 'refs/'
trace: built-in: git 'for-each-ref' '--format=%(refname)' 'refs/'
trace: built-in: git 'config' '--get' 'svn-remote.svn.rewriteRoot'
trace: built-in: git 'config' '--get' 'svn-remote.svn.url'
trace: built-in: git 'config' '--get' 'svn-remote.svn.pushurl'
trace: built-in: git 'config' '--get' 'svn-remote.svn.uuid'
trace: built-in: git 'rev-list' '--pretty=raw' '--reverse' 'cdc459d7cedcec6bb26812e24661c7318f031be4..refs/remotes/trunk' '--'
trace: built-in: git 'config' '--get' 'svn-remote.svn.rewriteRoot'
trace: built-in: git 'config' '--get' 'svn-remote.svn.rewriteUUID'
trace: built-in: git 'diff-index' 'HEAD' '--'
trace: exec: 'git-rebase' 'refs/remotes/trunk'
trace: run_command: 'git-rebase' 'refs/remotes/trunk'
trace: built-in: git 'rev-parse' '--parseopt' '--' 'refs/remotes/trunk'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--is-bare-repository'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'config' '--bool' 'rebase.stat'
trace: built-in: git 'config' '--bool' 'rebase.autostash'
trace: built-in: git 'config' '--bool' 'rebase.autosquash'
trace: built-in: git 'rev-parse' '--verify' 'refs/remotes/trunk^0'
trace: built-in: git 'rev-parse' '--verify' 'refs/remotes/trunk^0'
trace: built-in: git 'symbolic-ref' '-q' 'HEAD'
trace: built-in: git 'rev-parse' '--verify' 'HEAD'
trace: built-in: git 'rev-parse' '--verify' 'HEAD'
trace: built-in: git 'update-index' '-q' '--ignore-submodules' '--refresh'
fatal: unable to access '../../../../w:/work/xxx/xxx-xxx-OSS.git.new/.git/config': Invalid argument
trace: built-in: git 'diff-files' '--quiet' '--ignore-submodules'
fatal: index file open failed: Invalid argument
Cannot rebase: You have unstaged changes.
trace: built-in: git 'diff-index' '--cached' '--quiet' '--ignore-submodules' 'HEAD' '--'
Please commit or stash them.
rebase refs/remotes/trunk: command returned error: 1

Thanks,
  --Tvangeste
