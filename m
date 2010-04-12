From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Docs: Add -X option to git-merge's synopsis.
Date: Mon, 12 Apr 2010 09:45:42 -0700
Message-ID: <7v39z0livd.fsf@alter.siamese.dyndns.org>
References: <1271089693-21365-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 18:46:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Mls-0004v0-Gm
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 18:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672Ab0DLQpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 12:45:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab0DLQpt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 12:45:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A732AAA574;
	Mon, 12 Apr 2010 12:45:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eD669s+7HwitjEnyIyEfVzsQrnM=; b=Wgq4e1
	ExQv1Y9Wb5Im8i86pRaIPPmWuWjKb/6f+1iEdxdqwNKEXdL3F8vNjirOQx0E98eJ
	N5uv8lLA4J7/Z0bcxVZx7xn+GTHEG3EsTOnQ2h6DmLBzTDcC3o5Y/h1fymnAH+Ji
	2N6BAuWGXQuxPUO3MpfyXK3c/xT+O6mI/eu5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rc5oB4r2CBw6vnKKUQWI+I3fYjEIRDgE
	1ah3XFnhOS6USckWN5fxYz/koGBHJadakhiq36PSvWvgGEeChKnX9c4jT6VjsdWr
	k9b8s2jbjVaH49ETmr4Q5Nleh3qsLpQb/SJ16ay39N72ziGPkKKQyptojvfKxsHO
	5VlPaZHdifg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A9A3AA572;
	Mon, 12 Apr 2010 12:45:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD2E4AA56E; Mon, 12 Apr
 2010 12:45:43 -0400 (EDT)
In-Reply-To: <1271089693-21365-1-git-send-email-marcnarc@xiplink.com> (Marc
 Branchaud's message of "Mon\, 12 Apr 2010 12\:28\:13 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7AC81B2-4652-11DF-AA9E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144755>

Marc Branchaud <marcnarc@xiplink.com> writes:

> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 9c9618c..ceec787 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -9,7 +9,8 @@ git-merge - Join two or more development histories together
>  SYNOPSIS
>  --------
>  [verse]
> -'git merge' [-n] [--stat] [--no-commit] [--squash] [-s <strategy>]...
> +'git merge' [-n] [--stat] [--no-commit] [--squash]...
> +	[-s <strategy>] [-X <strategy-option>]...
>  	[--[no-]rerere-autoupdate] [-m <msg>] <commit>...
>  'git merge' <msg> HEAD <commit>...

Good.

> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 37ce9a1..722d704 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -62,6 +62,11 @@ option can be used to override --squash.
>  	is used instead ('git merge-recursive' when merging a single
>  	head, 'git merge-octopus' otherwise).
>  
> +-X <option>::
> +--strategy-option=<option>::
> +	Pass merge strategy specific option through to the merge
> +	strategy.
> +
>  --summary::
>  --no-summary::
>  	Synonyms to --stat and --no-stat; these are deprecated and will be
> @@ -76,8 +81,3 @@ ifndef::git-pull[]
>  --verbose::
>  	Be verbose.
>  endif::git-pull[]
> -
> --X <option>::
> ---strategy-option=<option>::
> -	Pass merge strategy specific option through to the merge
> -	strategy.
> -- 

This is somewhat imcomplete; the current merge-options.txt seems to be
organized more-or-less alphabetically (begins with "commit", ascends to
"ff", "log", "s-something", and ends with "X"), but it has acquired
additions at random places (e.g. "ff-only").

I do not think reorganizing the option descriptions in functional groups
is a bad idea, and if we make that an overall goal of our documentation
set, the patch is certainly going in the right direction.

I used to prefer alphabetical order slightly over functional grouping
because it would make things easier to find in printed pages, but these
days people read on paper a lot less often, so I am personally fine with
"do not list options in alphabetical order; group them with related
features, and do so consistently across all manual pages".

So I'll take the patch as is, but before going further I would like to
first see list concensus to such a reorganization.

Thanks.
