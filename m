From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stripspace: Call U+0020 a "space" instead of a "blank"
Date: Tue, 09 Feb 2016 14:24:30 -0800
Message-ID: <xmqqvb5x1q01.fsf@gitster.mtv.corp.google.com>
References: <1454037056-26355-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: tklauser@distanz.ch, Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 23:24:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTGi5-0006YJ-RP
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 23:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133AbcBIWYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 17:24:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932434AbcBIWYd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 17:24:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BD8A14239D;
	Tue,  9 Feb 2016 17:24:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uZQ5p6w964gAWVOVkD1AIOKc+G0=; b=q/+NRR
	bWxxcqahjKYyguKhh4aDvGsBXEkihKJWzzNoBlwiFfJbn0zInkA+yPuqssCvJwhX
	+cFh5iLquBJohipHg65D7Kh3xJMeMXP10iFSz1GNwoQB/2V+FoMKpTTM+n1IT4bc
	v4Ozohw9hHv4YzQu9jV1z/4lZApT0LwSgKE9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dQrcr3EhHfY8TA193rudUHrMPeSk3QbG
	f/HP7OTY8B2tJDAdwaXXPNx7avZE76KZjz7VbnWXtLLapMddrD0HiEHGaKTpJM3/
	4rTeZ3w2DYHhouDWYVlGSwVV5emvpVtpthZn2Bib+hOOJdsctrg1Y2HsQ+yizH84
	86P8M4x+Hl4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B51A84239C;
	Tue,  9 Feb 2016 17:24:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2D85F4239B;
	Tue,  9 Feb 2016 17:24:32 -0500 (EST)
In-Reply-To: <1454037056-26355-1-git-send-email-alexhenrie24@gmail.com> (Alex
	Henrie's message of "Thu, 28 Jan 2016 20:10:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E440A74C-CF7B-11E5-83E7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285876>

Alex Henrie <alexhenrie24@gmail.com> writes:

> I couldn't find any other examples of people referring to this character
> as a "blank".
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---

Any comments on this from anybody other than the author that I
missed to support this change?

>  builtin/stripspace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/stripspace.c b/builtin/stripspace.c
> index 7ff8434..15e716e 100644
> --- a/builtin/stripspace.c
> +++ b/builtin/stripspace.c
> @@ -35,7 +35,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
>  			    N_("skip and remove all lines starting with comment character"),
>  			    STRIP_COMMENTS),
>  		OPT_CMDMODE('c', "comment-lines", &mode,
> -			    N_("prepend comment character and blank to each line"),
> +			    N_("prepend comment character and space to each line"),
>  			    COMMENT_LINES),
>  		OPT_END()
>  	};
