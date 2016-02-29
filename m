From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/22] run-command.c: mark strings for translation
Date: Mon, 29 Feb 2016 10:52:48 -0800
Message-ID: <xmqq7fhnbb7j.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-17-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:52:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSwC-0001mS-0g
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbcB2Sww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 13:52:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751346AbcB2Swv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 13:52:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FFAE47946;
	Mon, 29 Feb 2016 13:52:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mQZgRabSanfy
	LHobkvo/yTL2FVo=; b=vgHcQ/VIUlIoMqk/UdlkIZiaWK/JOPz29jN+LQrjAK4V
	oG1/nLDEopBOtLyHr/3OPrz8HeSY9+3TyL7PlBzvJWsbhW5b03JDFzB6HhdCIz8e
	bsy9yTlnc95aElsqNwJ2kVeIQ5fuCsnYDA9dlTunoboky7LBYbW3oDbGPp6+Wh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dXOUCb
	f9fxBRSjLiWqaB/GP8S3ibEytVjZLe67bIUXyVfdM0Hm2oLTf3Q3PsMGuPRYZetA
	2KG3gqiViIz3Ks/Vumhh+WoTC/cf0j/y5IPd41Jhb/Kt6GU2yh7RwBAKpXzdmu7t
	BqQt8c/EkpsSULC5y0aoSa94kBOa8GS94iY6k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2655F47945;
	Mon, 29 Feb 2016 13:52:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 949F847944;
	Mon, 29 Feb 2016 13:52:49 -0500 (EST)
In-Reply-To: <1456555333-5853-17-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:42:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A12F7E70-DF15-11E5-A2BC-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287868>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

This is new and there aren't many non-BUG messages that are not
marked, so let's take this one for 2.8.0.


>  run-command.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 863dad5..1ee2357 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -909,7 +909,7 @@ static int default_start_failure(struct child_pro=
cess *cp,
>  {
>  	int i;
> =20
> -	strbuf_addstr(err, "Starting a child failed:");
> +	strbuf_addstr(err, _("Starting a child failed:"));
>  	for (i =3D 0; cp->argv[i]; i++)
>  		strbuf_addf(err, " %s", cp->argv[i]);
> =20
> @@ -927,7 +927,7 @@ static int default_task_finished(int result,
>  	if (!result)
>  		return 0;
> =20
> -	strbuf_addf(err, "A child failed with return code %d:", result);
> +	strbuf_addf(err, _("A child failed with return code %d:"), result);
>  	for (i =3D 0; cp->argv[i]; i++)
>  		strbuf_addf(err, " %s", cp->argv[i]);
