From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: clarify documentation of dcommit sub-command
Date: Wed, 09 May 2012 10:19:36 -0700
Message-ID: <7vpqadtgpj.fsf@alter.siamese.dyndns.org>
References: <1336398527-4363-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch,
	Eric Wong <normalperson@yhbt.net>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 19:19:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSAYC-0006aA-P9
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 19:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760432Ab2EIRTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 13:19:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56862 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755333Ab2EIRTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 13:19:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65CCD6234;
	Wed,  9 May 2012 13:19:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d03sk1cbx5ExekX62f/SBqeFLe4=; b=wbAzdX
	x8+0X9PibYDffQLdvRJJru+lnXDLcT9DcgvwXOaQnTAZY44tAupYZlkc9Rcw3r8G
	XHj/DypckNCstl+0Hn73vZhaMg7S24vzwNByPcYpsNuz0mW47SAqX2/RleayG+Mz
	5veEMTpsgf8SJ97CpYQa+APh8auNT5Whsd3B0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jy37YXL0hlbPo4Wr4tgdeHmadj191fTf
	sDcZcPE6bNSu4p2owYwf38qliUImgPAi/RXnoroc4qTOCOvSQL085HyirmZmj/a9
	nIx94eRjELL+AR8Iv3osHEWsdsekiAKmMaAzXXdDHPrLS1a3I62lC3nZANnCvMMw
	l65cSB+9paA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D80A6233;
	Wed,  9 May 2012 13:19:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1DF56232; Wed,  9 May 2012
 13:19:37 -0400 (EDT)
In-Reply-To: <1336398527-4363-1-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Mon, 7 May 2012 19:18:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 278FD4D8-99FB-11E1-8FF0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197478>

Jon Seymour <jon.seymour@gmail.com> writes:

> Clarify that the optional "revision or branch" argument on dcommit
> sub-command refers to a git branch not an SVN branch.
>
> If the user's intent is to commit the current series of commits onto a
> specific SVN branch rather than the trunk, the existing wording might
> lead them to believe that the optional argument may be a means to
> achieve this.
>
> The rewording clarifies that the optional argument actually refers to
> the source git branch, not the target svn branch.
>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
>  Documentation/git-svn.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 34ee785..c516283 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -197,7 +197,7 @@ and have no uncommitted changes.
>  	pull or merge) your commits against the latest changes in the
>  	SVN repository.
>  	An optional revision or branch argument may be specified, and
> -	causes 'git svn' to do all work on that revision/branch
> +	causes 'git svn' to do all work on that git revision/branch
>  	instead of HEAD.
>  	This is advantageous over 'set-tree' (below) because it produces
>  	cleaner, more linear history.

I was going to apply this to my tree and send a "Thanks" with Cc: to Eric
to avoid double-application, but after reading the above again I started
to have doubt.  If the original were "on that branch" and the rephrasing
"on that git branch", I wouldn't have had any issue.

When a "git revision" and not a "git branch" is given as an optional
argument, what does the subcommand do?  Detach HEAD at that revision,
and do the usual "rebase on top of svn history and push it back" dance?
Perhaps "instead of HEAD" may want to be further rephrased, as in that
case it indeed is working on HEAD; it is just not the original commit your
HEAD pointed at before you issued the command.

Also, wouldn't it be easier to the readers if instead of this patch you
updated the beginning of the sentence to read "An optional git revision or
git branch name may be specified"?  After all, that is a more prominent
place to catch readers' eyes'.

Yet another issue.  The entire paragraph begins with this:

        Commit each diff from a specified head directly to the SVN
        repository, and then rebase or reset (depending on whether or
        not there is a diff between SVN and head).

What is "a specified head" here?  It makes it sound as if the "optional
revision or branch" is not optional at all and that is what specifies the
"head to be worked on", but that is not what is happening here, right?

Perhaps something like this?

'dcommit'::
	Commit each diff from the current branch directly to the SVN
	repository, and then rebase or reset (depending on ...
	...
	When an optional git branch name (or a git commit object name)
	is given, the subcommand works on the specified branch, not on
        the current branch.
