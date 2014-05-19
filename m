From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RelNotes/2.0.0.txt: Fix several grammar issues, notably a lack of hyphens, double quotes, or articles
Date: Mon, 19 May 2014 16:46:35 -0700
Message-ID: <xmqq1tvpuyas.fsf@gitster.dls.corp.google.com>
References: <1400297434-30254-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Tue May 20 09:48:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmXGp-0000aa-FI
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 01:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbaESXqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 19:46:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51417 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbaESXqm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 19:46:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E308619237;
	Mon, 19 May 2014 19:46:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8ZeWDNVXn2Vv0SGTM3Oq94ha/mY=; b=GUin5o
	w4MQ0oOD6ZCamQrfuFYxG98UqSWlFGLXXaUCprGHRMN7qSYQ/C6NBvqu058uxFqh
	yh/tIpPnHS2GF2HQNPsDHrE5TKm2J2HC/bGCODjdYypchzyNVmVc7YJftPr+Qp/O
	kDg9XOqSUkGYiTbMVlDw2dX+/SRfvSouAkxcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I3sKie0V4g9kKtnMX46h1hvtrFS2623Q
	hzR2M6GBDkH0TxrdOsie7rFR9pNy4KdEhkq5sPV/TEUgUTPuSJOEXAxdeXBk6wvT
	EHDXlEz8ZrmB/ZUzFPCK/su3LfIgbVnPWGuWAdNdca6PUJEoPMI6ytBP8HejW1gI
	7eeTdzBmonQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D949219236;
	Mon, 19 May 2014 19:46:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CF2AD1921D;
	Mon, 19 May 2014 19:46:36 -0400 (EDT)
In-Reply-To: <1400297434-30254-1-git-send-email-jstjohn@purdue.edu> (Jason
	St. John's message of "Fri, 16 May 2014 23:30:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D0EB61CC-DFAF-11E3-8284-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jason St. John" <jstjohn@purdue.edu> writes:

> Signed-off-by: Jason St. John <jstjohn@purdue.edu>
> ---

Please accept "Thanks" for all the hunks I won't comment below; they
looked correct to me.

> @@ -53,7 +53,7 @@ Updates since v1.9 series
>  UI, Workflows & Features
>  
>   * The "multi-mail" post-receive hook (in contrib/) has been updated
> -   to a more recent version from the upstream.
> +   to a more recent version from upstream.

Hmph, I have only one multi-mail upstream; shouldn't I call it "the"
upstream from my point of view?

> @@ -63,12 +63,13 @@ UI, Workflows & Features
>     single strand-of-pearls is broken in its output.
>  
>   * The "rev-parse --parseopt" mechanism used by scripted Porcelains to
> -   parse command line options and to give help text learned to take
> +   parse command-line options and to give help text learned to take

We seem to have 30 "command line option" in Documentation/ vs 16
"command-line option", but this is two words used as an adjective,
and it may read better with the dash in between.

Thanks.

> @@ -190,20 +191,20 @@ notes for details).
>  
>   * The remote-helper interface to fast-import/fast-export via the
>     transport-helper has been tightened to avoid leaving the import
> -   marks file from a failed/crashed run, as such a file that is out of
> -   sync with the reality confuses a later invocation of itself.
> +   marks file from a failed/crashed run, as such a file that is out-of-
> +   sync with reality confuses a later invocation of itself.

Likewise, but I somehow think this is borderline; the spelling
without hyphen is used frequently enough.

> @@ -217,7 +218,7 @@ notes for details).
>   * "git diff --no-index -Mq a b" fell into an infinite loop.
>     (merge ad1c3fb jc/fix-diff-no-index-diff-opt-parse later to maint).
>  
> - * "git fetch --prune", when the right-hand-side of multiple fetch
> + * "git fetch --prune", when the right-hand side of multiple fetch
>     refspecs overlap (e.g. storing "refs/heads/*" to

Hmph, I read this as a "right-hand", a multi-word adjective, is used
to describe one "side" (the other side being the "left-hand side").
Otherwise, you would be writing command-line-option, no?

> - * Codepaths that parse timestamps in commit objects have been
> + * Code paths that parse timestamps in commit objects have been
>     tightened.
>     (merge f80d1f9 jk/commit-dates-parsing-fix later to maint).

We seem to spell this as one-word in the documentation too often,
but "Code path" is the right form, I agree.
