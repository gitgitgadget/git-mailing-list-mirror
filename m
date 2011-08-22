From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Grammar and wording fixes in gitrepository-layout
Date: Mon, 22 Aug 2011 11:09:36 -0700
Message-ID: <7vk4a5wc67.fsf@alter.siamese.dyndns.org>
References: <1313808187-1666-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 20:09:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvYwV-00078Z-KU
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 20:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab1HVSJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 14:09:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435Ab1HVSJm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 14:09:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 293414D02;
	Mon, 22 Aug 2011 14:09:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NPsmTOXXNNGH70ocMrfvsurf/LY=; b=FpzGSQ
	hN5HgS/A1Djbckw+peT0mUlKpA8iJQjZvEfuds7sPFMAZ3O4BPDJ8BUsH4LGx7Oh
	N7P3T186TzSTLQy8CXrdAVw1m+GRDaQ6CM6NXU/tXI/o2M0Km4SYtilwaeS/Iz3Z
	xHLEI5GxBy5QQu8v+W82ftfgqzqW+A+k6gETw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xGhqPW91QJhJQeCYGHbyr0hyamNovS85
	Z+hNmf4bPO+xN1iyvRlj8OBuf6+6/GsdzNhHfmOJ702ueLABYbT+9CwlTvN3YEk3
	kWpUtWlprA4wMWoOQ22ZYc2tv+Q0tnwUfgudvdXXTprdjia+oRUTxt0zU8d1JaAx
	jyxX/Idypmg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20AA14D01;
	Mon, 22 Aug 2011 14:09:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 729444D00; Mon, 22 Aug 2011
 14:09:40 -0400 (EDT)
In-Reply-To: <1313808187-1666-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Fri, 19 Aug 2011 22:43:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E784D1A6-CCE9-11E0-94D0-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179876>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> This patch corrects a few grammar issues in gitrepository-layout.txt
> and also rewords a few sections for clarity.

Thanks, Ben.

I notice that there are issues, not introduced with your patch, that we
may want to address further, though.

> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
> ---
>  Documentation/gitrepository-layout.txt |   46 +++++++++++++++----------------
>  1 files changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
> index eb3d040..02a6167 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -23,32 +23,30 @@ objects::
>  	Object store associated with this repository.  Usually
>  	an object store is self sufficient (i.e. all the objects
>  	that are referred to by an object found in it are also
> -	found in it), but there are couple of ways to violate
> -	it.
> +	found in it), but there are a few ways to violate it.
>  +
>  . You could populate the repository by running a commit walker
> -without `-a` option.  Depending on which options are given, you
> +without `-a` option.  Depending on the options given, you
>  could have only commit objects without associated blobs and
>  trees this way, for example.  A repository with this kind of
>  incomplete object store is not suitable to be published to the
> -outside world but sometimes useful for private repository.
> +outside world but is sometimes useful in a private repository.

Here "a commit walker" refers to the "http-fetch" dumb http walker, which
was unclear and confusing even to me, but more importantly, I wonder if we
even want to condone the use of it to break the repository integrity in
such a way that other tools in git toolset do not even give support.

Other items in this list, namely shallow-clone and borrowing objects from
alternates, are supported configurations in which .git/objects do _not_
have all the objects, but "http-fetch without -a" that pulls in commits
without their associated trees and blobs do not even pass "fsck" and worse
yet cannot be "fixed" later by fetching missing objects on top, like
a shallow clone does by allowing deepening it later.

Perhaps we should deprecate http-fetch without -a and drop this item from
the list?

> +. You could be using the `objects/info/alternates` or
> +`$GIT_ALTERNATE_OBJECT_DIRECTORIES` mechanisms to 'borrow'
>  objects from other object stores.  A repository with this kind
>  of incomplete object store is not suitable to be published for
> -use with dumb transports but otherwise is OK as long as
> -`objects/info/alternates` points at the right object stores
> -it borrows from.
> +use with dumb transports but is otherwise OK as long as
> +`objects/info/alternates` points at the right object stores.

The last three words in the original are meant to clarify and define what
"the right object stores" are. Was there a compelling reason to drop them?

>  objects/[0-9a-f][0-9a-f]::
>  	Traditionally, each object is stored in its own file.

I would suggest further rewording this to something like:

	A newly created object is stored in its own file.

> @@ -120,15 +118,15 @@ HEAD::
>  HEAD can also record a specific commit directly, instead of
>  being a symref to point at the current branch.  Such a state
>  is often called 'detached HEAD', and almost all commands work
> -identically as normal.  See linkgit:git-checkout[1] for
> +as they normally would.  See linkgit:git-checkout[1] for
>  details.

We may want to reword the sentence that begins with "almost all commands"
further. In the early days after detached HEAD support was introduced, we
may have left cases where the result was _undefined_ for commands that
would not make sense unless you are on a branch, but by now what we have
should behave sensibly by either erroring out when the operation does not
make sense unless you are on a real branch, or doing something useful.

>  branches::
>  	A slightly deprecated way to store shorthands to be used
> -	to specify URL to 'git fetch', 'git pull' and 'git push'
> -	commands is to store a file in `branches/<name>` and
> -	give 'name' to these commands in place of 'repository'
> -	argument.
> +	to specify a URL to 'git fetch', 'git pull' and 'git push'.
> +	A file can be stored as `branches/<name>` and then
> +	'name' can be givent to these commands in place of

s/givent to/given to/

> +	'repository' argument.

We would at least need "See linkgit:..." to say what is expected in this
file and how it is used (the information is in urls-remotes.txt but that
is not a top-level file, so it needs to refer to git-fetch and git-push
instead).

> @@ -173,9 +171,9 @@ info/exclude::
>  	at it.  See also: linkgit:gitignore[5].
>  
>  remotes::
> -	Stores shorthands to be used to give URL and default
> -	refnames to interact with remote repository to
> -	'git fetch', 'git pull' and 'git push' commands.
> +	Stores shorthands for URL and default refnames for use
> +	when interacting with remote repositories via 'git fetch',
> +	'git pull' and 'git push' commands.

Likewise.

Also I would personally consider "branches" and "remotes" both "slightly
deprecated". "git init", "git clone", and "git remote" stopped populating
these long time ago.
