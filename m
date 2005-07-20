From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Misc documentation fixes and improvements
Date: Wed, 20 Jul 2005 19:12:22 +0200
Message-ID: <20050720171221.GD17217@pasky.ji.cz>
References: <20050720120501.GA14074@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 20 19:13:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvI7c-0002Xh-Gn
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 19:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVGTRMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jul 2005 13:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVGTRMZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jul 2005 13:12:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13330 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261421AbVGTRMY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2005 13:12:24 -0400
Received: (qmail 21566 invoked by uid 2001); 20 Jul 2005 17:12:22 -0000
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20050720120501.GA14074@diku.dk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jul 20, 2005 at 02:05:01PM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> told me that...
> Fix displaying of an error message when cg-help is called with unknown
> command and use $USAGE so the correct cg-help usage string is printed.
> Drop useless use of cat in print_help(). Improve the asciidoc markup.
> 
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> ---
> 
> diff --git a/cg-diff b/cg-diff
> --- a/cg-diff
> +++ b/cg-diff
> @@ -3,7 +3,7 @@
>  # Make a diff between two GIT trees.
>  # Copyright (c) Petr Baudis, 2005
>  #
> -# Outputs a diff for converting the first tree to the second one.
> +# Outputs a diff for converting between two trees.
>  # By default compares the current working tree to the state at the
>  # last commit. The output will automatically be displayed in a pager
>  # unless it is piped to a program.

I dropped this hunk (seems to only lose clarity).

> diff --git a/cg-help b/cg-help
> --- a/cg-help
> +++ b/cg-help
> @@ -90,7 +91,7 @@ ADVANCED_COMMANDS="$(ls $bin_path/cg-adm
>  colorize <<__END__
>  The Cogito version control system  $(cg-version)
>  
> -Usage: cg-COMMAND [ARG]...
> +Usage: $USAGE
>  
>  Available commands:
>  $(print_command_listing $REGULAR_COMMANDS)

And I dropped the Usage string here altogether.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
