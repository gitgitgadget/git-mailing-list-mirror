From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Thu, 10 Jun 2010 07:55:13 -0700
Message-ID: <7vy6enlyy6.fsf@alter.siamese.dyndns.org>
References: <4C0E5103.7030501@viscovery.net>
 <AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>
 <4C0E6810.3070301@viscovery.net>
 <AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>
 <4C0E932B.3010702@viscovery.net>
 <AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com>
 <4C0EB741.9020905@op5.se>
 <AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com>
 <20100610082916.GA5559@coredump.intra.peff.net>
 <AANLkTinLt3p0q-q5oDFk5CWzdhqQ2lwkWuvpdPzKZvYe@mail.gmail.com>
 <20100610085952.GA8269@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arntsen <tor@spacetec.no>, Brandon Casey <drafnel@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Dario Rodriguez <soft.d4rio@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 16:55:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMjAb-0000FT-4I
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 16:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759314Ab0FJOzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 10:55:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759300Ab0FJOze (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 10:55:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3695ABB7F3;
	Thu, 10 Jun 2010 10:55:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x4O3KTXQGwNxR8Gy4kzMVWEt6jA=; b=VLKCcO
	0U1k3tpyC5lVPkXM/ipvolXamtvOGi29P60E6983mrnBFEAm20d/T3otgq5xjJqA
	d1lB8urDtPvobERCT6+O8FcHck/zW0YpKAmlT1RvkyDXor2xV9WJeXJGRFzUK/Wc
	DBFnbY1z7mUiGuQ2icQabeN2DOogtICE4c1Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NQGzuNMPop8wRm9WNFB1laaaxkx9KYIK
	OnKtwHOnwkZOYqePsU+brdY3q6IThPRtvWEY2gjW3AgJfy0LsAQKmfazH6D4wjVv
	zNqEmsWfkVeXL/XXvPAiB+D72tOV7O1b4qmg98xr/qw59ZvlRZx810zslAfwEu1j
	g5/9ZuRSqkg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89918BB7F0;
	Thu, 10 Jun 2010 10:55:25 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DEB3BB7EB; Thu, 10 Jun
 2010 10:55:14 -0400 (EDT)
In-Reply-To: <20100610085952.GA8269@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 10 Jun 2010 04\:59\:52 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 33B143FA-74A0-11DF-ABD0-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148881>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] Makefile: default pager on AIX to "more"
>
> AIX doesn't ship with "less" by default, and their "more" is
> more featureful than average, so the latter is a more
> sensible choice.  People who really want less can set the
> compile-time option themselves, or users can set $PAGER.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 34b7dd5..6ad0aca 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -930,6 +930,7 @@ ifeq ($(uname_S),NetBSD)
>  	HAVE_PATHS_H = YesPlease
>  endif
>  ifeq ($(uname_S),AIX)
> +	DEFAULT_PAGER = more
>  	NO_STRCASESTR=YesPlease
>  	NO_MEMMEM = YesPlease
>  	NO_MKDTEMP = YesPlease

A very sensible approach.  Thanks.
