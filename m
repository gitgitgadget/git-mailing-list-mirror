From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/15] user-manual: Add a few references to 'git
 rebase -i'
Date: Sun, 10 Feb 2013 13:53:45 -0800
Message-ID: <7vzjzbsumu.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <4931d9fc83155b29787a3d33a7ac87dbfaa04795.1360508415.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:54:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4eqm-00059u-W9
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 22:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756760Ab3BJVxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 16:53:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756415Ab3BJVxx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 16:53:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 486F6B4AF;
	Sun, 10 Feb 2013 16:53:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J62Dv7ZoSNVdZJ6OoZy4iW3SPM4=; b=ILTAjv
	/coheC8+NHDhGVxrY/KhO8QvkI7FrRcdLr06j8f6Ly1B6ijhvNVnqmkhrC9efD2p
	/tio2wF7zZuM1u2rwazaNaPlAXsUx85jmuysLXVIdAsWEylacj79bDORI/hsmsuE
	BUtb0mpn43fTlQTK6ESLZPjYuMIzhbHH9P5jw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dhn7gr1dMlL1/mlR3UraAPUruE88xL5H
	S0EoG4dlDtkGUWp5bpj/7Z3YiKiZFs+Rzj46mIWrGTo7NLp413zGBNknf+bLNw6R
	CtYLYclLhMhoHk82Wq0O3cQMLQryLdMbHzvtPd9dzJjYuSjtbgBQHY5a9JOEtDTE
	VemDiXs2EC0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CC6EB49E;
	Sun, 10 Feb 2013 16:53:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C50CB489; Sun, 10 Feb 2013
 16:53:50 -0500 (EST)
In-Reply-To: <4931d9fc83155b29787a3d33a7ac87dbfaa04795.1360508415.git.wking@tremily.us>
 (W. Trevor King's message of "Sun, 10 Feb 2013 10:10:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A8E7B72-73CC-11E2-9D02-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215940>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> I think this interface is much more convenient than extended cherry
> picking or using 'git format-patch'.  Inserting a number of references
> should raise awareness among new users.  The previously discussed
> methods (cherry picking and format-patch-ing) are still useful,
> because all of these approaches have the same effect, which may help
> demystify the process for newbies.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/user-manual.txt | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index a8f792d..5d80b40 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -2532,6 +2532,13 @@ return mywork to the state it had before you started the rebase:
>  $ git rebase --abort
>  -------------------------------------------------
>  
> +If you need to reorder or edit a number of commits in a branch, it may
> +be easier to use `git rebase -i`, which allows you to reorder and
> +squash commits, as well as marking them for individual editing during
> +the rebase.  See linkgit:git-rebase[1] for details, and
> +<<reordering-patch-series>> for alternatives.
> +
> +

This change is very good (modulo the extra blank line at the end).

>  [[rewriting-one-commit]]
>  Rewriting a single commit
>  -------------------------
> @@ -2546,10 +2553,10 @@ $ git commit --amend
>  which will replace the old commit by a new commit incorporating your
>  changes, giving you a chance to edit the old commit message first.
>  
> -You can also use a combination of this and linkgit:git-rebase[1] to
> -replace a commit further back in your history and recreate the
> -intervening changes on top of it.  First, tag the problematic commit
> -with
> +You can also use a combination of `commit --amend` and
> +linkgit:git-rebase[1] (see <<using-git-rebase>>) to replace a commit
> +further back in your history and recreate the intervening changes on
> +top of it.  First, tag the problematic commit with

I think this section can use a lot more love.  There is no reason to
have "bad" tag (tagging the tip of mywork might have made sense in
the old days without detached HEAD or reflog), for example.

Alternatively, we can explain only the amending of the tip commit in
this section, removing everything else; I think that is probably a
better option.  The series of sections around here would then look
like:

 * The section before this talked about a straight-forward "rebase";

 * This section then talks about "commit --amend", nothing else;

 * The next section talks about taking "format-patch A..B", flipping
   its output around and applying to A.  Enhance that section with
   the material to be removed from here, which talks about applying
   "format-patch A..B" on top of the amended A.

 * Then add a separate section after that "Reordering or selecting
   from a patch series" section to discuss "rebase -i".

Hmm?

>  -------------------------------------------------
>  $ git tag bad mywork~5
> @@ -2584,6 +2591,12 @@ new commits having new object names.
>  Reordering or selecting from a patch series
>  -------------------------------------------
>  
> +There are a number of ways you can go about editing an existing patch
> +series.  The easiest way is probably by using `git rebase -i`,
> +mentioned in <<using-git-rebase>>, but whether you use
> +linkgit:git-rebase[1] or one of the methods discussed below, the
> +effect is the same.  Pick whichever approach you like best.
> +
>  Given one existing commit, the linkgit:git-cherry-pick[1] command
>  allows you to apply the change introduced by that commit and create a
>  new commit that records it.  So, for example, if "mywork" points to a
