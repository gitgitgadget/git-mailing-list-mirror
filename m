From: Brad Roberts <braddr@puremagic.com>
Subject: Re: [gitweb PATCH] add a 'diff to parent' option in the file history
 display
Date: Sun, 23 Oct 2005 10:13:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0510231011200.2284-100000@bellevue.puremagic.com>
References: <Pine.LNX.4.44.0510230815570.2284-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Oct 23 19:13:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETjPN-00060P-JV
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 19:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVJWRND (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 13:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVJWRND
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 13:13:03 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:56237 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S1750768AbVJWRNB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 13:13:01 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.4/8.13.4/Debian-3) with ESMTP id j9NHD3xP011257
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 23 Oct 2005 10:13:03 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.4/8.13.4/Submit) with ESMTP id j9NHD3XX011253
	for <git@vger.kernel.org>; Sun, 23 Oct 2005 10:13:03 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0510230815570.2284-100000@bellevue.puremagic.com>
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10493>

And of course I flub another patch.. the first new line there needs a
trailing '.'.  I've checked in that change to the repository below.

Also, both of these are on the 'brad-master' branch, not 'master'.

On Sun, 23 Oct 2005, Brad Roberts wrote:

> Date: Sun, 23 Oct 2005 08:25:05 -0700 (PDT)
> From: Brad Roberts <braddr@puremagic.com>
> To: git@vger.kernel.org
> Subject: [gitweb PATCH] add a 'diff to parent' option in the file history
>     display
>
> I'm not sure how well this plays with multiple parent merges or anything
> complicated.  It seems to work well on a converted cvs archive.
>
> Pullable from:  git://cvs.puremagic.com/git/gitweb.git
>
> ---------------------
> add a 'diff to parent' option in the file history display
>
> Signed-off-by: Brad Roberts <braddr@puremagic.com>
> ---
>
>  gitweb.cgi |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> 2539b424d62cc2ab060c5d2fa9525a6b6f8df7e5
> diff --git a/gitweb.cgi b/gitweb.cgi
> --- a/gitweb.cgi
> +++ b/gitweb.cgi
> @@ -2054,6 +2054,9 @@ sub git_history {
>  				print " | " .
>  				$cgi->a({-href => "$my_uri?p=$project;a=blobdiff;h=$blob;hp=$blob_parent;hb=$commit;f=$file_name"},
>  				"diff to current");
> +				print " | "
> +				$cgi->a({-href => "$my_uri?p=$project;a=blobdiff;h=$blob_parent;hp=$3;hb=$commit;f=$file_name"},
> +				"diff to parent");
>  			}
>  			print "</td>\n" .
>  			      "</tr>\n";
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
