From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn stubbornly re-creating branch "master"
Date: Sun, 29 Mar 2009 15:28:27 -0700
Message-ID: <20090329222827.GA32199@dcvr.yhbt.net>
References: <20090329171347.GA26866@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcin Owsiany <porridge@debian.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 00:30:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo3Vy-0002tz-Qt
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 00:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbZC2W2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 18:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbZC2W2a
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 18:28:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34845 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251AbZC2W2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 18:28:30 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E991F79C;
	Sun, 29 Mar 2009 22:28:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090329171347.GA26866@beczulka>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115043>

Marcin Owsiany <porridge@debian.org> wrote:
> Hello,
> 
> I created my git repository by cloning it with git-svn from an upstream SVN
> repository. When I did that, a branch "master" was created. Afterwards I
> renamed that branch to "upstream". However every time I "git-svn fetch", it
> recreates the "master" branch, pointing it at the newest upstream commit.
> 
> Ideally, I'd like it to just forget about "master" and do the same to my
> "upstream" branch. Is it possible?
> 
> If not, then is it at least possible to have it not recreate the "master"
> branch? It clutters my view.

"master" has been a git convention since the earliest days of git and
it's less confusing to new users following documentation if it always
exists (and a lot of users' first git experience is with git svn).

Why not just use "master" as one of your branches?  It won't bite you.
"git svn fetch" will never clobber your "master" if it already exists.

-- 
Eric Wong
