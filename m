From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: fix option name in error message
Date: Sun, 25 Oct 2015 23:29:34 -0700
Message-ID: <xmqqa8r6jg6p.fsf@gitster.mtv.corp.google.com>
References: <1445837340-4333-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Oct 26 07:29:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqbHu-0004sE-LW
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 07:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbbJZG3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 02:29:38 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752850AbbJZG3h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 02:29:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FC651FC08;
	Mon, 26 Oct 2015 02:29:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fVAXFjRRSYFvubxGEgmj6mO7XL0=; b=oZtmck
	+JQe8anXZF92nqhNBP3DR1fruFgPtVBvvv99IAhppA1cZUshvgUWtLJDsLz5fFE5
	NRip3P9ILZe1qjLvaeI7gYxkiJMOhztMR2azK89bU881yVYpr6yTljol6mXlfgIS
	BYdxsPEqBuLGHGLaQ500W23uD8rPrh/1UaNMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EXA3hSrhNWc7p2POXJLFoxx0F20V61mZ
	BGyIJ7UPYagIPwcTUGCArOIHPXsvLWhtQUNzr7FKUDBJnaB2eaD2oUHgGvySwlKd
	mf9N4T5ecwpLJRQEYvwNEY83S5HA6IxgUcxDCR3SpZhzXo2QyN1Q2l9AkHDPzYUH
	Xk1EFdodK7o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 87D851FC07;
	Mon, 26 Oct 2015 02:29:36 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1031C1FC05;
	Mon, 26 Oct 2015 02:29:35 -0400 (EDT)
In-Reply-To: <1445837340-4333-1-git-send-email-max@max630.net> (Max Kirillov's
	message of "Mon, 26 Oct 2015 07:29:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED5077C4-7BAA-11E5-B8FB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280182>

Max Kirillov <max@max630.net> writes:

> The option name used in blame's UI is `--reverse`.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---

;-)

It is surprising that nobody noticed this which was in the very
original of --reverse.  Thanks.

>  builtin/blame.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 98b1810..f89bc9e 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2697,7 +2697,7 @@ parse_done:
>  		sb.commits.compare = compare_commits_by_commit_date;
>  	}
>  	else if (contents_from)
> -		die("--contents and --children do not blend well.");
> +		die("--contents and --reverse do not blend well.");
>  	else {
>  		final_commit_name = prepare_initial(&sb);
>  		sb.commits.compare = compare_commits_by_reverse_commit_date;
