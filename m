From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: sort the options in the --help message.
Date: Sat, 3 Nov 2007 12:42:12 -0700
Message-ID: <20071103194212.GA28755@muzzle>
References: <1194116014-13964-1-git-send-email-tsuna@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sat Nov 03 20:42:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoOt2-0005vu-2P
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 20:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447AbXKCTmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 15:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbXKCTmO
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 15:42:14 -0400
Received: from hand.yhbt.net ([66.150.188.102]:49070 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756143AbXKCTmN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 15:42:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 1179F7DC0FE;
	Sat,  3 Nov 2007 12:42:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1194116014-13964-1-git-send-email-tsuna@lrde.epita.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63304>

Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
> 	* git-svn.perl (&usage): Sort the various options.
> 
> Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
> ---
> It always annoys me when I read the output of git svn <cmd> --help that the
> options are printed in no particular order.

The above sentence belongs in the commit message.

Thanks,

Acked-by: Eric Wong <normalperson@yhbt.net>

>  git-svn.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 22bb47b..4900f57 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -252,7 +252,7 @@ Usage: $0 <command> [options] [arguments]\n
>  		next if $cmd && $cmd ne $_;
>  		next if /^multi-/; # don't show deprecated commands
>  		print $fd '  ',pack('A17',$_),$cmd{$_}->[1],"\n";
> -		foreach (keys %{$cmd{$_}->[2]}) {
> +		foreach (sort keys %{$cmd{$_}->[2]}) {
>  			# mixed-case options are for .git/config only
>  			next if /[A-Z]/ && /^[a-z]+$/i;
>  			# prints out arguments as they should be passed:

-- 
Eric Wong
