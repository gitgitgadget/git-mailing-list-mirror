From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Tue, 10 Apr 2007 23:02:07 +0200
Message-ID: <20070410210207.GA20955@uranus.ravnborg.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org> <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com> <Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org> <81b0412b0704100848n69c99f55xa7cc96087cad7e31@mail.gmail.com> <Pine.LNX.4.64.0704100852550.6730@woody.linux-foundation.org> <7v6484vxd5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704101302480.6730@woody.linux-foundation.org> <7vk5wkuf35.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 04:24:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbNs1-00041b-1e
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 23:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030694AbXDJV1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 17:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030716AbXDJV1M
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 17:27:12 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:39741 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030690AbXDJV0v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 17:26:51 -0400
X-Greylist: delayed 1531 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Apr 2007 17:26:51 EDT
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 4D70DE30D54;
	Tue, 10 Apr 2007 23:01:19 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id C8527580D2; Tue, 10 Apr 2007 23:02:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk5wkuf35.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44164>

On Tue, Apr 10, 2007 at 01:52:46PM -0700, Junio C Hamano wrote:
> 
> People occasionally ask "how would I make a small fix to a
> commit that is buried in the history", so let me take a moment
> to give them a recipe.

That recipe looks ummm complicated...
What I usually do is:

git format-patch HEAD~4..HEAD
git reset --hard HAED~4
patch -p1 < 0004*
...edit...
delete diff from 0004*
git diff >> 0004*
git reset --hard
git am 000*


Maybe this is as complicated as your example but this
is very simple to deal with.
And I do not destroy history or anything.

But that said I do not use topic brances but simply
clone my local repository as needed.
And I always deal with a linear history.


[I post this mostly to check if this is insane
and I need to understand the way you propose to do stuff]

	Sam
