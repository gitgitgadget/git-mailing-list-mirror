From: Junio C Hamano <junkio@cox.net>
Subject: Re: first impressions to git
Date: Sun, 18 Sep 2005 15:09:32 -0700
Message-ID: <7vk6he110j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509181201220.23242@iabervon.org>
	<20050918211855.GA1463@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 00:10:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH7MP-0005dv-OB
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 00:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVIRWKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 18:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVIRWKA
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 18:10:00 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60919 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932213AbVIRWKA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 18:10:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050918220934.PWS25410.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Sep 2005 18:09:34 -0400
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
In-Reply-To: <20050918211855.GA1463@schottelius.org>
	(nico-linux-git@schottelius.org's message of "Sun, 18 Sep 2005
	23:18:56 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8814>

Nico -telmich- Schottelius <nico-linux-git@schottelius.org> writes:

> [22:29] hydrogenium:git-core-0.99.6% ls git-update-*
> git-update-cache  git-update-server-info
>
> http://www.kernel.org/pub/software/scm/git/docs/tutorial.html (v0.99.5, Aug 2005):
>
> "The first step is trivial: when you want to tell git about any changes to your working tree, you use the git-update-index program."

This is my fault.  The on-line documentation on kernel.org
always follow what is in the "master" branch that is a bit ahead
of the last released version.

Also, the version number on each of the page does not
necessarily match the version of the software -- it gets updated
to reflect the version of the last update of the doc, so the
pages reachable from git.html show different versions.

But still when you saw us talk about "git-update-index" and saw
you only have "git-update-cache", you could have looked at
git.html documentation page and find out that it says the
command git-update-index was previously known as
git-update-cache.

>> .git/description is actually a gitweb feature, not a core git feature. 
>> You'd only set it up for public repositories that you want to describe.
>
> That does not fit to what I see here:
>
> [22:46] hydrogenium:gpm% git-init-db 
> defaulting to local storage area
> [22:46] hydrogenium:gpm% ls .git 
> branches  description  HEAD  hooks  info  objects  refs  remotes

You two are both right.  Git itself does not look at
description, but just as a convenience it shows where to put
that file if you ever want to publish it from its built-in
templates.

>> ".git/remotes" is the current one; ".git/branches" is obsolete.
>
> Will .git/branches be complety removed later?

That is what the word deprecated usually means.  For now both
are supported.
