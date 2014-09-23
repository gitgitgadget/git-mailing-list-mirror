From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: Remove miss leading comment
Date: Tue, 23 Sep 2014 11:31:38 -0700
Message-ID: <xmqq7g0ujiid.fsf@gitster.dls.corp.google.com>
References: <1411332586-18275-1-git-send-email-stefanbeller@gmail.com>
	<1411484150-18025-1-git-send-email-stefanbeller@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 20:31:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWUsS-00082y-Rt
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 20:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbaIWSbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 14:31:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58151 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbaIWSbr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 14:31:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BD03F3B3A8;
	Tue, 23 Sep 2014 14:31:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2GA5gLTyLZTkQYQB+SmgTxgp/DI=; b=T2V1eS
	RI6jB8kkj31SeABZ+ZjqdS6ZUgwZvbz97ZVxCXCAKbC7fG3SFqpgxy2Q5RE4cjyv
	NX4l+sVUJJQ3sprW7oUCCYG7/wnwdj/1zV+9rOE8lY556iinBOL8J0P1AEhv20+p
	Kx4RB675CgawA9RcKMZl0Bbx6DbdDNne5C4C4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OsQyEGHQTCAoLHz8BBPan8sHtHQ5x2Fu
	yHKILsym3UnEzesIkVhfLPG1OJQdCWEpLzPXE2aM5X8eQ1G2Zpy9VTHtqCjp4Ixf
	YAUj0unm98E7nEhSxXHvkwCbHpk74JusFXj9tKRl7oH8632C6vaG3nYEopxXcdz6
	VjjkmiKvP+Q=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B12DE3B3A7;
	Tue, 23 Sep 2014 14:31:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8E5773B3A5;
	Tue, 23 Sep 2014 14:31:40 -0400 (EDT)
In-Reply-To: <1411484150-18025-1-git-send-email-stefanbeller@gmail.com>
	(Stefan Beller's message of "Tue, 23 Sep 2014 16:55:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DC540858-434F-11E4-8B32-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257430>

Stefan Beller <stefanbeller@gmail.com> writes:

> Commented code, which doesn't even compile, is of no use any more?

Apparently that is meant to help debugging the code.  An alternative
would be to make it usable again, but removal is fine by me as well.

>
> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
> ---
>
> To be applied on top of sb/merge-recursive-copy-paste-fix
>
>
>  merge-recursive.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d63524c..8ad4be8 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1686,10 +1686,6 @@ static int merge_content(struct merge_options *o,
>  static int process_entry(struct merge_options *o,
>  			 const char *path, struct stage_data *entry)
>  {
> -	/*
> -	printf("processing entry, clean cache: %s\n", index_only ? "yes": "no");
> -	print_index_entry("\tpath: ", entry);
> -	*/
>  	int clean_merge = 1;
>  	int normalize = o->renormalize;
>  	unsigned o_mode = entry->stages[1].mode;
