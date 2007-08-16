From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: commit author x commit committer issue
Date: Thu, 16 Aug 2007 02:20:02 -0700
Message-ID: <20070816092002.GD16849@muzzle>
References: <46B9C92B.3000000@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard MUSIL <richard.musil@st.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 11:20:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILbWU-0006ff-I8
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 11:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399AbXHPJUH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 05:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754015AbXHPJUG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 05:20:06 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35859 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbXHPJUF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 05:20:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id DB6162DC08D;
	Thu, 16 Aug 2007 02:20:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46B9C92B.3000000@st.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55998>

Richard MUSIL <richard.musil@st.com> wrote:
> Normally, when patch is applied, git distinguishes commit author and
> commit committer (relying on info from patch).
> However, after the patches are committed to svn repository using:
> git-svn dcommit
> author and committer data are set to same values (or at least time and
> date, I cannot verify it for names).
> I wonder if there is any reason for this behavior, because I would
> definitely like to keep original commit info (which came from patch) in
> my git repository.

I try to keep commits made to SVN using git-svn as much like commits
made using other SVN clients as much as possible.

Two people using git-svn (in its recommended fashion and maintaining
linear history) can have identical SHA1s in their repository even if
those two repositories had never seen each other before.  Consistency
is good.

I also want to avoid creating extra junk on the SVN repository which I
don't personally consider very important.  SVK does stuff like that with
merges, and only SVK understands the metadata it uses.  I prefer
transparency.

-- 
Eric Wong
