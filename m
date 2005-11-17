From: Junio C Hamano <junkio@cox.net>
Subject: master has some toys
Date: Wed, 16 Nov 2005 17:21:13 -0800
Message-ID: <7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	<b0943d9e0511160311k725526d8v@mail.gmail.com>
	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 17 02:22:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcYSv-0000Qg-Dc
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 02:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030583AbVKQBVQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 20:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030585AbVKQBVQ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 20:21:16 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:28554 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030583AbVKQBVO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 20:21:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117012042.NRRJ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 20:20:42 -0500
To: git@vger.kernel.org
In-Reply-To: <7vr79g8mys.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 16 Nov 2005 10:30:19 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12081>

Junio C Hamano <junkio@cox.net> writes:

> Incidentally, for the last couple of days, I was working on
> adding a very limited binary file diff support to "diff piped to
> apply" pattern, and the result has been posted as "reworked
> rebase" patches.  It is very limited in the sense that the diff
> output does not attempt to be useful if the patch consumer does
> not have both pre- and post-image blob, but for the use of
> StGIT's internal patch replaying purposes that is not a concern,
> so you might be interested in taking a look.

Along with the git wrapper fixes and git-apply bugfix (it did
not fail when it saw unapplicable binary patches), and
cvsexportcommit fixes from Kevin Geiss, I have the "limited
binary patch support" on the master branch.  The reworked rebase
is still in proposed updates branch.

I'll be offline for a couple of hours chaffering my wife.
