From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] i18n: mark OPTION_NUMBER (-NUM) for translation
Date: Tue, 05 Feb 2013 09:07:49 -0800
Message-ID: <7vd2weu1sq.fsf@alter.siamese.dyndns.org>
References: <883efc2358a0deb48bee48134d45ddd528a732d3.1360080194.git.worldhello.net@gmail.com> <20130205121552.GA16601@lanh> <883efc2358a0deb48bee48134d45ddd528a732d3.1360080194.git.worldhello.net@gmail.com> <8d6d4d869ea58e0a26b3bb6377fc102728948997.1360080194.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 18:08:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2m0F-0006NV-Qh
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 18:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883Ab3BERHx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 12:07:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49819 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754949Ab3BERHw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 12:07:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74760B213;
	Tue,  5 Feb 2013 12:07:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=z5oFDqi6uyFV
	BSYyQ4MHPcWMd1s=; b=g62Z6p5HbvsVZI8h60s8WDafswmc3+R76yKlF5p9AUBS
	LDmFer4jv2IndQSyBoC4tUgoLFtUiWQc2eLZgnVO8p8VrCR15y3W7Xb86I6F8y3f
	v4gzHab/W+DFj8n21pRfyl3X2aHImMqOKpIRlY/E4k7CQrN+0oicMmSWvH4UbX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=erMZY2
	ala/oLD8/06S8p4XJFRHJVoeRVzYC+2PotQypfbCKSgrkIBOMH11WnFzQYPKrzB1
	LGSpNRXS9BXEbRZCwNTFaagE7jRw61Szw67t6GeGnVaHU/awy/TMCUrxBNrzJqHD
	G9hpbKLYRFpLafilgNdLw5KFgxFUtL/5Pyu3Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68BFCB212;
	Tue,  5 Feb 2013 12:07:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3CE5B210; Tue,  5 Feb 2013
 12:07:50 -0500 (EST)
In-Reply-To: <8d6d4d869ea58e0a26b3bb6377fc102728948997.1360080194.git.worldhello.net@gmail.com> (Jiang Xin's message of "Wed, 6 Feb 2013 00:16:56 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 928EFFD4-6FB6-11E2-AD69-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215521>

Jiang Xin <worldhello.net@gmail.com> writes:

> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  parse-options.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index cd029f..be916 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -497,6 +497,8 @@ static int usage_with_options_internal(struct par=
se_opt_ctx_t *ctx,
>  				       const struct option *opts, int full, int err)
>  {
>  	FILE *outfile =3D err ? stderr : stdout;
> +	const char *opt_num_buff =3D _("-NUM");
> +	int opt_num_size =3D utf8_strwidth(opt_num_buff);
> =20
>  	if (!usagestr)
>  		return PARSE_OPT_HELP;
> @@ -544,8 +546,10 @@ static int usage_with_options_internal(struct pa=
rse_opt_ctx_t *ctx,
>  			pos +=3D fprintf(outfile, ", ");
>  		if (opts->long_name)
>  			pos +=3D fprintf(outfile, "--%s", opts->long_name);
> -		if (opts->type =3D=3D OPTION_NUMBER)
> -			pos +=3D fprintf(outfile, "-NUM");
> +		if (opts->type =3D=3D OPTION_NUMBER) {
> +			fputs(opt_num_buff, outfile);
> +			pos +=3D opt_num_size;
> +		}

I somehow suspect that this is going in a direction that makes this
piece of code much less maintainable.

Look at the entire function and see how many places you do fprintf
on strings that are marked with _().  short_name and long_name are
not likely to be translated, but everything else is, especially
multiple places that show _(opts->help) neither of these patches
touch.

I wonder if it makes more sense to add a helper function that
returns the number of column positions (not bytes) with a signature
similar to fprintf() and use that throughout the function instead.
