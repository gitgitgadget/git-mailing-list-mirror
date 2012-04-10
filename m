From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] prohibit "svn dcommit" on remote-tracking-branches
Date: Tue, 10 Apr 2012 21:17:32 +0000
Message-ID: <20120410211732.GB27555@dcvr.yhbt.net>
References: <20120404084234.GA17768@mathe-macht-spass.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Engwer <christian.engwer@wwu.de>
X-From: git-owner@vger.kernel.org Tue Apr 10 23:17:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHiRW-0000Dq-J0
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 23:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302Ab2DJVRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 17:17:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33426 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754732Ab2DJVRd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 17:17:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 401D61F5AD;
	Tue, 10 Apr 2012 21:17:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120404084234.GA17768@mathe-macht-spass.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195131>

Christian Engwer <christian.engwer@wwu.de> wrote:
> A branch should either be a local copy of an svn branch, or a remote
> tracking branch. After a "git svn dcommit" a remote tracking branch
> could not be synced with the git remote due to the rebase that occured
> during the dcommit. Thus we check for a remote entry in the git config
> for the current branch and prohibit the "dcommit" if such an entry
> exists.

Should there be an option to force/override this?

git-svn predates remote tracking branches, and I've never gotten in the
habit using remote tracking branches.  I'll wait for others to chime
in...

> +        if (s/^\* +//)
> +        {

style, opening brace should be on the same line as the if/while/for:

	if (...) {

Also, indentation should be with hard tabs.  (Basically follow existing
style conventions when you see them).  Thanks.
