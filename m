From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Transaction patch series overview
Date: Tue, 26 Aug 2014 14:01:29 -0700
Message-ID: <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140826000354.GW20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 23:01:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMNs8-0006ju-U3
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 23:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbaHZVBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 17:01:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65053 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755125AbaHZVBk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 17:01:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5015F33B80;
	Tue, 26 Aug 2014 17:01:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pI/r8sZ2Pj1I1LMDxkKz0WG0O04=; b=bx99W8
	sOd5r3Y6rmfpTyx/H2pwYzZM3m5H/pjz/rGZ/wtAo0H9RRhqhmqu3ZQdhbK7202v
	dKUofjCE18oweZlyG/9s7a5apdx7doo5IrC7454HKhICWJuhFDiqOL+ubgA72GyL
	e42s1M5XcRw1omvXlmpVNBRZma947QuCLkuFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hnILNetAIt/XEqnGqTIyxgyJfkjqPhOL
	tgVifAY1cWeBhlL5+DChxcF69EmHqiUIHcTeCW3n/qaTSHssK23LL8kkTKs1fvtp
	YYm4D3HaT7hYi2n1FaWkqi0e80FYI7NlbrwB6wmkTH4SCc3O8+V1p3OFBrUbiX6d
	AzpaxCRedco=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 459DF33B7F;
	Tue, 26 Aug 2014 17:01:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 12A0A33B76;
	Tue, 26 Aug 2014 17:01:31 -0400 (EDT)
In-Reply-To: <20140826000354.GW20185@google.com> (Jonathan Nieder's message of
	"Mon, 25 Aug 2014 17:03:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2783C41E-2D64-11E4-A75C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255944>

Jonathan Nieder <jrnieder@gmail.com> writes:

>>  https://code-review.googlesource.com/#/q/topic:ref-transaction-1
>
> Outcome of the experiment: patches gained some minor changes and then
>
>  1-12
> 	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
>  13
> 	Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
> 	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
>  14
> 	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
>  15-16
> 	Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
> 	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
>  17
> 	Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
>
>  18
> 	Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
> 	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
>  19
> 	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
>  20
> 	Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
> 	Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> I found the web UI helpful in seeing how each patch evolved since I
> last looked at it.  Interdiff relative to the version in pu is below.

Thanks for the interdiff, it really helps to be able to take a
glance without having to click around.

It seems that I can hold the topic in 'pu' a bit longer and expect a
reroll from this effort before merging it to 'next'?

> The next series from Ronnie's collection is available at
> https://code-review.googlesource.com/#/q/topic:ref-transaction in case
> someone wants a fresh series to look at.

Thanks.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 668fa6a..9bf1003 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1765,8 +1765,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	transaction = ref_transaction_begin(&err);
>  	if (!transaction ||
>  	    ref_transaction_update(transaction, "HEAD", sha1,
> -				   current_head ?
> -				   current_head->object.sha1 : NULL,
> +				   current_head
> +				   ? current_head->object.sha1 : NULL,
>  				   0, !!current_head, &err) ||
>  	    ref_transaction_commit(transaction, sb.buf, &err)) {
>  		rollback_index_files();

Perhaps this is nicer, but probably most people would not care.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 91099ad..224fadc 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -580,18 +580,18 @@ static char *update(struct command *cmd, struct shallow_info *si)
>  
>  		if (shallow_update && si->shallow_ref[cmd->index] &&
>  		    update_shallow_ref(cmd, si))
> -			return xstrdup("shallow error");
> +			return "shallow error";
>  
>  		transaction = ref_transaction_begin(&err);
>  		if (!transaction ||
>  		    ref_transaction_update(transaction, namespaced_name,
>  					   new_sha1, old_sha1, 0, 1, &err) ||
>  		    ref_transaction_commit(transaction, "push", &err)) {
> -			char *str = strbuf_detach(&err, NULL);
>  			ref_transaction_free(transaction);
>  
> -			rp_error("%s", str);
> -			return str;
> +			rp_error("%s", err.buf);
> +			strbuf_release(&err);
> +			return "failed to update ref";
>  		}

I am guessing that the purpose of this change is to make sure that
cmd->error_string is taken from a fixed set of strings, not an
arbitrary collection of errors from the transaction subsystem, but
what is the significance of doing so?  Do the other side i18n while
running print_ref_status() or something?

> diff --git a/refs.h b/refs.h
> index aad846c..69ef28c 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -180,8 +180,7 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
>   */
>  #define REF_NODEREF	0x01
>  /*
> - * Locks any ref (for 'HEAD' type refs) and sets errno to something
> - * meaningful on failure.
> + * This function sets errno to something meaningful on failure.
>   */
>  extern struct ref_lock *lock_any_ref_for_update(const char *refname,
>  						const unsigned char *old_sha1,

To contrast this function with lock_ref_sha1() that only allowed
refs under refs/ hierarchy, the comment may have made sense, but now
that other function is gone, losing the comment makes sense.

I removed from the above the interdiff hunks I did not have any
comments or questions on.

Thanks again.
