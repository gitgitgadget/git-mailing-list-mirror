From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: find-rev error message when missing arg
Date: Mon, 10 Mar 2008 22:19:10 -0700
Message-ID: <20080311051910.GB9389@hand.yhbt.net>
References: <1205200346-5537-1-git-send-email-marcandre.lureau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Marc-Andre Lureau (elmarco)" <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 06:19:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYwtz-00020H-MB
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 06:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYCKFTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 01:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbYCKFTN
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 01:19:13 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59788 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658AbYCKFTM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 01:19:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 544427F4153;
	Mon, 10 Mar 2008 22:19:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1205200346-5537-1-git-send-email-marcandre.lureau@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76797>

"Marc-Andre Lureau (elmarco)" <marcandre.lureau@gmail.com> wrote:
> Just let the user know that a revision argument is missing instead of
> a perl error. This error message mimic the "init" error message, but
> could be improved.

Thanks Marc-Andre.  Three small things:

* Minor spelling error noted below.
* Please wrap your commit message lines at 72 characters or less.
* Sign-off?

Tentatively-Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 1195569..2ee7ca5 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -522,7 +522,8 @@ sub cmd_dcommit {
>  }
>  
>  sub cmd_find_rev {
> -	my $revision_or_hash = shift;
> +	my $revision_or_hash = shift or die "SVN or git revison required ",
                                                        revision
> +	                                    "as a command-line argument\n";
>  	my $result;
>  	if ($revision_or_hash =~ /^r\d+$/) {
>  		my $head = shift;
> -- 

-- 
Eric Wong
