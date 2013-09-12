From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Developer's Certificate of Origin:  default to COPYING
Date: Thu, 12 Sep 2013 15:30:22 -0700
Message-ID: <xmqqy571n05d.fsf@gitster.dls.corp.google.com>
References: <1379023862-29953-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Richard Hansen <rhansen@bbn.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 13 00:30:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKFPE-0006NW-3x
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 00:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232Ab3ILWa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 18:30:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754769Ab3ILWa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 18:30:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A33E41F74;
	Thu, 12 Sep 2013 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dIyGw6VaOomPqr+kH/trNvdPpws=; b=eBeDlt
	beSkCn05lWZP16ozJ2rBJJ3C7D+stCXof5utmrnk7zXg9SkNZ9reneZM23tTTPIb
	RjI8Jne9FjWuwV/sMmdoGtJ/dATO4xWG39NkwM1hs8uwaQzVDIdeTP0U27nmTmXD
	h70DfcIHKMH95mofCzBFmR0LIAiGUaukdWlV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tks2J10nTfsjMV2+Fee6TAJafHQI5J/F
	ROIYQC80geYhkOkk5k5NLcgdPQhc+uwl8xStVTjsHXOSlQbVhHf9Gg8LNpAxuuOq
	p7VJiKD5DYb4vivYC6lJj6QDnf2HIs/Xzm+GjhTP9XLrO9CVuq4SgtiQ/3kbKE+e
	GADs/d29DF4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E1E241F73;
	Thu, 12 Sep 2013 22:30:27 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6543841F41;
	Thu, 12 Sep 2013 22:30:25 +0000 (UTC)
In-Reply-To: <1379023862-29953-1-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Thu, 12 Sep 2013 18:11:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EB49B696-1BFA-11E3-80BC-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234708>

Linus, this is not limited to us, so I am bothering you; sorry about
that.

My instinct tells me that some competent lawyers at linux-foundation
helped you with the wording of DCO, and we amateurs shouldn't be
mucking with the text like this patch does at all, but just in case
you might find it interesting...


Richard Hansen <rhansen@bbn.com> writes:

> The "Developer's Certificate of Origin" refers to "the open source
> license indicated in the file", but there is no such indication in
> most files in the Git repository.
>
> Update the text to indicate that the license in COPYING should be
> assumed if a file doesn't excplicitly indicate which license applies
> to the file.
>
> The phrase "accompanies the file" was chosen to support different
> default licenses in different subdirectories (e.g., 2-clause BSD for
> vcs-svn/*, LGPL2.1+ for xdiff/*).
>
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
> I'm bringing this up because, to this layman's eyes, it seems like a
> potentially troublesome oversight.  IIUC, one of the purposes of the
> Developer's Certificate of Origin is to make it easy for developers to
> declare which license covers a contribution.  Requiring a license
> declaration protects the project and its users from copyright
> litigation.
>
> What happens if the file(s) being modified do not indicate which
> license applies to the file?  Is there no license?  Does it default to
> the main project license in COPYING?  This lack of clarity makes me a
> bit nervous (law is already too nondeterministic for my liking), so
> I'd like to see a change that makes it explicit.
>
> Notes:
>   * I am not a lawyer.  (Maybe a lawyer should be consulted?)
>   * This change might not be necessary.
>   * This change might be wrong.
>   * I hope I'm not just wasting everyone's time by bringing this up.
>
>  Documentation/SubmittingPatches | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 7055576..c5ff744 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -227,13 +227,15 @@ the patch, which certifies that you wrote it or otherwise have
>  the right to pass it on as a open-source patch.  The rules are
>  pretty simple: if you can certify the below:
>  
> -        Developer's Certificate of Origin 1.1
> +        Developer's Certificate of Origin 1.2
>  
>          By making a contribution to this project, I certify that:
>  
>          (a) The contribution was created in whole or in part by me and I
>              have the right to submit it under the open source license
> -            indicated in the file; or
> +            indicated in the file (or, if no license is indicated in
> +            the file, the license in COPYING that accompanies the
> +            file); or
>  
>          (b) The contribution is based upon previous work that, to the best
>              of my knowledge, is covered under an appropriate open source
> @@ -241,7 +243,8 @@ pretty simple: if you can certify the below:
>              work with modifications, whether created in whole or in part
>              by me, under the same open source license (unless I am
>              permitted to submit under a different license), as indicated
> -            in the file; or
> +            in the file (or, if no license is indicated in the file,
> +            the license in COPYING that accompanies the file); or
>  
>          (c) The contribution was provided directly to me by some other
>              person who certified (a), (b) or (c) and I have not modified
