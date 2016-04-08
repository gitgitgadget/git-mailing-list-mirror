From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] l10n: unpack-trees: mark strings for translation
Date: Fri, 08 Apr 2016 13:23:09 -0700
Message-ID: <xmqqpotzvoia.fsf@gitster.mtv.corp.google.com>
References: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
	<1460145765-7454-2-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:23:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aocw2-0004gj-84
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 22:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207AbcDHUXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 16:23:13 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751522AbcDHUXM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 16:23:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5147552C9A;
	Fri,  8 Apr 2016 16:23:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lDjcjGW9lGH4GC1dBKQqKXHO31c=; b=cn/MiR
	Zy5MNMEHbqgOE/mM+iRfFBuH7Sje/eHq4/GzmS0mDHLNi6S8ALxH2soe3GBX2Sx3
	lF2b+27ebxFk7fW1JVPmydMSut9aUOZqTR3Y80N75rX2a5r2HxL3mfKhpiR1WSqn
	JZblZ7mbGLe+gOQKqekF3QeISylFbWztpS6gI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qFnYjszVeOvVtYnORitnaFS7Es+9Wy+u
	EjmLF0vk93Ft2IXDgjSxv1WclDMzW+i9fwM/j54B8nqVt52pmy0/MaydjTveE5NN
	UOmc7f6lNHnRXj/a4Xaj1aNuxQMt1AxY4aXHF55XILDjJp8ETZ04eGtxhoRZbGcJ
	3H/MReLpKus=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 48D7152C98;
	Fri,  8 Apr 2016 16:23:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B9E3552C90;
	Fri,  8 Apr 2016 16:23:10 -0400 (EDT)
In-Reply-To: <1460145765-7454-2-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Fri, 8 Apr 2016 20:02:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B68E19B8-FDC7-11E5-9094-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291067>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Mark strings seen by the user inside setup_unpack_trees_porcelain() and
> display_error_msgs() functions for translation.
>
> One case Git outputs the named strings is when the user does some editing to
> a file on some branch and then checks out other branch, but that file
> changes by the checkout. This is the case of the first string marked.

The second paragraph puzzling.  Other strings are not shown at all?
Or is it just you didn't bother explaining the others cases?

Either case, it is not immediately clear why you felt that one
string among others deserve more attention.  Care to elaborate?

In the patch itself I did not find anything questionable, though.

Thanks.

>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  unpack-trees.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 9f55cc2..4bc6b4f 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -61,21 +61,21 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>  	const char *cmd2 = strcmp(cmd, "checkout") ? cmd : "switch branches";
>  
>  	if (advice_commit_before_merge)
> -		msg = "Your local changes to the following files would be overwritten by %s:\n%%s"
> -			"Please, commit your changes or stash them before you can %s.";
> +		msg = _("Your local changes to the following files would be overwritten by %s:\n%%s"
> +			"Please, commit your changes or stash them before you can %s.");
>  	else
> -		msg = "Your local changes to the following files would be overwritten by %s:\n%%s";
> +		msg = _("Your local changes to the following files would be overwritten by %s:\n%%s");
>  	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
>  		xstrfmt(msg, cmd, cmd2);
>  
>  	msgs[ERROR_NOT_UPTODATE_DIR] =
> -		"Updating the following directories would lose untracked files in it:\n%s";
> +		_("Updating the following directories would lose untracked files in it:\n%s");
>  
>  	if (advice_commit_before_merge)
> -		msg = "The following untracked working tree files would be %s by %s:\n%%s"
> -			"Please move or remove them before you can %s.";
> +		msg = _("The following untracked working tree files would be %s by %s:\n%%s"
> +			"Please move or remove them before you can %s.");
>  	else
> -		msg = "The following untracked working tree files would be %s by %s:\n%%s";
> +		msg = _("The following untracked working tree files would be %s by %s:\n%%s");
>  
>  	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrfmt(msg, "removed", cmd, cmd2);
>  	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrfmt(msg, "overwritten", cmd, cmd2);
> @@ -84,14 +84,14 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>  	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
>  	 * cannot easily display it as a list.
>  	 */
> -	msgs[ERROR_BIND_OVERLAP] = "Entry '%s' overlaps with '%s'.  Cannot bind.";
> +	msgs[ERROR_BIND_OVERLAP] = _("Entry '%s' overlaps with '%s'.  Cannot bind.");
>  
>  	msgs[ERROR_SPARSE_NOT_UPTODATE_FILE] =
> -		"Cannot update sparse checkout: the following entries are not up-to-date:\n%s";
> +		_("Cannot update sparse checkout: the following entries are not up-to-date:\n%s");
>  	msgs[ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN] =
> -		"The following Working tree files would be overwritten by sparse checkout update:\n%s";
> +		_("The following Working tree files would be overwritten by sparse checkout update:\n%s");
>  	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
> -		"The following Working tree files would be removed by sparse checkout update:\n%s";
> +		_("The following Working tree files would be removed by sparse checkout update:\n%s");
>  
>  	opts->show_all_errors = 1;
>  	/* rejected paths may not have a static buffer */
> @@ -168,7 +168,7 @@ static void display_error_msgs(struct unpack_trees_options *o)
>  		string_list_clear(rejects, 0);
>  	}
>  	if (something_displayed)
> -		fprintf(stderr, "Aborting\n");
> +		fprintf(stderr, _("Aborting\n"));
>  }
>  
>  /*
