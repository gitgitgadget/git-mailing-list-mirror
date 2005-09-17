From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix fetch completeness assumptions
Date: Sat, 17 Sep 2005 01:02:35 -0700
Message-ID: <7vhdckceas.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509142120020.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat Sep 17 10:03:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGXej-00020p-5m
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 10:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVIQICi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 04:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVIQICi
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 04:02:38 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:5604 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751006AbVIQICh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2005 04:02:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050917080237.BHPP29184.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Sep 2005 04:02:37 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509142120020.23242@iabervon.org> (Daniel
	Barkalow's message of "Wed, 14 Sep 2005 21:31:42 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8758>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Don't assume that any commit we have is complete; assume that any ref
> we have is complete.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
>
> ---
> Only lightly tested, but it seems to work. Marks all of the commits in 
> refs, and their ancestors back as far as the date of the commit it's 
> processing. If the commit it's processing is marked, it doesn't recurse 
> into it.

Have you tested this idea with cloning into an empty repository?
It seems to break my tests.
