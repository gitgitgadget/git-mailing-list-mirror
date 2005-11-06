From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix empty line processing in git-shortlog.perl
Date: Sun, 6 Nov 2005 23:44:22 +0100
Message-ID: <20051106224422.GQ1431@pasky.or.cz>
References: <20051106224218.22797.97260.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 23:45:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYtFk-0002I5-QP
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 23:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVKFWoY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 17:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVKFWoY
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 17:44:24 -0500
Received: from w241.dkm.cz ([62.24.88.241]:12965 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751262AbVKFWoX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 17:44:23 -0500
Received: (qmail 23152 invoked by uid 2001); 6 Nov 2005 23:44:22 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20051106224218.22797.97260.stgit@machine.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11236>

Dear diary, on Sun, Nov 06, 2005 at 11:42:18PM CET, I got a letter
where Petr Baudis <pasky@suse.cz> told me that...
> diff --git a/git-shortlog.perl b/git-shortlog.perl
> index 0b14f83..7283159 100755
> --- a/git-shortlog.perl
> +++ b/git-shortlog.perl
> @@ -94,7 +94,7 @@ sub changelog_input {
>  
>  		# skip to non-blank line
>  		elsif ($pstate == 3) {
> -			next unless /^\s*?(.*)/;
> +			next unless /^\s*?(\S.*)$/;
>  
>  			# skip lines that are obviously not
>  			# a 1-line cset description
> 

Whoops, the ? was not part of the original regexp and is obviously
useless. Well, I don't think it really matters, so it is up to you...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
