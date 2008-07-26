From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-scm.com
Date: Sat, 26 Jul 2008 15:07:57 +0200
Message-ID: <20080726130757.GY32184@machine.or.cz>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com> <m3hcadul6j.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 15:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMjW8-0005U5-Vf
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 15:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYGZNIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 09:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYGZNIA
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 09:08:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41022 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbYGZNH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 09:07:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3791A393B334; Sat, 26 Jul 2008 15:07:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3hcadul6j.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90221>

On Sat, Jul 26, 2008 at 01:03:26AM -0700, Jakub Narebski wrote:
> "Scott Chacon" <schacon@gmail.com> writes:
> 
> > A followup on the post I did a few days ago about Git documentation.
> > I forked Petr's git.or.cz site and put up a version that I think is a
> > bit more accessible and newbie-friendly at git-scm.com.  I had meant
> > to discuss this with Petr before posting it to you all, but I
> > published a blog post that got a bit more attention than I expected,
> > and I didn't want you all to think I didn't care about your opinion,
> > as some have already accused me of.
> 
> On thing I am curious about: how do you plan to have current version
> of Git in the download / last version section?  Petr Baudis uses
> custom script, which search git mailing list for "[ANNOUNCE]" posts,
> and automatically updates download / last version links.

Actually, I scan the last tag on maint branch using git descirbe; the
ANNOUNCE posts are scanned by the RSS feed. Originally, git-scm scanned
kernel.org download directory for the latest tarball, but it seemed that
would break on something like the 1.4.4.5, so it also moved to the git
describe method:

	http://repo.or.cz/w/git-homepage.git?a=blob;f=update.sh
	http://github.com/schacon/learn-github/tree/master/script/get_version.rb

One Scott's concern that didn't occur to me was that a the time of
release, we could have broken links between the time tag is created and
tarballs are wrapped up. I *think* that in practice, this happens at the
same time, I wonder if Junio could confirm that.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
