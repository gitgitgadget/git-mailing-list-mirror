From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] glossary-content.txt: remove an obsolete paragrah
Date: Thu, 21 Nov 2013 10:13:48 -0800
Message-ID: <xmqqtxf54o83.fsf@gitster.dls.corp.google.com>
References: <1384910801-11125-1-git-send-email-pclouds@gmail.com>
	<1385016260-9718-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 21 19:14:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjYlg-0002QX-AD
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 19:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab3KUSN5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Nov 2013 13:13:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34156 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754669Ab3KUSNx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Nov 2013 13:13:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 451865054E;
	Thu, 21 Nov 2013 13:13:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cuUrSYtaXWki
	+17SlUOHkjGkN0Q=; b=v14ONEZtj6NWutTHlcNs1xht2sDVe+1KGm1U4FoeK59C
	i+5xj4bgUBFuBsx7v0lHaWRCaVzyatyjtjD/i1GzNv1wfslz8Je20fGXFLqQ2Xom
	VHEanrJmVGBJy5cp3gQz0JJFxN3pypyx2k2TETLGmFmzaauvPGAJ2dgXBWSmADQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lRSt8n
	xMkdww4vPXSky5er7V70XYZu7yMQ3KGNpODgogXItrBSnIVbG8PMHJ61krp7yqE/
	K3Euebn25nyGLHAyX7uDLCcu3bA5Y5kLMG7LJVaxr0pID3mmZtCCnVvG5A5KDijU
	dCveWwfJEuKXd3BeCZ/DYPBc8jlFCUnu5uR0M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33B955054D;
	Thu, 21 Nov 2013 13:13:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 857285054C;
	Thu, 21 Nov 2013 13:13:51 -0500 (EST)
In-Reply-To: <1385016260-9718-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 21
 Nov 2013 13:44:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ACBA32BA-52D8-11E3-A4D2-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238132>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> With the introduction of :(literal), :(glob) and :(icase), :(top) is
> no longer the only recognized magic signature.

You need to re-read the message you took hints that led to this
patch from (or, rather, the existing document around the area you
are patching, which led to the wording in that message from me).

The above is a list of magic words, but until you add the magic
signature ":!not_in_this_directory" for the ":(exclude)" magic word,
":/" still is the only magic signature.

Another moderately related tangent is this phrase in the existing
document:

    In the short form, the leading colon `:` is followed by zero or
    more "magic signature" letters (which optionally is terminated
    by another colon `:`), and the remainder is the pattern to match
    against the path. The optional colon that terminates the "magic
    signature" can be omitted if the pattern begins with a character
    that cannot be a "magic signature" and is not a colon.

While it is technically correct, the phrase "a character that cannot
be" is somewhat misleading, and I think it needs to be clarified by
rephrasing.

As we can see in a later paragaph:

    The "magic signature" consists of an ASCII symbol that is not
    alphanumeric. Currently only the slash `/` is recognized as a
    "magic signature"...

the correct way to read that "a character that cannot be a magic
signature" is "a character that is not 'an ASCII symbol that is not
alphanumeric'", which means you can do:

	:!/foo	- with magic signatures ! and /, pattern begins at 'f'

	:/#abc  - with magic signatures # and /, pattern begins at 'a',
	          even if in a particular version of Git, '#' magic
		  signature may be invalid and produce an error

	:/:#abc - with magic signature /, pattern is "#abc".

but because the definition of "magic signature" syntax comes later
than "cannot be", it is prone to be misinterpreted as "anything that
is not currently defined as a magic signature (namely, '/')".



> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  .. on top of nd/magic-pathspec..
>
>  Documentation/glossary-content.txt | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/gloss=
ary-content.txt
> index e470661..e22b524 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -379,10 +379,6 @@ full pathname may have special meaning:
>  Glob magic is incompatible with literal magic.
>  --
>  +
> -Currently only the slash `/` is recognized as the "magic signature",
> -but it is envisioned that we will support more types of magic in lat=
er
> -versions of Git.
> -+
>  A pathspec with only a colon means "there is no pathspec". This form
>  should not be combined with other pathspec.
