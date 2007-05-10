From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: Use "git config --global" instead of editing ~/.gitconfig
Date: Thu, 10 May 2007 18:02:53 -0400
Message-ID: <20070510220253.GZ13719@fieldses.org>
References: <200705102353.31821.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri May 11 00:03:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmGj0-0004Ur-Oe
	for gcvg-git@gmane.org; Fri, 11 May 2007 00:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbXEJWC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 18:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268AbXEJWC6
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 18:02:58 -0400
Received: from mail.fieldses.org ([66.93.2.214]:35783 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925AbXEJWC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 18:02:57 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HmGir-0002z4-PB; Thu, 10 May 2007 18:02:53 -0400
Content-Disposition: inline
In-Reply-To: <200705102353.31821.johan@herland.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46905>

On Thu, May 10, 2007 at 11:53:31PM +0200, Johan Herland wrote:
> Use git-config for setting global user.name and user.email rather than
> telling the user to edit ~/.gitconfig directly. This brings 
> user-manual.txt in line with tutorial.txt.

The inconsistency is intentional.  We want users to know about
git-config, because it's helpful when writing scripts, and because it
has a useful manpage.  But we also want them to know about the
config-file syntax, since most of us find reading and editing a file
more intuitive than running git-config.  So we use a mixture of both.

--b.

> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  Documentation/user-manual.txt |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/user-manual.txt 
> b/Documentation/user-manual.txt
> index 13db969..23e2f45 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -158,11 +158,8 @@ Making changes
>  Make sure git knows who to blame:
>  
>  ------------------------------------------------
> -$ cat >>~/.gitconfig <<\EOF
> -[user]
> -	name = Your Name Comes Here
> -	email = you@yourdomain.example.com
> -EOF
> +$ git config --global user.name "Your Name Comes Here"
> +$ git config --global user.email you@yourdomain.example.com
>  ------------------------------------------------
>  
>  Select file contents to include in the next commit, then make the
> -- 
> 1.5.0.7
> 
