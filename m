From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: A few minor copy edits.
Date: Sat, 14 Jul 2012 22:32:05 -0700
Message-ID: <7vehod614a.fsf@alter.siamese.dyndns.org>
References: <1342304436-29499-1-git-send-email-stepnem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 07:32:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqHRp-0000lY-Ta
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 07:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835Ab2GOFcK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jul 2012 01:32:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab2GOFcI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2012 01:32:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D1466B79;
	Sun, 15 Jul 2012 01:32:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lzLdfIczzR65
	NZgrt5bGcMSnrHk=; b=H9J8NtwQegZIcGC841HkMceMZ3v5dqqrL4v+DoKBs4aU
	POeuQbBWLqtGAEI45vpsU+7dBUoydA99epzi1QST7iTfGp3V06lzAMQG8/AUHFHy
	3XYdAHDJwcxrprJrsSZpE7vSITDoFhrWzempR9wqkHJR9yZPd7bP4rHXFnLouNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u+TyXR
	FcFIvo4HmRutFCC8IX0s9BXu/E0neFpFFn7onaQPANOKzLcFBJEwU1ypFBQNyGqe
	vlSJxhbb/WH4dhuw91R723V2Mma3ihe7k1vGjmJ6CundcM+rsr8iKpZBFx2NJsqn
	xRQkQcWKKN5M/L7OwUZq+2UT3gt9suNpDme7U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AE146B78;
	Sun, 15 Jul 2012 01:32:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B7516B77; Sun, 15 Jul 2012
 01:32:07 -0400 (EDT)
In-Reply-To: <1342304436-29499-1-git-send-email-stepnem@gmail.com>
 (=?utf-8?B?IsWgdMSbcMOhbglOxJttZWMiJ3M=?= message of "Sun, 15 Jul 2012
 00:20:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AE475BE-CE3E-11E1-94E8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201468>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:

> - (glossary) the quotes around the Wikipedia URL prevented its
>   linkification in frontends that support it; remove them
>
> - (manual) newer version (SHA-1) =3D=3D following, older =3D=3D prece=
ding, not
>   the other way around
>
> - trivial typo and wording fixes
>
> Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>

Thanks.  All looked reasonable, except that I've heard nobody says
"ent" for the past couple of years, and it might be better to drop
the entry altogether.

> diff --git a/Documentation/glossary-content.txt b/Documentation/gloss=
ary-content.txt
> index 3595b58..f928b57 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -117,7 +117,7 @@ to point at the new commit.
> =20
>  [[def_ent]]ent::
>  	Favorite synonym to "<<def_tree-ish,tree-ish>>" by some total geeks=
=2E See
> -	`http://en.wikipedia.org/wiki/Ent_(Middle-earth)` for an in-depth
> +	http://en.wikipedia.org/wiki/Ent_(Middle-earth) for an in-depth
>  	explanation. Avoid this term, not to confuse people.
> =20
>  [[def_evil_merge]]evil merge::
