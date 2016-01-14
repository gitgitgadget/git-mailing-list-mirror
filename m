From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Worktree "gitdir" file being mangled after upgrade to 2.7.0
Date: Thu, 14 Jan 2016 19:36:53 +0100
Message-ID: <87oaco2eka.fsf@igel.home>
References: <20160113234753.GA26473@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Erik Johnson <palehose@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 19:37:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJmlf-0001jd-FM
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 19:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751AbcANSg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 13:36:58 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:51106 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791AbcANSg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 13:36:57 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3phDrR0PQ1z3hjcM;
	Thu, 14 Jan 2016 19:36:55 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3phDrQ71LJzvh1q;
	Thu, 14 Jan 2016 19:36:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id RYcy9516slos; Thu, 14 Jan 2016 19:36:54 +0100 (CET)
X-Auth-Info: FZhcp1BgcUuySt2yfbO4qAUeC21DOSdiQM1CsaMV9mAgWxM5RdLJKAhdkyrfzwnX
Received: from igel.home (ppp-88-217-0-206.dynamic.mnet-online.de [88.217.0.206])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Thu, 14 Jan 2016 19:36:54 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 98FF22C36BD; Thu, 14 Jan 2016 19:36:53 +0100 (CET)
X-Yow: I feel better about world problems now!
In-Reply-To: <20160113234753.GA26473@gmail.com> (Erik Johnson's message of
	"Wed, 13 Jan 2016 17:47:53 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284077>

Erik Johnson <palehose@gmail.com> writes:

> Since upgrading to 2.7.0 last week, eventually I'll get to a point when
> I run 'git worktree list' where several worktrees are incorrectly
> reported as pointing to my main git checkout. Further analysis of the
> files in $GIT_DIR/worktrees/worktree_name/ shows that the gitdir file
> for the worktrees which display incorrectly contains ".git" instead of
> what it should contain (i.e. "/path/to/worktree/.git".

This always happens to me when I run "git rebase" in a worktree.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
