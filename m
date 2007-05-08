From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual.txt: Some doc updates
Date: Mon, 7 May 2007 23:21:15 -0400
Message-ID: <20070508032115.GC9471@fieldses.org>
References: <87hcrcjre3.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 05:21:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlGGR-0007sM-05
	for gcvg-git@gmane.org; Tue, 08 May 2007 05:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbXEHDVS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 23:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbXEHDVR
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 23:21:17 -0400
Received: from mail.fieldses.org ([66.93.2.214]:39050 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755124AbXEHDVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 23:21:17 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HlGGJ-0003ZC-SC; Mon, 07 May 2007 23:21:15 -0400
Content-Disposition: inline
In-Reply-To: <87hcrcjre3.fsf@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46523>

On Thu, Apr 19, 2007 at 05:49:40PM +0200, Santi B=E9jar wrote:
>  git branch::
> +	list all local branches
> +git branch -r::
> +	list all remote branches
> +git branch -a::
>  	list all branches

I think I dropped this just because "remote branches" haven't yet been
introduced at this point in the manual.  (That's not till "Examining
branches from a remote repository".)  Could be some sections should be
reordered--suggestions welcomed.

> +-------------------------------------------------
> +$ git diff HEAD
> +-------------------------------------------------
> +
> +shows the difference between the working tree and HEAD.
> +

I took the mention of this later on, but didn't think it was necessary
to mention here too.

> @@ -1872,10 +1880,7 @@ As with git-fetch, you may also set up configu=
ration options to
>  save typing; so, for example, after
> =20
>  -------------------------------------------------
> -$ cat >.git/config <<EOF
> -[remote "public-repo"]
> -	url =3D ssh://yourserver.com/~you/proj.git
> -EOF
> +$ git config remote."public-repo".url ssh://yourserver.com/~you/proj=
=2Egit
>  -------------------------------------------------

I think this was adequately discussed.

> +You can also instantly browse your working repository in gitweb usin=
g:
> +
> +-------------------------------------------------
> +$ git instaweb
> +-------------------------------------------------
> +
> +See gitlink:git-instaweb[1] for details.
> +

That's nifty, but doesn't seem necessary at this point, and doesn't
quite fit in the section (which is about public repositories).

Others look good, thanks.

But if you want whole patches applied or rejected with explanation, I
think you may have to be prepared to revise and resubmit when there are
objections to parts.

--b.
