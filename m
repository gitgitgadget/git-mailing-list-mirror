From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Document RUN_SETUP_GENTLY
Date: Wed, 30 Apr 2014 11:29:59 -0700
Message-ID: <xmqqeh0efz6g.fsf@gitster.dls.corp.google.com>
References: <CAE+yK_kwMWRBDEVO=WVh5H-uFQJa2LEezRwbKnduLqoFjWC4zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 20:30:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfZGr-0003N7-W4
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 20:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbaD3SaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 14:30:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759236AbaD3SaH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 14:30:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95D727DE6D;
	Wed, 30 Apr 2014 14:30:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v1QEOsbkseRpOKag4ZWr6JOj1Xk=; b=J13H45
	sCWc7XlGEpTvY4g3rZqNszWFFZDloTD4vFibjsHtZOc4NJdgEMJkI9p1AlC9+cEe
	XH7eD6cyHjKXed1MJmBYima/djnIpZ4YQy2AWjrfFZU3S/ZbSil6wDANbGifCSE1
	ULwUO1AEYdnKLesQLmFgKbmuZEFmOox/EhlaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BF2+ZYtMNf+i0muXFTGX7K5wG5bKLQOv
	WXtP5Ix+S+oD3uZdn4ub49Wqoi62HpufGxegoSMhJh7IgIjxuFH0A6DsWUc/zLnF
	Twr7UimV4Jrp6rqTYJ3hQa16OG+eTpT8HLc7y2/INSZS2YNjkwlCwbK1km+NBJuG
	mTxGlNKXLA4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 646D87DE6C;
	Wed, 30 Apr 2014 14:30:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2A1E7DE67;
	Wed, 30 Apr 2014 14:30:00 -0400 (EDT)
In-Reply-To: <CAE+yK_kwMWRBDEVO=WVh5H-uFQJa2LEezRwbKnduLqoFjWC4zA@mail.gmail.com>
	(David Turner's message of "Tue, 29 Apr 2014 15:21:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 708E00CE-D095-11E3-BBE8-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247754>

David Turner <dturner@twopensource.com> writes:

> Sorry about that -- the documentation of RUN_SETUP confused me.  So I
> have a new patch that edits that as well.
>
> --
> RUN_SETUP_GENTLY and improve RUN_SETUP docs
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---

You do not want to have "Sorry about that..." in your final commit
log message.  Please do the above this way if you wanted to:


	Sorry about that ...

	-- >8 --
	Subject: docs: document RUN_SETUP_GENTLY and clarify RUN_SETUP

	We only said what happens when we find the Git directory under
	RUN_SETUP, without saying what happens otherwise.

	Signed-off-by: ...
	---
        $DIFFSTAT
        $PATCH



>  Documentation/technical/api-builtin.txt | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/technical/api-builtin.txt
> b/Documentation/technical/api-builtin.txt
> index e3d6e7a..b250c1a 100644
> --- a/Documentation/technical/api-builtin.txt
> +++ b/Documentation/technical/api-builtin.txt
> @@ -23,10 +23,15 @@ where options is the bitwise-or of:
>
>  `RUN_SETUP`::
>
> - Make sure there is a Git directory to work on, and if there is a
> - work tree, chdir to the top of it if the command was invoked

Your mailer ate all the whitespaces and folded the lines, it seems.

I'll fix it up and queue the result on 'pu', so please eyeball it
and holler if I made a silly mistake while doing the fixup.

Thanks.


> - in a subdirectory.  If there is no work tree, no chdir() is
> - done.
> + If there is not a Git directory to work on, abort.  If there
> + is a work tree, chdir to the top of it if the command was
> + invoked in a subdirectory.  If there is no work tree, no
> + chdir() is done.
> +
> +`RUN_SETUP_GENTLY`::
> +
> + If there is a Git directory, chdir as per RUN_SETUP, otherwise,
> + don't chdir anywhere.
>
>  `USE_PAGER`::
