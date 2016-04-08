From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] l10n: mv.c: add a comma ',' to string
Date: Fri, 08 Apr 2016 13:35:29 -0700
Message-ID: <xmqq8u0nvnxq.fsf@gitster.mtv.corp.google.com>
References: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
	<1460145765-7454-6-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:35:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aod7z-0005Vn-9o
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 22:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758726AbcDHUfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 16:35:33 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753927AbcDHUfc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 16:35:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B4345530B9;
	Fri,  8 Apr 2016 16:35:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h5WvjhYxjRhs8Yu7D8yTvqWH7PY=; b=PpsRcF
	KZ0189lzIQl2PWLUFLt0dj0RNgvO7J0+oXQPRFCEmY9QHrT3qi4VYayLKahqcRZZ
	omCrhkzG2UbgR5ihCjOq9b7FGuV8Yg2WdwdQ27JB87RmaDJJavQVaBavQXljb0I9
	ewrvyH0C58NSh7s638FsfhY1aQo0VtAreIl10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZxzZMqfNKXQDIgEv4YYYGOcPJ5WMJ5Cy
	HIsOhN0X/Ofg2pWCuodvvODNbMxBlE6lwNR2O4p9OsBQ+mDGadHvrP5uoi6gxYxs
	+9s98klICwyAz2oOGKmn7ffmFH1++dT4JjMlHuDR1p+rjhVWk1Ja5lCnTdDoAEs6
	NTTbCQzh4sQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9EBD9530B8;
	Fri,  8 Apr 2016 16:35:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C54B530B7;
	Fri,  8 Apr 2016 16:35:30 -0400 (EDT)
In-Reply-To: <1460145765-7454-6-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Fri, 8 Apr 2016 20:02:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6FCD677A-FDC9-11E5-9475-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291071>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Add a comma to string marked for translation. Make the string match the
> one in rm.c. Now translators have do handle this string only once.

I suspect these "comma after Please" is a French invention.

Aiming to reduce these minor variants is a good goal, but wouldn't
we want to go in the opposite direction?

>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  builtin/mv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index aeae855..1bf8df1 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -69,7 +69,7 @@ static void prepare_move_submodule(const char *src, int first,
>  	if (!S_ISGITLINK(active_cache[first]->ce_mode))
>  		die(_("Directory %s is in index and no submodule?"), src);
>  	if (!is_staging_gitmodules_ok())
> -		die(_("Please stage your changes to .gitmodules or stash them to proceed"));
> +		die(_("Please, stage your changes to .gitmodules or stash them to proceed"));
>  	strbuf_addf(&submodule_dotgit, "%s/.git", src);
>  	*submodule_gitfile = read_gitfile(submodule_dotgit.buf);
>  	if (*submodule_gitfile)
