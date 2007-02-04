From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git config' vs 'git repo-config'
Date: Sun, 04 Feb 2007 02:52:51 -0800
Message-ID: <7vmz3ury7w.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702040138r6580c36agf86e8f8191a40021@mail.gmail.com>
	<7v8xfetft6.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550702040200y4f09070fia3716ca949fddac7@mail.gmail.com>
	<7v4pq2tet5.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550702040223h56f1524x9e6c460445874063@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 11:52:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDezP-0007XJ-3q
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 11:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbXBDKwx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 05:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbXBDKwx
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 05:52:53 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:40045 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752278AbXBDKww (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 05:52:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204105253.HFYH4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 05:52:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KNsr1W00C1kojtg0000000; Sun, 04 Feb 2007 05:52:52 -0500
In-Reply-To: <e5bfff550702040223h56f1524x9e6c460445874063@mail.gmail.com>
	(Marco Costalba's message of "Sun, 4 Feb 2007 11:23:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38685>

"Marco Costalba" <mcostalba@gmail.com> writes:

>> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> I plan to release a point release after git-1.5 is out, so I'm
> wondering if renaming git-repo-config --> git-config also in qgit.
>
> BTW  'git-repo-config' seems to be currently used also by StGit

It's really up to you and Catalin, but if you expect people
might run with git 1.4.4, it would make more sense to stick with
the tried-and-proven names and wait until you are reasonably
sure that everybody you care about are running at least 1.5.0.

The only reason the in-tree scripts git.git ships with use the
new names is because they know they are part of a revision that
has them.
