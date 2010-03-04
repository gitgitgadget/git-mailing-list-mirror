From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix indentation problem in git-ls-files(1)
Date: Thu, 04 Mar 2010 15:37:35 -0800
Message-ID: <7v3a0fr740.fsf@alter.siamese.dyndns.org>
References: <m2tyswb1jp.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Mar 05 02:35:40 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnLUU-00059M-Ng
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 01:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844Ab0CDXhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 18:37:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756794Ab0CDXho (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 18:37:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C8969FF78;
	Thu,  4 Mar 2010 18:37:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3ZMAvFbbOB/zyxhBUnkjDi3+H+0=; b=Fm2hTL
	aERn3s0vyyBwL+v/WjuZc1NVOQm6bNxomIxc86AXmz9o0KsHqKTPKJRnjd/PAdoa
	40I7G7tkI+HUxwzCl0fOsK1BQvc73WzvCmYB89b0k7c41X6oRSpWBWU/N9UaarkC
	g4+4JqWWTncNZDKqqrjnxFipsvM4ds6Cutup4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MWVh9d/w5rM2F2KoQFhfmvxCTt/rbdzN
	16xqtPbSiW5nZoamS7wIb43bLTvnpGcObqeHV+PgKMigMW6Qa/XaYU/rkw8/LU/z
	KSuY2EsNUn/MylsLumvl3Cph1F0+WovBJA06hW7I325EsvVbVeQ5Vi4LO7mXrXsj
	s+q+rSl22Lw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 393F49FF77;
	Thu,  4 Mar 2010 18:37:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 838CA9FF76; Thu,  4 Mar
 2010 18:37:37 -0500 (EST)
In-Reply-To: <m2tyswb1jp.fsf@igel.home> (Andreas Schwab's message of "Thu\,
 04 Mar 2010 15\:32\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EC216F02-27E6-11DF-89AE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141549>

Andreas Schwab <schwab@linux-m68k.org> writes:

> The nested list in the description of the -t option wasn't properly
> indented.  Additionally, make it a horizontal labeled list since the
> labels are all short.
>
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---

Thanks.

>  Documentation/git-ls-files.txt |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 3521637..c0dc3ec 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -108,13 +108,14 @@ OPTIONS
>  -t::
>  	Identify the file status with the following tags (followed by
>  	a space) at the start of each line:
> -	H::	cached
> -	S::	skip-worktree
> -	M::	unmerged
> -	R::	removed/deleted
> -	C::	modified/changed
> -	K::	to be killed
> -	?::	other
> +[horizontal]
> +	H:::	cached
> +	S:::	skip-worktree
> +	M:::	unmerged
> +	R:::	removed/deleted
> +	C:::	modified/changed
> +	K:::	to be killed
> +	?:::	other

Both [horizontal] and three colons are something we never have used in the
existing documentation set.  How confident are you that various versions
of deployed AsciiDoc people would use all support this?

I am not _complaining_; I am just being cautious to see if I have to look
into the issue myself (if your answer is "not at all") or not (otherwise).

Cf. http://thread.gmane.org/gmane.comp.version-control.git/139014/focus=139339
