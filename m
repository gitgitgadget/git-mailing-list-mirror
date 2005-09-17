From: Junio C Hamano <junkio@cox.net>
Subject: deprecating more
Date: Fri, 16 Sep 2005 18:31:54 -0700
Message-ID: <7vzmqceayd.fsf@assigned-by-dhcp.cox.net>
References: <7vd5n8fqso.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 17 03:33:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGRYc-0004Gl-E5
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 03:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVIQBb4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 21:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVIQBb4
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 21:31:56 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62138 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750815AbVIQBbz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 21:31:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050917013155.YMXQ17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 21:31:55 -0400
To: git@vger.kernel.org
In-Reply-To: <7vd5n8fqso.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 16 Sep 2005 18:04:23 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8749>

Junio C Hamano <junkio@cox.net> writes:

> Is anybody actually using this program?  If not I'd like to
> deprecate it now and remove it before we hit 1.0.  As far as I
> can tell it is not very useful.

The same goes for the following programs:

    git-diff-helper
    git-diff-stages
    git-export
    git-rev-tree

Among them, I could be talked into keeping git-export on the
condition that we will add a counterpart git-import that can
read git-export output and recreate an identical repository
[*1*]; without something like that, I doubt its usefulness,
especially since "git-whatchanged" is far more useful for
everyday use.

[Footnote]

*1* which I think actually is impossible without fixing
git-export first so that it exports the initial commit.  I may
be mistaken.
