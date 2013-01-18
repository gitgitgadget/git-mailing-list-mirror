From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: teach find-rev to find near matches
Date: Fri, 18 Jan 2013 00:49:17 +0000
Message-ID: <20130118004917.GA27106@dcvr.yhbt.net>
References: <20130117221933.GK4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 18 01:49:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tw09L-0008Cn-89
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 01:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012Ab3ARAtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 19:49:18 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:34124 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754318Ab3ARAtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 19:49:17 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0B61F749;
	Fri, 18 Jan 2013 00:49:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130117221933.GK4574@serenity.lan>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213895>

John Keeping <john@keeping.me.uk> wrote:
> When a single SVN repository is split into multiple Git repositories
> many SVN revisions will exist in only one of the Git repositories
> created.  For some projects the only way to build a working artifact is
> to check out corresponding versions of various repositories, with no
> indication of what those are in the Git world - in the SVN world the
> revision numbers are sufficient.
> 
> By adding "--before" to "git-svn find-rev" we can say "tell me what this
> repository looked like when that other repository looked like this":
> 
>     git svn find-rev --before \
>         r$(git --git-dir=/over/there.git svn find-rev HEAD)
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>

Thanks.
Signed-off-by: Eric Wong <normalperson@yhbt.net>

I've pushed this out to git://bogomips.org/git-svn along with a few
other things I seem to have forgotten about :x

John Keeping (1):
      git-svn: teach find-rev to find near matches

Jonathan Nieder (2):
      Git::SVN::Editor::T: pass $deletions to ->A and ->D
      git svn: do not overescape URLs (fallback case)
