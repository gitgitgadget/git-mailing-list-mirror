From: Junio C Hamano <junkio@cox.net>
Subject: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 13:10:16 -0700
Message-ID: <7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
	<7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
	<20050415062807.GA29841@64m.dyndns.org>
	<7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
	<7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 22:07:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMX5f-0000cn-Km
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 22:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVDOUK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 16:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVDOUK0
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 16:10:26 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:27013 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261948AbVDOUKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 16:10:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415201018.CTIX1282.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 16:10:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 15 Apr 2005 11:44:02 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Hey, all the code I write is always perfect, of course ;)

And you are always right ;-)  Liked that blast-from-the-past?

LT> That said, I'm having some trouble merging with your perfect code,
LT> especially since I decided that Russell's "always big-endian" thing was
LT> definitely the right way to go (but ended up doing it slightly
LT> differently).

LT> I did my own version of "upcate-cache --cacheinfo", although
LT> mine is a bit more anal, and if you add a new filename it
LT> wants that "--add" flag in there first (why? I really like
LT> to make sure that people who add or remove files from the
LT> cache say so explicitly, so that there are no surprises).
LT> Otherwise it should be compatible with yours.

Thanks.  Not honoring "--add" was an oversight on my part.

LT> And I merged your "Add -z option to show-files", but you had
LT> based your other patches on Petr's tree which due to my
LT> other changes is not going to merge totally cleanly with
LT> mine, so I'm wondering if you might want to try to re-merge
LT> your mergepoint stuff against my current tree?

My pleasure.  I am currently not that interested in toilet part
than I am interested in plumbing part, so rebasing my tree back
to yours is no problem for me.  Currently I see your HEAD is at
461aef08823a18a6c69d472499ef5257f8c7f6c8, so I will generate a
set of patches against it.

