From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCh] jit-trackdown
Date: Fri, 29 Apr 2005 15:09:18 -0700
Message-ID: <7vr7gt2q29.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0504291730000.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Greaves <david@dgreaves.com>,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:04:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdaY-0001BP-R7
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 00:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbVD2WJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 18:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVD2WJX
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 18:09:23 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:764 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S263025AbVD2WJU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 18:09:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050429220919.ZFMC19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Apr 2005 18:09:19 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504291730000.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Fri, 29 Apr 2005 17:40:56 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> I've made a proposal like the following:

DB> .git/
DB>   objects/    (traditional)
DB>   refs/       Directories of hex SHA1 + newline files
DB>     heads/    Commits which are heads of various sorts
DB>     tags/     Tags, by the tag name (or some local renaming of it)
DB>   info/       Other shared information
DB>     remotes
DB>   ...         Everything else isn't shared
DB>   HEAD        Symlink to refs/heads/<something>

Thank you for clear description.

I agree with Linus that plumbing does not need to know anything
but objects/.  What the porcelain passes fsck-cache to implement
prune/garbage-collect does not concern it.  Of course it matters
to the users and that is the reason why I asked.

