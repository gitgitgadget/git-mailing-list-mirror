From: Petr Baudis <pasky@suse.cz>
Subject: Re: Dropping Git.pm (at least Git.xs)?
Date: Thu, 7 Sep 2006 21:51:07 +0200
Message-ID: <20060907195107.GD23891@pasky.or.cz>
References: <7vodtxuqt4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 21:51:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLPuH-0003D7-1b
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 21:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWIGTvL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 15:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWIGTvL
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 15:51:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32128 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751438AbWIGTvK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 15:51:10 -0400
Received: (qmail 10596 invoked by uid 2001); 7 Sep 2006 21:51:07 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodtxuqt4.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26652>

  Hi,

Dear diary, on Sun, Sep 03, 2006 at 01:34:31PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>  - I think the clean-up promise of Git.pm is great (e.g.
>    safe_qx should be part of it not in git-svn alone).
> 
>  - I think Git.xs was a bit premature and raised the hurdle of
>    cleaning up and consolidating various core-wrappers from
>    existing Perl scripts into Git.pm and have them use Git.pm.
>    It would be nice if we can drop this part for now, and do a
>    bit more Perl-level clean-up first.
> 
>  - I think "repository" abstraction, if we are going to have
>    one, should be designed from the core level if we are going
>    to have it accessible from Git.xs.  Unfortunately I am not
>    ready to invest great time and effort for core level
>    libification at this moment.

  I basically agree on all three points - I will try to submit a patch
to implement get_object() purely in Git.pm reasonably soon, and will see
about introducing some actually designed repository division abstraction
when I get some time. I hope to see Git.xs come back again in few
months, but for now I have to concur that we should go back to the
drawing board.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
