From: Junio C Hamano <junkio@cox.net>
Subject: Re: merging initial part of a branch?
Date: Wed, 11 Jan 2006 17:47:05 -0800
Message-ID: <7vmzi2i5eu.fsf@assigned-by-dhcp.cox.net>
References: <20060111230451.GH8618@fieldses.org>
	<7vek3epbs9.fsf@assigned-by-dhcp.cox.net>
	<20060112005531.GB14599@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 02:47:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwrYV-0005w4-Hy
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 02:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWALBrI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 20:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWALBrI
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 20:47:08 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:26862 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964965AbWALBrH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 20:47:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112014433.WBQV20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 20:44:33 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060112005531.GB14599@fieldses.org> (J. Bruce Fields's message
	of "Wed, 11 Jan 2006 19:55:32 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14542>

"J. Bruce Fields" <bfields@fieldses.org> writes:

>> I haven't tried this for some time, but I presume
>> 
>> 	$ git pull linus tag v2.6.15
>> 
>> would do what you want.
>
> Yep!  Thanks.  The only documentation I can find for this is a slightly
> obscure bit in the git-pull man page which lists this as a "short-cut"
> notation.  What is it a shortcut for?  Is it possible to specify an
> arbitrary commit in place of the "tag v2.6.15" somehow?

The phrase "short-hand" refers to "linus" in the above example.
I.e. the name of the file in $GIT_DIR/remotes that records the
URL (among other things).

You can only say either "branchname" or "tag tagname" for pull,
because of the way underlying git native protocol works (it may
not be too hard to extend it, but I haven't looked into it nor
particularly interested in looking into it at the moment).
