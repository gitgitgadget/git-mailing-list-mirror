From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] enums: remove trailing ',' after last item in enum
Date: Wed, 09 Jul 2014 07:59:40 -0700
Message-ID: <xmqqr41u7f37.fsf@gitster.dls.corp.google.com>
References: <1404325445-17914-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 16:59:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4tLd-0006Ai-Jj
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 16:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495AbaGIO7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 10:59:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64793 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537AbaGIO7t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 10:59:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9EF1D2586B;
	Wed,  9 Jul 2014 10:59:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ykj0WbbESptMkv4xBiOMDqB4GQ8=; b=oxk8BF
	g7hfzuT0GDvtpjJbZUxta8BSjwHl/1XnsW3PQIyjaWG6WSA7eRy1odpuGX7Hl3z+
	/PvWlaRa4lHatRxtukj+d4LCs649Lkeqw1zTScQoHqtQQlBrHYdcbw3okTnbVo0K
	OZzSRz4q0Typ3gDwW0P0kDgZRo1dhEonMQ2wE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JnEa5TtOV2owo/CKhLXVCkT3dMgOEkgJ
	4Cm9KPLRTKi3mdBLSH2JNZNaFWFxZ0dSkFXDTkm4KRU3eXmqcHQuB9uEGzh7OA0N
	uRpqoiAoRSGuDhXVzLEC1nnALxvEzvhP9zvuh/84Q4JIeqP34gXGnnEcSOCGRGwS
	SYcPHXFv624=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9675F2586A;
	Wed,  9 Jul 2014 10:59:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CC1B825853;
	Wed,  9 Jul 2014 10:59:26 -0400 (EDT)
In-Reply-To: <1404325445-17914-1-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 2 Jul 2014 11:24:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9F078C34-0779-11E4-AD4A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253128>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---

Looks good; thanks.

>  builtin/clean.c | 2 +-
>  builtin/tag.c   | 2 +-
>  pretty.c        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 9a91515..27701d2 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -48,7 +48,7 @@ enum color_clean {
>  	CLEAN_COLOR_PROMPT = 2,
>  	CLEAN_COLOR_HEADER = 3,
>  	CLEAN_COLOR_HELP = 4,
> -	CLEAN_COLOR_ERROR = 5,
> +	CLEAN_COLOR_ERROR = 5
>  };
>  
>  #define MENU_OPTS_SINGLETON		01
> diff --git a/builtin/tag.c b/builtin/tag.c
> index c6e8a71..ef76556 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -83,7 +83,7 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
>  enum contains_result {
>  	CONTAINS_UNKNOWN = -1,
>  	CONTAINS_NO = 0,
> -	CONTAINS_YES = 1,
> +	CONTAINS_YES = 1
>  };
>  
>  /*
> diff --git a/pretty.c b/pretty.c
> index 4f51287..924bc61 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -274,7 +274,7 @@ static void add_rfc822_quoted(struct strbuf *out, const char *s, int len)
>  
>  enum rfc2047_type {
>  	RFC2047_SUBJECT,
> -	RFC2047_ADDRESS,
> +	RFC2047_ADDRESS
>  };
>  
>  static int is_rfc2047_special(char ch, enum rfc2047_type type)
