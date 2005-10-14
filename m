From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-whatchanged does not show merge result?
Date: Fri, 14 Oct 2005 10:24:24 -0700
Message-ID: <7vd5m8rozb.fsf@assigned-by-dhcp.cox.net>
References: <4dd15d180510140929x2c69f61ag19a1409cfd993e7b@mail.gmail.com>
	<4dd15d180510140933j7a730c49hb9cdaa98ea0a5b07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 19:27:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQTID-0000Bg-HA
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 19:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVJNRY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 13:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVJNRY0
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 13:24:26 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:23219 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750809AbVJNRY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 13:24:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051014172405.XWCH776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Oct 2005 13:24:05 -0400
To: David Ho <davidkwho@gmail.com>
In-Reply-To: <4dd15d180510140933j7a730c49hb9cdaa98ea0a5b07@mail.gmail.com>
	(David Ho's message of "Fri, 14 Oct 2005 12:33:51 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10116>

David Ho <davidkwho@gmail.com> writes:

> When I merged back the changes from mybranch, git-whatchanged -p did
> not should the diff of the merge.

You probably mean "git-whatchanged -p -m".

I've seen this question asked at least twice in the past.

    SYNOPSIS
    --------
    'git-whatchanged' <option>...

    DESCRIPTION
    -----------
    Shows commit logs and diff output each commit introduces.  The
    command internally invokes 'git-rev-list' piped to
    'git-diff-tree', and takes command line options for both of
    these commands.

    This manual page describes only the most frequently used options.

Perhaps the frequently used options should include '-m' as well.
This part is from git-diff-tree.txt:

    -m::
            By default, "git-diff-tree --stdin" does not show
            differences for merge commits.  With this flag, it shows
            differences to that commit from all of its parents.
