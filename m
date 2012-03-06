From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rerere: document 'remaining' command
Date: Tue, 06 Mar 2012 11:24:28 -0800
Message-ID: <7vwr6xsfbn.fsf@alter.siamese.dyndns.org>
References: <1331036512-7626-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martin.von.zweigbergk@gmail.com
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 20:24:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4zzx-0004fn-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 20:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758350Ab2CFTYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 14:24:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41084 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758133Ab2CFTYb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 14:24:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D03D5E5C;
	Tue,  6 Mar 2012 14:24:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bz0qtAmX/1qhBYQXrED3ioAXmjg=; b=S8PyW1
	nZPrVQpTT+cvpvXTUfBDN9ak6VIUAm1Cn2KMVCqJif+bCdaHNt+LrquMJzfawwG3
	LfMAXjm1HXH3dnUXELGwCqRpH9AemogkUPlqUcJPBR6bO7XzWO7JC5kNtNnldQar
	pWJAS5qAMuCQ7eRBip1vqxvGhqoFjNaTq1bOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=isBsfRmsfy1Mqbmw8mhWFIa+eMV377be
	HRNonJWRaohkFhJ8Lrjc1HcROomxxLzDK/B5WTb3Gm7sQ9/N2MtMo7tF4eWrMMHG
	mY3yYrMJWLc8w6ggoT3KCbBCZe4w9+PLcOK0m5i01K4QQjBBq40RmbUFb/2U3NkR
	yKr4NbYHagg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54A915E5B;
	Tue,  6 Mar 2012 14:24:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA4BD5E5A; Tue,  6 Mar 2012
 14:24:29 -0500 (EST)
In-Reply-To: <1331036512-7626-1-git-send-email-vfr@lyx.org> (Vincent van
 Ravesteijn's message of "Tue, 6 Mar 2012 13:21:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FECD811E-67C1-11E1-BD6B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192377>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> From: Vincent van Ravesteijn <vfr@lyx.org>
>
> This adds the 'remaining' command to the documentation of
> 'git rerere'. This command was added in ac49f5ca (Feb 16 2011;
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>) but
> it was never documented.
>
> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
> ---
>  Documentation/git-rerere.txt |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
> index a6253ba..b75d34b 100644
> --- a/Documentation/git-rerere.txt
> +++ b/Documentation/git-rerere.txt
> @@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
>  SYNOPSIS
>  --------
>  [verse]
> -'git rerere' ['clear'|'forget' <pathspec>|'diff'|'status'|'gc']
> +'git rerere' ['clear'|'forget' <pathspec>|'diff'|'remaining'|'status'|'gc']
>  
>  DESCRIPTION
>  -----------
> @@ -53,6 +53,14 @@ useful for tracking what has changed while the user is resolving
>  conflicts.  Additional arguments are passed directly to the system
>  'diff' command installed in PATH.
>  
> +'remaining'::
> +
> +Like 'diff', but this only prints the unresolved filenames. This

What aspect of 'rerere remaining' is like 'rerere diff'?

In general, people should think twice after writing "Like X, but Y"
and try to come up with a more clear description that does not have
to force the user to read about X and then selectively forget what
he just read and replace it with Y. This is especially true when the
Y part is significantly different from what X does.

Another phrase to watch out for when writing documentation is "X. In
other words, Y."  People do this after writing X and finding it hard
to understand and necessary to explain in easier terms.  Reading it
again without "X. In other words, " often yields a better description.

	'remaining'::

        Print paths with conflicts that are not resolved.

Should be sufficient, I think.

In fact, wouldn't this be more or less equivalent to "ls-files -u"
without anything other than name part?
