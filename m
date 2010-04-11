From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: support svnmerge.py merge tickets from pre
	svn 1.5.0 releases
Date: Sat, 10 Apr 2010 18:02:42 -0700
Message-ID: <20100411010242.GB22778@dcvr.yhbt.net>
References: <loom.20100402T005055-989@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Bryars <git@darkskiez.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 03:02:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0lZa-00053P-4o
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 03:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393Ab0DKBCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 21:02:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48954 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321Ab0DKBCn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 21:02:43 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50FB1F689;
	Sun, 11 Apr 2010 01:02:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20100402T005055-989@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144618>

Mark Bryars <git@darkskiez.co.uk> wrote:
> 
> I currently have an SVN 1.3.x repository and am using the old svnmerge.py script
> to manage merges with it, it would be nice to migrate to git without first
> upgrading to SVN 1.5+, running the converter tool, and then migrating to git.
> This small patch allows me to skip that step by referencing the old property
> names in the repo.
 
> Regards,
>  Mark Bryars
> 
> From 15856073779bfdd1c5367ea9e01a55242c1e7568 Mon Sep 17 00:00:00 2001
> From: Mark Bryars <git@darkskiez.co.uk>
> Date: Thu, 1 Apr 2010 23:30:37 +0100
> Subject: [PATCH] git-svn: support svnmerge.py merge tickets from pre svn 1.5.0
> releases
> 
> Pre svn 1.5.0 svnmerge.py used svnmerge-integrated properties.
> Small patch to check for these and apply them.
> 
> Signed-off-by: Mark Bryars <git@darkskiez.co.uk>

Thanks Mark, your patch looks good.

I've reworded the commit message to include parts in your email but not
the commit message.  I've pushed this out to
  git://git.bogomips.org/git-svn

------------------------------------------------------------------------
  git-svn: support svnmerge.py merge tickets from SVN < 1.5.0

  SVN < 1.5.0 svnmerge.py used the "svnmerge-integrated" property
  instead of the current "svn:mergeinfo" property.  This change
  allows git-svn to work directly with older SVN < 1.5.0
  svnmerge.py repositories without upgrading to SVN 1.5+ first
  and converting the properties.

  [ew: reworded commit message]

  Signed-off-by: Mark Bryars <git@darkskiez.co.uk>
  Acked-by: Eric Wong <normalperson@yhbt.net>
------------------------------------------------------------------------

If the message makes sense to you, I'll ask Junio to pull.

Sorry for the late response, I haven't gotten a chance to
check this list for a while...

Thanks again!
-- 
Eric Wong
