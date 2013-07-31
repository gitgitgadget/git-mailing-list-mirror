From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename advice.object_name_warning to objectNameWarning
Date: Wed, 31 Jul 2013 15:19:43 -0700
Message-ID: <7vmwp2tls0.fsf@alter.siamese.dyndns.org>
References: <bc52a7d4a5f1010e6813ddf503a0b84976dc55e4.1375301985.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 01 00:19:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ekJ-0003eV-Lw
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 00:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757679Ab3GaWTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 18:19:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48907 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757226Ab3GaWTr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 18:19:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B068635BAA;
	Wed, 31 Jul 2013 22:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QS7XVbjm21ZHzFJDD0jFqsqs5r8=; b=eEYySF
	YUesJJxgoh24d8/1RMNRw4ebEYGSbqU1nZiYNq5kWVFfePTH/P7xtqTvhkHea04H
	5Evt9tKkYEjDgkrG6TCtmSpPnd2wowwsutrAb8Nq639z6zStljAqi2y8D1BY9otV
	HTRSiFVB0j9S1mi9md6w/abrm+V2xcn2H2aRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h0x5G3hAfY/ge82SsoauuxsXJbRUUaJO
	N9IjDRDIJjTseLFQIhz2Ud1rZ7S1YtTpMryuEKmzKlHFGk+TkwfZ6B3CQ2OHCW6s
	EvCs/UILH+nYPZPMS5rr73yPgETh49m7ii4ZXU7lOZc/rbhlkHSOGzg/5U9+bMev
	kFhp7nYFdHU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A578235BA9;
	Wed, 31 Jul 2013 22:19:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA51935BA5;
	Wed, 31 Jul 2013 22:19:45 +0000 (UTC)
In-Reply-To: <bc52a7d4a5f1010e6813ddf503a0b84976dc55e4.1375301985.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Wed, 31 Jul 2013 22:23:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E5D85FC-FA2F-11E2-81CD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231471>

Thomas Rast <trast@inf.ethz.ch> writes:

> We spell config variables in camelCase instead of with_underscores.
>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>
> I figure since we don't have the variable in any release yet *and* the
> worst possible outcome is that someone sees the advice message again,
> the consistency is worth the change.

Thanks, I agree.
>
>  advice.c    | 2 +-
>  sha1_name.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/advice.c b/advice.c
> index 2a52098..3eca9f5 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -35,7 +35,7 @@
>  	{ "implicitidentity", &advice_implicit_identity },
>  	{ "detachedhead", &advice_detached_head },
>  	{ "setupstreamfailure", &advice_set_upstream_failure },
> -	{ "object_name_warning", &advice_object_name_warning },
> +	{ "objectnamewarning", &advice_object_name_warning },
>  	{ "rmhints", &advice_rm_hints },
>  
>  	/* make this an alias for backward compatibility */
> diff --git a/sha1_name.c b/sha1_name.c
> index 1d210e3..852dd95 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -445,7 +445,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  	"\n"
>  	"where \"$br\" is somehow empty and a 40-hex ref is created. Please\n"
>  	"examine these refs and maybe delete them. Turn this message off by\n"
> -	"running \"git config advice.object_name_warning false\"");
> +	"running \"git config advice.objectNameWarning false\"");
>  	unsigned char tmp_sha1[20];
>  	char *real_ref = NULL;
>  	int refs_found = 0;
