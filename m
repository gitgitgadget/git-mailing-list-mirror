From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix typo in remote set-head usage
Date: Mon, 26 Nov 2012 10:16:52 -0800
Message-ID: <7vwqx8rzzf.fsf@alter.siamese.dyndns.org>
References: <1353851019-27254-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tim.henigan@gmail.com,
	Jiang Xin <worldhello.net@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 19:17:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td3F5-0006yo-PO
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 19:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288Ab2KZSQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 13:16:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755123Ab2KZSQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 13:16:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D845B9C69;
	Mon, 26 Nov 2012 13:16:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xoCQXd9bN9Us++6cTtR+xRYmZio=; b=JfaR5E
	BtJ7COu4xTjDKwRSqeslZ2U9xIUcmnOsNpJlKM4AeiQNFIu9FxmGaXz6hndXwyXi
	m1aPqeyL6LPFmfbaCAVRjqtT3T4AZhl4LxAs44nBilbFJ/ZzZSzemwhGc3JdT91A
	73QyfGEQJzMs18DYUUv4yehZ6nJPKG14SiWg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hWcPT1ERA5fYQdR5/dghhqSpHzUSi9PM
	UNBS5fgKKGsjlvKHH0HApCuPhrAydw4K/04QU/4XNFNey9hK1z+6T7WY++UgZKo8
	IEmgX7pDLs9h/IZeUm2suHC5uFo35SzrQlHufLuz/+FKYbsWN2PbYTOp+8LWLbBa
	ZNkiQirHPOU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C57489C68;
	Mon, 26 Nov 2012 13:16:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36FFA9C66; Mon, 26 Nov 2012
 13:16:54 -0500 (EST)
In-Reply-To: <1353851019-27254-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Sun, 25 Nov 2012 14:43:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74E6D34C-37F5-11E2-B5AA-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210464>

Antoine Pelisse <apelisse@gmail.com> writes:

> parenthesis are not matching in `builtin_remote_sethead_usage`
> as a square bracket is closing something never opened.
> ---
> This will also break all translation files, should I also send a patch
> to update them ?

"git grep -A2 -e 'remote set-head <name>' po/" tells me that we
already have both the correct variant and the broken one, and they
are both translated ;-) so I do not think we have much to worry
about the i18n fallout in this case, but thanks anyway for thinking
about it.

You would need to sign off your patch, but otherwise looks good to
me.

Thanks.


>
> Cheers,
> Antoine Pelisse
>
>  builtin/remote.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index a5a4b23..937484d 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -39,7 +39,7 @@ static const char * const builtin_remote_rm_usage[] = {
>  };
>
>  static const char * const builtin_remote_sethead_usage[] = {
> -	N_("git remote set-head <name> (-a | -d | <branch>])"),
> +	N_("git remote set-head <name> (-a | -d | <branch>)"),
>  	NULL
>  };
>
> --
> 1.7.9.5
