From: Junio C Hamano <junkio@cox.net>
Subject: Re: totorial-2 Re: (unknown)
Date: Sun, 21 May 2006 17:35:46 -0700
Message-ID: <7vfyj2hp5p.fsf_-_@assigned-by-dhcp.cox.net>
References: <1148255528.61d5d241.1@fieldses.org>
	<1148255528.61d5d241.2@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 02:36:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhyP5-0006RN-HZ
	for gcvg-git@gmane.org; Mon, 22 May 2006 02:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWEVAfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 20:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWEVAfs
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 20:35:48 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:31980 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932287AbWEVAfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 20:35:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060522003547.ZAMI19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 May 2006 20:35:47 -0400
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <1148255528.61d5d241.2@fieldses.org> (J. Bruce Fields's message
	of "Sun, 21 May 2006 19:53:28 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20471>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> From nobody Mon Sep 17 00:00:00 2001
> From: J. Bruce Fields <bfields@citi.umich.edu>
> Date: Sun, 21 May 2006 19:49:34 -0400
> Subject: [PATCH 3/3] tutorial: add discussion of index file, object database

Thanks.  I like the changes to tutorial.txt too btw.

> @@ -0,0 +1,391 @@
> +A tutorial introduction to git: part two
>...
> +and the contents of these files is just the compressed data plus a
> +header identifying their length and their type.  The type is either a
> +blob, a tree, a commit, or a tag.  We've seen a blob and a tree now,
> +so next we should look at a commit.
>...
> +Besides blobs, trees, and commits, the only remaining type of object
> +is a "tag", which we won't discuss here; refer to gitlink:git-tag[1]
> +for details.

We have created a tag in tutorial#1, so it _might_ make sense to
just tell the user to cat-file it.

> +------------------------------------------------
> +$ git diff
> +--- a/file.txt
> ++++ b/file.txt
> +@@ -1 +1,2 @@
> + hello world!
> + +hello world, again
> +$ git update-index file.txt
> +$ git diff
> +------------------------------------------------

Is the second line of the diff " +" intentional?  The same
comment to the example that immediately follows this part.
