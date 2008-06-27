From: Petr Baudis <pasky@suse.cz>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 10:50:07 +0200
Message-ID: <20080627085007.GE12567@machine.or.cz>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 10:51:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC9fg-0001wa-K2
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 10:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673AbYF0IuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 04:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756658AbYF0IuL
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 04:50:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52474 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756567AbYF0IuK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 04:50:10 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 56D45393BAB8; Fri, 27 Jun 2008 10:50:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86536>

  Hi,

On Thu, Jun 26, 2008 at 11:50:06PM -0700, Robert Anderson wrote:
> Seems to me the concept of the "index" is a half-baked version of what
> I really want, which is the ability to factor a working tree's changes
> into its constituent parts in preparation for committing them.  The
> index provides some very nice facilities to factor out changes in a
> working tree into a "staging area", but the fundamental flaw of this
> in my view is that this "staging area" is not instantiated as a tree,
> so it cannot be compiled and/or tested before committing.
> 
> Consider a facility where the state you want to commit next is built
> up in the current working directory, and the original set of changes
> exists in some proto-space like the index currently inhabits, where
> you can query and manipulate that state, but it isn't instantiated in
> your working tree.

  I wanted to suggest using commit and commit --amend, but I realized
that frankly, I don't understand quite what are you wanting to do.
Through the process, are you preparing a sequence of two commits at
once, or merely a single commit? With s/--prep/--cached/ and throwing
git prep away completely, it's not clear to me how would what you
present be different at all from just using index - could you point out
what is actually different in your workflow compared to the prep
workflow you propose?

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
