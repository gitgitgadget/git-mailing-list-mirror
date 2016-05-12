From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 6/7] i18n: builtin/rm.c: remove a comma ',' from string
Date: Thu, 12 May 2016 14:05:50 -0700
Message-ID: <xmqqtwi3c7gx.fsf@gitster.mtv.corp.google.com>
References: <1463083168-29213-1-git-send-email-vascomalmeida@sapo.pt>
	<1463083168-29213-7-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Thu May 12 23:06:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0xny-0005Pm-QJ
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 23:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbcELVFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 17:05:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752033AbcELVFy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 17:05:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F01FB1A9B8;
	Thu, 12 May 2016 17:05:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E10WCPB7GjWCo0l2Ftqp3mK2VZE=; b=PMd537
	Xc7XYeSPH12zemj8IQSkeUUtu72bl5x59MQ3Q3bXnFU0Y2v1u2WvhBgbv48LIk17
	mGuDR/sMrBA8vixnqYCob78OLLxOQAFGIW2UA/vsOIxJqp85yC0gDv0zvCa/Rz7O
	PmEK7O0VLFyZHB3P39ucY8jF6veLyPsfnN+rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lUIo20dHzovTj3OnDPB6xzox5IXaU6au
	l4+RuA8QnJfYFDuz6ZEwq0B7jP0pbN4RUB1HOVQmtk+ZPwmwnLkktvAmZiQq94St
	QKwp9LAa/EG5gayY6UoUAL76nQP8TFBK3/1qGM5bwof9jNkmI5e7v39NUO1zG6er
	4o0xwQZYiyw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E531B1A9B6;
	Thu, 12 May 2016 17:05:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 538DD1A9B5;
	Thu, 12 May 2016 17:05:53 -0400 (EDT)
In-Reply-To: <1463083168-29213-7-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Thu, 12 May 2016 19:59:27 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 50046EDA-1885-11E6-9425-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294477>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Remove a comma from string marked for translation. Make the string match the
> one in builtin/mv.c. Now translators have do handle this string only once.
>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---

Looks good.  BTW, I think you just added two more "Please," in
"i18n: unpack-trees" patch by repeating a set of very similar
messages.

>  builtin/rm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 8829b09..be83c43 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -314,7 +314,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  		list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
>  		if (list.entry[list.nr++].is_submodule &&
>  		    !is_staging_gitmodules_ok())
> -			die (_("Please, stage your changes to .gitmodules or stash them to proceed"));
> +			die (_("Please stage your changes to .gitmodules or stash them to proceed"));
>  	}
>  
>  	if (pathspec.nr) {
