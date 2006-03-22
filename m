From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's in git.git
Date: Wed, 22 Mar 2006 12:52:18 +0100
Message-ID: <20060322115218.GT18185@pasky.or.cz>
References: <7vodzzb5q3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 12:52:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM1sb-0002eV-Sv
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 12:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWCVLvx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 06:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWCVLvx
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 06:51:53 -0500
Received: from w241.dkm.cz ([62.24.88.241]:43747 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750745AbWCVLvw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 06:51:52 -0500
Received: (qmail 19863 invoked by uid 2001); 22 Mar 2006 12:52:18 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodzzb5q3.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17813>

Dear diary, on Wed, Mar 22, 2006 at 02:58:28AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>    When --use-separate-remote is in effect, the tracking
>    branches are created in $GIT_DIR/refs/remotes/origin/ and you
>    will not get the extra "origin" head.  Your local branch
>    namespace under $GIT_DIR/refs/heads/ will only have "master".
>    In addition, a symref $GIT_DIR/refs/remotes/origin/HEAD
>    points at the primary branch of the remote repository.
>    Similar to a filename in $GIT_DIR/refs/{heads,tags} that can
>    be used to name a ref (e.g. when you say "git diff frotz",
>    you are telling git to read from $GIT_DIR/refs/heads/frotz
>    and use that commit ID to diff your working tree against), a
>    directory that has such a symref under $GIT_DIR/refs/remotes
>    can be used to name the ref.  IOW, "git diff origin" in a
>    repository a cloned this way means you want a diff against
>    $GIT_DIR/refs/remotes/origin/HEAD.

Sounds very good.

>    A new configuration option, 'core.warnambiguousrefs', can be
>    set to warn you if you use "frotz" to name a ref when you
>    have more than one "frotz" under $GIT_DIR/refs (e.g. you have
>    both branch "frotz" and tag "frotz", and/or you have
>    refs/remotes/frotz/HEAD).

Is there any reason why this isn't enabled by default?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
