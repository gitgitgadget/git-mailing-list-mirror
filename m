From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/22] builtin/config.c: mark strings for translation
Date: Mon, 29 Feb 2016 10:25:23 -0800
Message-ID: <xmqqegbvcr1o.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:25:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSVf-0003Yz-AM
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbcB2SZ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 13:25:27 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751298AbcB2SZ0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 13:25:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4423D47112;
	Mon, 29 Feb 2016 13:25:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xNgQ9uGieK5x
	YUQ8KAlK7/m1MJQ=; b=J3zbaq2N3cbBw/ppmLrVumsf7LXnY1aghh4rhFz/jpNu
	A7n++5H9IH8fAXUc1f5X+om+wcw0U+T6XyIoa8hbyVqrhdjkD45zSJBf0+hcA605
	R3duhklR74sPwBfHRfQpFDjflOrVSLP/hUKv5xhaTD9yPAclJ0thKr7+2mAGAEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=T5/2lv
	OqGF0kgjTayEpsjOKDwWiTXRn/KcehYsUD3RPWNe+EiyajaBuZ57u3WL0AANe6Jb
	D0k+EOYXyqBoW+ZnOgvDTz2JVeh7L9lz0BwwXg7ngs/7VNMzh9qxsE0WktEWbxVV
	Tm2UBq1v9piw33erjzx0RMDAojH7kLr1wpwfc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3AD1647110;
	Mon, 29 Feb 2016 13:25:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AB8644710E;
	Mon, 29 Feb 2016 13:25:24 -0500 (EST)
In-Reply-To: <1456555333-5853-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:41:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CCBE7F0E-DF11-11E5-A906-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287857>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

This does look like a "new i18n bug" introduced in this cycle, but
given that this program does not have much _() in the first place,
I'm inclined to say we should do the whole thing post 2.8.0 release
for this file, discarding this patch.

>  builtin/config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index ca9f834..98ca43d 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -378,7 +378,7 @@ static int get_colorbool(const char *var, int pri=
nt)
>  static void check_write(void)
>  {
>  	if (!given_config_source.file && !startup_info->have_repository)
> -		die("not in a git directory");
> +		die(_("not in a git directory"));
> =20
>  	if (given_config_source.use_stdin)
>  		die("writing to stdin is not supported");
