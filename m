From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/22] ref-filter.c: mark strings for translation
Date: Mon, 29 Feb 2016 10:41:26 -0800
Message-ID: <xmqqk2lnbbqh.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-14-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:41:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSlB-0003lz-VK
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbcB2Sl3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 13:41:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751566AbcB2Sl2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 13:41:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3F4847609;
	Mon, 29 Feb 2016 13:41:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=j9iouiH1Y/QZ
	ckiNxSZY5deWQ+c=; b=cjKM8Tzia6L34lpCnXDvCfn8Fckynjxe7xjR8s4jhVhz
	IfRpKb9VpFPYd/yOg93RRd3/R2KXMpBTVotcYkAPFXuspwEp+Bobqbvi5OVzMUJk
	Ltm3nCnBLC8GozYUSXnfdY4wK+7Utr+BP6ztxzGvbNWR7+vTw69Om7OL9yFdiew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=M79xEJ
	6Y65pFZDuH7A+oo/4I2mwvkO6bEYZGvEB+M1hQssuEPGHl9u8rxB68nkLUXN40gc
	tw1wa8zNc77HkFVGJC6v755KEhXDZsNhYyvYnp63f+nAcSyXj5VmHBYJffgfJ0Ug
	5pvuDXtcGPAd+zQsh1rm3d6IJoGM/x3F8HqYo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC1FD47608;
	Mon, 29 Feb 2016 13:41:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 42A8D47607;
	Mon, 29 Feb 2016 13:41:27 -0500 (EST)
In-Reply-To: <1456555333-5853-14-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:42:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0A7B3312-DF14-11E5-BA79-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287865>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

About half of this we can find in 2.7.0, but we can see that many
existing messages are already marked.  Let's take this for 2.8.0 (I
am assuming that this covers the whole file, not just relatively new
ones).

>  ref-filter.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index bb79d6b..bc551a7 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -74,14 +74,14 @@ static void remote_ref_atom_parser(struct used_at=
om *atom, const char *arg)
>  static void body_atom_parser(struct used_atom *atom, const char *arg=
)
>  {
>  	if (arg)
> -		die("%%(body) does not take arguments");
> +		die(_("%%(body) does not take arguments"));
>  	atom->u.contents.option =3D C_BODY_DEP;
>  }
> =20
>  static void subject_atom_parser(struct used_atom *atom, const char *=
arg)
>  {
>  	if (arg)
> -		die("%%(subject) does not take arguments");
> +		die(_("%%(subject) does not take arguments"));
>  	atom->u.contents.option =3D C_SUB;
>  }
> =20
> @@ -241,7 +241,7 @@ int parse_ref_filter_atom(const char *atom, const=
 char *ep)
>  	if (*sp =3D=3D '*' && sp < ep)
>  		sp++; /* deref */
>  	if (ep <=3D sp)
> -		die("malformed field name: %.*s", (int)(ep-atom), atom);
> +		die(_("malformed field name: %.*s"), (int)(ep-atom), atom);
> =20
>  	/* Do we have the atom already used elsewhere? */
>  	for (i =3D 0; i < used_atom_cnt; i++) {
> @@ -267,7 +267,7 @@ int parse_ref_filter_atom(const char *atom, const=
 char *ep)
>  	}
> =20
>  	if (ARRAY_SIZE(valid_atom) <=3D i)
> -		die("unknown field name: %.*s", (int)(ep-atom), atom);
> +		die(_("unknown field name: %.*s"), (int)(ep-atom), atom);
> =20
>  	/* Add it in, including the deref prefix */
>  	at =3D used_atom_cnt;
> @@ -421,7 +421,7 @@ int verify_ref_format(const char *format)
>  		int at;
> =20
>  		if (!ep)
> -			return error("malformed format string %s", sp);
> +			return error(_("malformed format string %s"), sp);
>  		/* sp points at "%(" and ep points at the closing ")" */
>  		at =3D parse_ref_filter_atom(sp + 2, ep);
>  		cp =3D ep + 1;
> @@ -875,12 +875,12 @@ static const char *strip_ref_components(const c=
har *refname, const char *nr_arg)
>  	const char *start =3D refname;
> =20
>  	if (nr < 1 || *end !=3D '\0')
> -		die(":strip=3D requires a positive integer argument");
> +		die(_(":strip=3D requires a positive integer argument"));
> =20
>  	while (remaining) {
>  		switch (*start++) {
>  		case '\0':
> -			die("ref '%s' does not have %ld components to :strip",
> +			die(_("ref '%s' does not have %ld components to :strip"),
>  			    refname, nr);
>  		case '/':
>  			remaining--;
> @@ -1043,7 +1043,7 @@ static void populate_value(struct ref_array_ite=
m *ref)
>  			else if (skip_prefix(formatp, "strip=3D", &arg))
>  				refname =3D strip_ref_components(refname, arg);
>  			else
> -				die("unknown %.*s format %s",
> +				die(_("unknown %.*s format %s"),
>  				    (int)(formatp - name), name, formatp);
>  		}
> =20
> @@ -1063,10 +1063,10 @@ static void populate_value(struct ref_array_i=
tem *ref)
>   need_obj:
>  	buf =3D get_obj(ref->objectname, &obj, &size, &eaten);
>  	if (!buf)
> -		die("missing object %s for %s",
> +		die(_("missing object %s for %s"),
>  		    sha1_to_hex(ref->objectname), ref->refname);
>  	if (!obj)
> -		die("parse_object_buffer failed on %s for %s",
> +		die(_("parse_object_buffer failed on %s for %s"),
>  		    sha1_to_hex(ref->objectname), ref->refname);
> =20
>  	grab_values(ref->value, 0, obj, buf, size);
> @@ -1094,10 +1094,10 @@ static void populate_value(struct ref_array_i=
tem *ref)
>  	 */
>  	buf =3D get_obj(tagged, &obj, &size, &eaten);
>  	if (!buf)
> -		die("missing object %s for %s",
> +		die(_("missing object %s for %s"),
>  		    sha1_to_hex(tagged), ref->refname);
>  	if (!obj)
> -		die("parse_object_buffer failed on %s for %s",
> +		die(_("parse_object_buffer failed on %s for %s"),
>  		    sha1_to_hex(tagged), ref->refname);
>  	grab_values(ref->value, 1, obj, buf, size);
>  	if (!eaten)
> @@ -1370,12 +1370,12 @@ static int ref_filter_handler(const char *ref=
name, const struct object_id *oid,
>  	unsigned int kind;
> =20
>  	if (flag & REF_BAD_NAME) {
> -		warning("ignoring ref with broken name %s", refname);
> +		warning(_("ignoring ref with broken name %s"), refname);
>  		return 0;
>  	}
> =20
>  	if (flag & REF_ISBROKEN) {
> -		warning("ignoring broken ref %s", refname);
> +		warning(_("ignoring broken ref %s"), refname);
>  		return 0;
>  	}
