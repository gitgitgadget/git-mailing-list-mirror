From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Diffs "from" working directory
Date: Sun, 20 Nov 2005 12:43:59 -0500
Message-ID: <20051120174359.GA24177@fieldses.org>
References: <200511201817.15780.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chuck Lever <cel@netapp.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 18:44:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdtEV-0006vo-Qw
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 18:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVKTRoE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 12:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVKTRoE
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 12:44:04 -0500
Received: from mail.fieldses.org ([66.93.2.214]:16101 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751237AbVKTRoC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 12:44:02 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.54)
	id 1EdtEN-0006ec-AT; Sun, 20 Nov 2005 12:43:59 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Content-Disposition: inline
In-Reply-To: <200511201817.15780.blaisorblade@yahoo.it>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12388>

On Sun, Nov 20, 2005 at 06:17:15PM +0100, Blaisorblade wrote:
> I've given a look at commit fcc1ad70be5ff89996358b6d770cd229fec2a3ba, and 
> while it may or may not be the right thing to do, there's a misunderstanding 
> at the base.

What misunderstanding?  Could you quote it?

> For instance, in the stg tree, before that patch, I can do:
> 
> $ echo ciao >> README
> $ stg diff -r HEAD:
> $ stg diff -r HEAD
> diff --git a/README b/README
> index 184ded8..adb3970 100644
> --- a/README
> +++ b/README
> @@ -12,3 +12,4 @@ StGIT commands.
> 
>  For the latest version see http://www.procode.org/stgit/
>  For a tutorial see http://wiki.procode.org/cgi-bin/wiki.cgi/StGIT_Tutorial
> +ciao

That's a diff *to* the working directory.  My complaint was that there
wasn't a convenient way to get a diff *from* the working directory.

It's nice to have a convenient shorthand for the current working
directory, and since there's already a shorthand for the HEAD ("HEAD")
it seemed more sensible to make "" the current working directory.

It's a minor point, but it seems convenient.

--b.
