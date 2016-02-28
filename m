From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/22] builtin/checkout.c: mark strings for translation
Date: Sun, 28 Feb 2016 11:00:15 -0800
Message-ID: <xmqqziukek3k.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 20:00:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa6Zq-0008Ac-SK
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 20:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbcB1TAT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2016 14:00:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754213AbcB1TAS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Feb 2016 14:00:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F29E847210;
	Sun, 28 Feb 2016 14:00:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ryVGYGqogt3v
	fYBtoyeIS2+Q0h0=; b=e5qkBFGh18Izb9AYXM2nX8NQlLJdfrxyqiBXP2QleFE+
	pM2e9reA0hytYNpEeaaZ5i8GpRYV2lrNrUQk3B88RAQlMU7b4BDo3zeiXIsZxtvw
	Dj08vWZQ2zNPGrTgTleNMaj0pgjdyocG6eP4YoEiYeo1LcaNizxZFXOvqt+mXC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=te/zeN
	BYo8xBXqYnKZLe4svMuWMuqLxa1JzWsrAuT87ccJ0JOrTeB4e6Zv26PLkG4YUuOr
	F6+9RqF/DyVepafqFv1c93k+rblp6Z4qTOEQO6M8Aqrd/ute+GivvD7TOVq4DLnT
	vmfFqVur5r/5vJ0XywTdrVPJgG4wSMW5TJ+8w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E86E64720D;
	Sun, 28 Feb 2016 14:00:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6812E4720B;
	Sun, 28 Feb 2016 14:00:16 -0500 (EST)
In-Reply-To: <1456555333-5853-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:41:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 811893CE-DE4D-11E5-9EB2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287783>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/checkout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The command otherwise has been i18n'ed and it is clear that the
patch that added this string should have done the i18n marking shown
here from the beginning.  Let's take this.

>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index cfa66e2..efcbd8f 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -662,7 +662,7 @@ static void update_refs_for_switch(const struct c=
heckout_opts *opts,
>  		}
>  	} else if (new->path) {	/* Switch branches. */
>  		if (create_symref("HEAD", new->path, msg.buf) < 0)
> -			die("unable to update HEAD");
> +			die(_("unable to update HEAD"));
>  		if (!opts->quiet) {
>  			if (old->path && !strcmp(new->path, old->path)) {
>  				if (opts->new_branch_force)
