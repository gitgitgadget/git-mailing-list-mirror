From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] display shortlog after git-commit
Date: Sun, 15 Apr 2007 16:08:36 -0700
Message-ID: <7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
	<20070404070135.GF31984@mellanox.co.il>
	<7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
	<20070415223909.GG15208@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:08:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdDpt-0004GF-Mj
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbXDOXIi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754056AbXDOXIi
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:08:38 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:34625 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbXDOXIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:08:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415230838.LKVQ1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 19:08:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id nb8c1W00Y1kojtg0000000; Sun, 15 Apr 2007 19:08:37 -0400
In-Reply-To: <20070415223909.GG15208@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 16 Apr 2007 01:39:09 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44540>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> Display the subject of the commit just made.

WHY?  You just made the commit.

>> Quoting Junio C Hamano <junkio@cox.net>:
>> Subject: Re: [PATCH] display shortlog after git-commit
>> 
>> Too noisy for a default.
>
> So maybe the following isn't too bad?
> This results in:
> $ ./git-commit.sh --amend
> Created commit 5633ddde0e35210f607bde063bcbf709e4d20a8d
> Display the subject of the commit just made.
>  1 files changed, 1 insertions(+), 1 deletions(-)

I think this is still one line too many.  It _might_ be an
improvement if it were

    $ ./git-commit.sh --amend
    Created commit 5633ddde: Display the subject of the commit just made.
     1 files changed, 1 insertions(+), 1 deletions(-)

though...
