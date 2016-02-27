From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/3] sha1_file.c: mark strings for translation
Date: Sat, 27 Feb 2016 09:41:09 -0800
Message-ID: <xmqq37sehwzu.fsf@gitster.mtv.corp.google.com>
References: <20160225142004.GA17678@sigill.intra.peff.net>
	<1456559373-13589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, d33tah@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 18:41:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZis0-00051o-Rm
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 18:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992531AbcB0RlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 12:41:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2992528AbcB0RlL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Feb 2016 12:41:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAB1245AF4;
	Sat, 27 Feb 2016 12:41:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qUxwbYZj/PkX
	U+OnkIedwvDIkGk=; b=HcCkixUvv6NmL5jd4XB4LNUI7J+MDBMyvyYJug1ESBUi
	0CU87Sen8Sqo35Vd1Z4pTXhVYLqPg/CpVFNr9AgrqRNWn/HeNqK+qDMILpdHXIef
	ToRdW9y73D4OntEQNM7G+uvCwLRr1xr+A0QtxJP5MUrj9Y6jJe2qHcMAvU2CWqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=plKDsH
	eZezU9X3g0Go5IvTDm/TabzzTTpYUZXSa/ow5zit8o6VvYAUiaFuQSo9tqm9VEFz
	Gbx482m8/5Hr6/9cIR75XrgVa907Rjqcp6lQBvUhDH0FKdspvQq4OvyIMwAApMHz
	NDLooLeMLfOvZiHvNs/SDHzVkZrOuf+KTQfsY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D21A445AF3;
	Sat, 27 Feb 2016 12:41:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 550FB45AF2;
	Sat, 27 Feb 2016 12:41:10 -0500 (EST)
In-Reply-To: <1456559373-13589-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 14:49:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 49CCCA4A-DD79-11E5-9E6D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287707>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Since jk/pack-idx-corruption-safety is already in 'next', can we add
>  this patch on top? Surrounding strings are handled separately [1] by
>  another series.
>
>  [1] http://thread.gmane.org/gmane.comp.version-control.git/287661/fo=
cus=3D287678

Thanks, I think this makes sense.  Peff--I do not think I missed a
reason we shouldn't take this?

>
>  sha1_file.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 4a3a032..b8da68b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1042,7 +1042,7 @@ unsigned char *use_pack(struct packed_git *p,
>  	if (offset > (p->pack_size - 20))
>  		die("offset beyond end of packfile (truncated pack?)");
>  	if (offset < 0)
> -		die("offset before end of packfile (broken .idx?)");
> +		die(_("offset before end of packfile (broken .idx?)"));
> =20
>  	if (!win || !in_window(win, offset)) {
>  		if (win)
> @@ -2367,11 +2367,11 @@ void check_pack_index_ptr(const struct packed=
_git *p, const void *vptr)
>  	const unsigned char *start =3D p->index_data;
>  	const unsigned char *end =3D start + p->index_size;
>  	if (ptr < start)
> -		die("offset before start of pack index for %s (corrupt index?)",
> +		die(_("offset before start of pack index for %s (corrupt index?)")=
,
>  		    p->pack_name);
>  	/* No need to check for underflow; .idx files must be at least 8 by=
tes */
>  	if (ptr >=3D end - 8)
> -		die("offset beyond end of pack index for %s (truncated index?)",
> +		die(_("offset beyond end of pack index for %s (truncated index?)")=
,
>  		    p->pack_name);
>  }
