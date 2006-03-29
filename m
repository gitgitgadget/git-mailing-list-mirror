From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Unclutter cg status with --directory as GIT does
Date: Wed, 29 Mar 2006 16:54:27 +0200
Message-ID: <20060329145427.GI27689@pasky.or.cz>
References: <20060329142559.12059.52795.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 16:54:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOc3x-0007Q0-Ir
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 16:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWC2OyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 09:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWC2OyT
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 09:54:19 -0500
Received: from w241.dkm.cz ([62.24.88.241]:940 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750772AbWC2OyS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Mar 2006 09:54:18 -0500
Received: (qmail 26318 invoked by uid 2001); 29 Mar 2006 16:54:27 +0200
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Content-Disposition: inline
In-Reply-To: <20060329142559.12059.52795.stgit@zion.home.lan>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18170>

Dear diary, on Wed, Mar 29, 2006 at 04:25:59PM CEST, I got a letter
where Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> said that...
> Pass the new --directory option (from git 1.1) to git-ls-others for
> list_untracked_files, as does git-status - it's very useful.
> 
> Probably this must be deferred to when the git 1.1 dependency is added, however
> please queue it for then.

Uh, I'm confused. Cogito now depends on git-1.1, and

> diff --git a/cg-Xlib b/cg-Xlib
> index 2b93c11..3150470 100644
> --- a/cg-Xlib
> +++ b/cg-Xlib
> @@ -274,7 +274,7 @@ list_untracked_files()
>  	fi
>  	local listdirs=
>  	[ "$squashflag" = "squashdirs" ] && listdirs=--directory
> -	git-ls-files -z --others $listdirs "${EXCLUDE[@]}"
> +	git-ls-files -z --others --directory $listdirs "${EXCLUDE[@]}"

as you can see, if list_untracked_files was pssed the 'squashdirs'
option, it will already pass it. What cg command would you like to
squash dirs except cg-status?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
