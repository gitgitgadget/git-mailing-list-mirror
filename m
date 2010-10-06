From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve the "diff --git" format documentation
Date: Wed, 06 Oct 2010 10:22:11 -0700
Message-ID: <7vk4lv44os.fsf@alter.siamese.dyndns.org>
References: <201010061823.47475.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Wed Oct 06 19:22:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3XhF-00075h-44
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 19:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab0JFRWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 13:22:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab0JFRWV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 13:22:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 615F8DCBAB;
	Wed,  6 Oct 2010 13:22:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bJB3ckmZTtf3I3hDKBx9I5L0c2Y=; b=nKBLzt
	k+HFzL/7a68J/m1WDti04qEKLirk90izTwcGo9u/Um0/udipFLU0wQRHjaOvp/y2
	UmvIpboywIZIxq84P/uVC5VUVnSeSr6V7EiKrcE5cvt9/r3a5gAe99petaAyrvU0
	JACkzyzD+gezVBWu9iFSD4egQY/YtfCgltEqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CLPWATfhlOQRR/1r7guV30R3X9IkfA/L
	lJnGhlql9MoYw4i7CqX+pD43P2NcmX/NKfQaJS9QDz1E6Prnk/xCgpSwqhGjVfgB
	0qWoujEmYmIwAMHwKhxjXlbzwqGwCSbRlJkDldBc3+rjnGC/tZiUu2WqFDLN6MtR
	up63ohs6iTg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C467DCBA1;
	Wed,  6 Oct 2010 13:22:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F372DCB9D; Wed,  6 Oct
 2010 13:22:13 -0400 (EDT)
In-Reply-To: <201010061823.47475.agruen@suse.de> (Andreas Gruenbacher's
 message of "Wed\, 6 Oct 2010 18\:23\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 43FADA84-D16E-11DF-932C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158297>

Andreas Gruenbacher <agruen@suse.de> writes:

> Hello,
>
> here is a small improvement to the documentation of git's extended diff
> format.  Can this please be included?
>
> Thanks,
> Andreas
>
> Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
> ---

I thought you have been here long enough to send a patch with some more
meaningful log message than that.  Could you objectively describe in what
way is it an "improvement" on the subject line?

>  Documentation/diff-generate-patch.txt |   23 ++++++++++++++++++++++-
>  1 files changed, 22 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-
> generate-patch.txt
> index 8f9a241..05f2164 100644
> --- a/Documentation/diff-generate-patch.txt
> +++ b/Documentation/diff-generate-patch.txt
> @@ -18,7 +18,8 @@ diff format.
>  +
>  The `a/` and `b/` filenames are the same unless rename/copy is
>  involved.  Especially, even for a creation or a deletion,
> -`/dev/null` is _not_ used in place of `a/` or `b/` filenames.
> +`/dev/null` is _not_ used in place of `a/` or `b/` filenames in the
> +`diff --git` line.

With a bit more context, the original reads like this:

    What the -p option produces is slightly different from the traditional
    diff format.

    1.   It is preceded with a "git diff" header, that looks like
         this:

           diff --git a/file1 b/file2
    +
    The `a/` and `b/` filenames are the same unless rename/copy is
    involved.  Especially, even for a creation or a deletion,
    `/dev/null` is _not_ used in place of `a/` or `b/` filenames.

I think the first sentence makes it clear that this section is about '"git
diff" header', without repeating it like your patch does.

> @@ -38,11 +39,31 @@ the file that rename/copy produces, respectively.
>         dissimilarity index <number>
>         index <hash>..<hash> <mode>
>  
> +    Path names in extended header lines do not include the `a/` and `b/`
> +    prefixes.  The index header includes the <mode> only if the file
> +    mode does not change; otherwise, explicit mode headers are included.
> +

Have you looked at generated output in man and html formats?  I suspect
that it needs some asciidoc formatting magic, similar to what we already
have for the first section (namely, no indent, but the new block is marked
as a continuation with a lone plus sign at the beginning, instead of being
separated by a blank line).

>  3.  TAB, LF, double quote and backslash characters in pathnames
>      are represented as `\t`, `\n`, `\"` and `\\`, respectively.
>      If there is need for such substitution then the whole
>      pathname is put in double quotes.
>  
> +    Space characters are not quoted and so when files are copied or
> +    renamed, the file names in the "diff --git" line can be
> +    ambiguous.

Why do you even need to say that, especially after you made it clear that
rename information is available in the extended header section in an
unambiguous form?

> +4.  All the `a/` files refer to files before the commit, and all the `b/`
> +    files refer to files after the commit; it is incorrect to apply the
> +    changes to each file sequentially.  For example, this patch will
> +    swap a and b:
> +
> +      diff --git a/a b/b
> +      rename from a
> +      rename to b
> +      diff --git a/b b/a
> +      rename from b
> +      rename to a
> +
>  The similarity index is the percentage of unchanged lines, and
>  the dissimilarity index is the percentage of changed lines.  It
>  is a rounded down integer, followed by a percent sign.  The

The new section is a worthwhile addition; I however think this addition
makes the description of the similarity/dissimilarity indices further from
the section it relates to (it logically is part of section 2), so perhaps
it should move 3. down and add 4. while at it.

Thanks.
