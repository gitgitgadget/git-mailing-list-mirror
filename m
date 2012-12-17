From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Sun, 16 Dec 2012 23:21:00 -0800
Message-ID: <7vhanlnnz7.fsf@alter.siamese.dyndns.org>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-2-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Ardill <andrew.ardill@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:21:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkV0s-0004sm-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 08:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116Ab2LQHVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 02:21:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34943 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab2LQHVE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 02:21:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 231039529;
	Mon, 17 Dec 2012 02:21:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FJ+S5gVf6kZ9VQoHxZ6woJTEemw=; b=lQpzMK
	DdAK+FjO6Dfp7SNYBOvL4w5LEjN9kQ6bkjYESToN78/fIDbj4Eyb7xm06amlIpp2
	xSVvBF6uiThk9JVC4lS4YohaGCiDGY1qwSYm0BsOYR5HEMMIv7ji3drBnBiDAg8U
	KFQIyAtIXPD+ODkkpNPSH6/6aEHE26HN2NxxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UTX9XnPQuVRg7XIBSm+gL0TV+BxQGkP/
	oQkONThTPWm7TbR3UpHyp4+fUEuMZZj824EhiJCbqkWWG0Ye8+N9FhKv8hHRaqjQ
	r4RzEFti3SgyRq2lXv+1e+IRxSjvEJYD0y6eDWT0uXADS3M+HMaYFs7YV4GFEVjs
	hTCAVbWEXdI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D9199528;
	Mon, 17 Dec 2012 02:21:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AF449525; Mon, 17 Dec 2012
 02:21:02 -0500 (EST)
In-Reply-To: <1355726702-27974-2-git-send-email-chris@rorvick.com> (Chris
 Rorvick's message of "Mon, 17 Dec 2012 00:45:01 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 500B7886-481A-11E2-AD43-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211645>

Chris Rorvick <chris@rorvick.com> writes:

> The forms of checkout that do not take a path are lumped together in the
> DESCRIPTION section, but the description for this group is dominated by
> explanation of the -b|-B form.  Split these apart for more clarity.
>
> Signed-off-by: Chris Rorvick <chris@rorvick.com>
> ---
>  Documentation/git-checkout.txt | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index 7958a47..a47555c 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -22,17 +22,18 @@ also update `HEAD` to set the specified branch as the current
>  branch.
>  
>  'git checkout' [<branch>]::
> +
> +	Update the index, working tree, and HEAD to reflect the
> +	specified branch.

This is to "check out the branch" ;-)

But of course, we cannot define "checkout" in terms of "checkout",
so we need to phrase it without saying "checkout" and explain what
it *means* to check out the branch.

I am not sure "Reflect" is a good word.  Making the result similar
to the branch is only one aspect of the act of checking out the
branch. The other equally important aspect is that this is done to
advance the history of the branch.

Perhaps...

	Prepare to work on building new history on <branch>, by
	pointing the HEAD to the branch and updating the index and
	the files in the working tree.  Local modifications to the
	files in the working tree are kept, so that they can be
	committed on the <branch>.

>  'git checkout' -b|-B <new_branch> [<start point>]::
>  
> +	Specifying `-b` causes a new branch to be created as if
> +	linkgit:git-branch[1] were called and then checked out.  In
> +	this case you can use the `--track` or `--no-track` options,
> +	which will be passed to 'git branch'.  As a convenience,
> +	`--track` without `-b` implies branch creation; see the
> +	description of `--track` below.
>  +
>  If `-B` is given, <new_branch> is created if it doesn't exist; otherwise, it
>  is reset. This is the transactional equivalent of
> @@ -45,6 +46,13 @@ $ git checkout <branch>
>  that is to say, the branch is not reset/created unless "git checkout" is
>  successful.
>  
> +'git checkout' [--detach] [<commit>]::
> +
> +	Update the index and working tree to reflect the specified
> +	commit and set HEAD to point directly to <commit> (see
> +	"DETACHED HEAD" section.)  Passing `--detach` forces this
> +	behavior even if <commit> is a branch.

	Prepare to work on building new history on top of <commit>,
        by detaching HEAD at the commit and ...(likewise)...
