From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/22] trailer.c: mark strings for translation
Date: Mon, 29 Feb 2016 10:55:37 -0800
Message-ID: <xmqq37sbbb2u.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-20-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:56:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSz8-0003U1-6a
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbcB2Szq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 13:55:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753984AbcB2Szl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 13:55:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06F2247A09;
	Mon, 29 Feb 2016 13:55:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tiXhfrr0I/zs
	84BP1iDrmriKiuc=; b=fPqNzeemdzxihBL8LQFHpOpocF1ZS2DF/fzih2OYcbG7
	5oN/m3QBHkkZ0R5BungFlZDmIWxSkA3M1uFcPy/Cj6YMx5z3cYVm6DIeNPYdg4Hw
	ntOSEMptguRiEZR6r2D2cgRC8t+9c9AJbrE+DzxtF7JrIMEWp6tTcxJiMZOnBHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DhPrH1
	dZVwPUvWcKsncASZwL9Gqgx/uFSRCBb7kc+KQFHJW4bYmVd8JSNoVVl29gXgmdcp
	N8guuYiw+70C870XGrWlNSv7qXT5j2TV4JqlfB26LLmn+vaTewtehG8yk1v1EFlm
	ePhr2f9a03cvT8MtXzBiRSF3vNPA7RA+6fQeg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6B4F47A06;
	Mon, 29 Feb 2016 13:55:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6847E47A05;
	Mon, 29 Feb 2016 13:55:38 -0500 (EST)
In-Reply-To: <1456555333-5853-20-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:42:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 05CF0562-DF16-11E5-A7F9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287869>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

I'll take this one, even though it is quite old, as the file has a
serious amount of messages that are already marked.

>  trailer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/trailer.c b/trailer.c
> index 94b387b..8e48a5c 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -234,7 +234,7 @@ static const char *apply_command(const char *comm=
and, const char *arg)
>  	cp.use_shell =3D 1;
> =20
>  	if (capture_command(&cp, &buf, 1024)) {
> -		error("running trailer command '%s' failed", cmd.buf);
> +		error(_("running trailer command '%s' failed"), cmd.buf);
>  		strbuf_release(&buf);
>  		result =3D xstrdup("");
>  	} else {
