From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH on ab/i18n] branch: remove lego in i18n tracking info
 strings
Date: Fri, 04 May 2012 09:10:09 -0700
Message-ID: <7vr4v0apwe.fsf@alter.siamese.dyndns.org>
References: <877gwtyalt.fsf@thomas.inf.ethz.ch>
 <1336050720-21200-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Christian Stimming <stimming@tuhh.de>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 18:10:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQL5J-0000bP-Mt
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 18:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758992Ab2EDQKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 12:10:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51743 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105Ab2EDQKN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 12:10:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A23D56A70;
	Fri,  4 May 2012 12:10:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uj3nmdNmydgD
	5ntU8HUvkOEbGAE=; b=dxoqU4NDxAyvUN8ilvM0hEQvrZgGvl+Ia81hdLmeIyk1
	ueQV3VGLuOUP6AQkYAOBzPVRoJi/h9be7DR0Xr7lKafboAoeUGaBm4zS+fbq2TXm
	c7eGl7G6rz4YAtlqGqzLUIf6C6/EmuRnTAr642gq13qyblN8FZkuKQaN6muRAnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fwB7ZJ
	5Pao4J2oIKIsYk8TZIF1Dk9cCkyxLohMHJ9ESUNfrPrIQFjfbuEruevKJhouAmSh
	Y70xswnGg0nZbs8q8aDoForPQv0BR5cRkzhZ17eYRRIcr/z1YOe+ag4pofiDS/8Z
	JDI7L+KaKVF0r9EAEDGzSzFOXDXSOvIOAABow=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9942F6A6F;
	Fri,  4 May 2012 12:10:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D4746A6A; Fri,  4 May 2012
 12:10:10 -0400 (EDT)
In-Reply-To: <1336050720-21200-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 3 May
 2012 20:12:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FF90F76-9603-11E1-94D7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197034>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Pseudo html tags to to mark color, like
>  "On branch <color1>%s</color1>" is probably not a bad idea.

The output machinery needs to understand _some_ color mark-up if the
destination does not support ANSI colors natively, and there already is
such a code in compat/ for windows IIRC.  Adding yet another color mark=
-up
wouldn't help anybody.  I would suggest to just declare that internally=
 we
use ANSI colors as the standard color mark-up and be done with it.

>  builtin/branch.c |   31 ++++++++++++++++++++++---------
>  1 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 8813d2e..5011881 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -384,6 +384,7 @@ static void fill_tracking_info(struct strbuf *sta=
t, const char *branch_name,
>  		int show_upstream_ref)
>  {
>  	int ours, theirs;
> +	const char *ref =3D NULL;
>  	struct branch *branch =3D branch_get(branch_name);
> =20
>  	if (!stat_tracking_info(branch, &ours, &theirs)) {
> @@ -394,16 +395,28 @@ static void fill_tracking_info(struct strbuf *s=
tat, const char *branch_name,
>  		return;
>  	}
> =20
> -	strbuf_addch(stat, '[');
>  	if (show_upstream_ref)
> -		strbuf_addf(stat, "%s: ",
> -			shorten_unambiguous_ref(branch->merge[0]->dst, 0));
> -	if (!ours)
> -		strbuf_addf(stat, _("behind %d] "), theirs);
> -	else if (!theirs)
> -		strbuf_addf(stat, _("ahead %d] "), ours);
> -	else
> -		strbuf_addf(stat, _("ahead %d, behind %d] "), ours, theirs);
> +		ref =3D shorten_unambiguous_ref(branch->merge[0]->dst, 0);
> +	if (!ours) {
> +		if (ref)
> +			strbuf_addf(stat, _("[%s: behind %d]"), ref, theirs);
> +		else
> +			strbuf_addf(stat, _("[behind %d]"), theirs);
> +
> +	} else if (!theirs) {
> +		if (ref)
> +			strbuf_addf(stat, _("[%s: ahead %d]"), ref, ours);
> +		else
> +			strbuf_addf(stat, _("[ahead %d]"), ours);
> +	} else {
> +		if (ref)
> +			strbuf_addf(stat, _("[%s: ahead %d, behind %d]"),
> +				    ref, ours, theirs);
> +		else
> +			strbuf_addf(stat, _("[ahead %d, behind %d]"),
> +				    ours, theirs);
> +	}
> +	strbuf_addch(stat, ' ');

You should free "ref" here, as it is an allocated piece of memory you o=
wn.
