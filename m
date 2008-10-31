From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Fri, 31 Oct 2008 15:01:57 -0400
Message-ID: <20081031190157.GG17651@mit.edu>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org> <m33aichgc1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 20:03:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvzHC-00041v-7E
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 20:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbYJaTCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 15:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbYJaTCB
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 15:02:01 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:43162 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751271AbYJaTCA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 15:02:00 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KvzFu-0007Mq-17; Fri, 31 Oct 2008 15:01:58 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KvzFt-0002Gr-EL; Fri, 31 Oct 2008 15:01:57 -0400
Content-Disposition: inline
In-Reply-To: <m33aichgc1.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99622>

On Fri, Oct 31, 2008 at 09:36:33AM -0700, Jakub Narebski wrote:
> > +#if 0
> > +	warning("git revert is deprecated, please use git cherry-pick --revert/-R instead");
> > +#endif
> 
> By the way, Mercurial names this command IIRC 'hg backout'. 

By the way, BitKeeper names this command "bk undo" (which is another
reason why I would advocate against "git undo" as a syntatic sugar for
"git checkout HEAD -- $*") --- not that I think there are too many BK
refugees that might want to switch to git, but it shows that "undo"
has its own ambiguities; gk uses "undo" the same way we currently use
"git revert".

For people who argue that "git cherry-pick --revert" or "git
cherry-pick -R" is too long, I'd argue that for most people its not a
common command, and for those for which it is common, they can always
make in alias for "git pick".

						- Ted
