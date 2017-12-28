Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6AED1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 16:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751008AbdL1QOa (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 11:14:30 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:39268 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdL1QO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 11:14:29 -0500
Received: by mail-wr0-f175.google.com with SMTP id o101so10937642wrb.6
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 08:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4iM4bkAZzTCykP95Zgq0W5QRvMMN5eIXnhCXVez1TVo=;
        b=QL83WuTpUmE23nUazPui+48sUo37iYwN6J0xGAbV9pzANWEZfA0oTNtQtjNHRW/707
         uJVz42MxhyOf6dPa/Eo6aTzqfbDnL6lOUH/KIXKVguC7Va1dg7Ev88Pq8tZjrbbdtvRV
         6qXnFxIVbYWHwAKK+Gy+ZvEPjcRsSoTM2x3dURRII94Fv/tcE0AH+GxAE+82mpxVAScp
         4OJNSJ1p54pBHaq8J/exoH7tOYJBcKY6NmHs8VNobnCa4ZqucnJwlm7nneXIUC6PUwHN
         xzzrdc/+lT8TRMsQLBLOUl3Z/o27aKpJTK1ZgWZVHwgP5rqz1c2hP+0TjLxSRoiGq7X5
         WX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4iM4bkAZzTCykP95Zgq0W5QRvMMN5eIXnhCXVez1TVo=;
        b=AleEzVuxSphmdFadug9K5m8voBNvXJ/yEjs+8Df/e3YpIJk1stwJ1ZuA+m/sEUGQYp
         NF26azk2QuloDg/RcNPspIt1z63No+lZvc4qnZTsJnRAtWkAzu7ipMmOJzdCvgCi9B+s
         XDN7TgOS8oFslU3mW6VXh4ICNOKRIYNlUhNO4b/BQpWKN1JzzJM2vDjd8tXJv9E+sadG
         KOVnOFZXU7YEZ+wmCzwALkqRrbhYPk2fxhc8OPirfp6/hNYpFtl0uJEL+yDW77sZqUJk
         SocazhavbiO0gooQHvDTpz00GdrXSs9vJflkny712/Uj1sNWZcJa9aJ7QrclRF2yY16i
         fGbQ==
X-Gm-Message-State: AKGB3mJlawzPEnEnJ743sxP/Zwx2d/MO4nhnkV1vzl7+0pPiHuQXzOed
        wBP27O/PqvzI/1D4XOU45vw=
X-Google-Smtp-Source: ACJfBotxBF0J3DKMMF1IrJ5TioW0IQgjgAJpK17rqlzz7+WiCyTA9ReoywQ93pgtUIKqxVwfdeGYLQ==
X-Received: by 10.223.135.171 with SMTP id b40mr31912672wrb.278.1514477668161;
        Thu, 28 Dec 2017 08:14:28 -0800 (PST)
Received: from [10.32.248.174] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id m134sm19196543wmg.6.2017.12.28.08.14.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Dec 2017 08:14:27 -0800 (PST)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171217171404.GA18175@tor.lan>
Date:   Thu, 28 Dec 2017 17:14:25 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>, gitster@pobox.com,
        peff@peff.net, patrick@luehne.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF5C58AC-C1E6-4AD5-A4F8-C4CC5C9108F7@gmail.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com> <20171217171404.GA18175@tor.lan>
To:     =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Dec 2017, at 18:14, Torsten B=F6gershausen <tboegi@web.de> =
wrote:
>=20
> On Mon, Dec 11, 2017 at 04:50:23PM +0100, lars.schneider@autodesk.com =
wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20

>> +`encoding`
>> +^^^^^^^^^^
>> +
>> +By default Git assumes UTF-8 encoding for text files.  The =
`encoding`
>=20
> This is probably "ASCII" and it's supersets like ISO-8859-1 or UTF-8.

I am not sure I understand what you want to tell me here.
Do you think UTF-8 encoding is not correct in the sentence above?

>=20
>> +attribute sets the encoding to be used in the working directory.
>> +If the path is added to the index, then Git encodes the content to
>> +UTF-8.  On checkout the content is encoded back to the original
>> +encoding.  Consequently, you can use all built-in Git text =
processing
>> +tools (e.g. git diff, line ending conversions, etc.) with your
>> +non-UTF-8 encoded file.
>> +
>> +Please note that re-encoding content can cause errors and requires
>> +resources. Use the `encoding` attribute only if you cannot store
>> +a file in UTF-8 encoding and if you want Git to be able to process
>> +the text.
>> +
>> +------------------------
>> +*.txt		text encoding=3DUTF-16
>> +------------------------
>=20
> I think that encoding (or worktree-encoding as said elsewhere) must =
imply text.
> (That is not done in convert.c, but assuming binary or even auto
> does not make much sense to me)

"text" only means "LF". "-text" means CRLF which would be perfectly fine
for UTF-16. Therefore I don't think we need to imply text.
Does this make sense?

>=20
>=20
>> +
>> +All `iconv` encodings with a stable round-trip conversion to and =
from
>> +UTF-8 are supported.  You can see a full list with the following =
command:
>> +
>> +------------------------
>> +iconv --list
>> +------------------------
>> +
>> `eol`
>> ^^^^^
>>=20
>> diff --git a/convert.c b/convert.c
>> index 20d7ab67bd..ee19c17104 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -7,6 +7,7 @@
>> #include "sigchain.h"
>> #include "pkt-line.h"
>> #include "sub-process.h"
>> +#include "utf8.h"
>>=20
>> /*
>>  * convert.c - convert a file when checking it out and checking it =
in.
>> @@ -256,6 +257,149 @@ static int will_convert_lf_to_crlf(size_t len, =
struct text_stat *stats,
>>=20
>> }
>=20
> I would avoid to use these #ifdefs here.
> All functions can be in strbuf.c (and may have #ifdefs there), but not =
here.

I'll try that. But wouldn't it make more sense to move the functions to =
utf.c?

>=20
>>=20
>> +#ifdef NO_ICONV
>> +#ifndef _ICONV_T
>> +/* The type is just a placeholder and not actually used. */
>> +typedef void* iconv_t;
>> +#endif
>> +#endif
>> +
>> +static struct encoding {
>> +	const char *name;
>> +	iconv_t to_git;       /* conversion to Git's canonical encoding =
(UTF-8) */
>> +	iconv_t to_worktree;  /* conversion to user-defined encoding */
>> +	struct encoding *next;
>> +} *encoding, **encoding_tail;
>=20
> This seems like an optimazation, assuning that iconv_open() eats a lot =
of ressources.
> I don't think this is the case. (Undere MacOS we run iconv_open() =
together with
> every opendir(), and optimizing this out did not show any measurable =
improvements)

True, but then I would need to free() the memory in a lot of places.
Therefore I thought it is easier to keep the object. OK for you?


>> +static const char *default_encoding =3D "utf-8";
>=20
> The most portable form is "UTF-8" (correct me if that is wrong)

It shouldn't matter. But I've changed it to uppercase to be on the safe =
side.


>> +static iconv_t invalid_conversion =3D (iconv_t)-1;
>> +
>> +static int encode_to_git(const char *path, const char *src, size_t =
src_len,
>> +			 struct strbuf *buf, struct encoding *enc)
>> +{
>> +#ifndef NO_ICONV
>> +	char *dst, *re_src;
>> +	int dst_len, re_src_len;
>> +
>> +	/*
>> +	 * No encoding is specified or there is nothing to encode.
>> +	 * Tell the caller that the content was not modified.
>> +	 */
>> +	if (!enc || (src && !src_len))
>> +		return 0;
>> +
>> +	/*
>> +	 * Looks like we got called from "would_convert_to_git()".
>> +	 * This means Git wants to know if it would encode (=3D modify!)
>> +	 * the content. Let's answer with "yes", since an encoding was
>> +	 * specified.
>> +	 */
>> +	if (!buf && !src)
>> +		return 1;
>> +
>> +	if (enc->to_git =3D=3D invalid_conversion) {
>> +		enc->to_git =3D iconv_open(default_encoding, =
encoding->name);
>> +		if (enc->to_git =3D=3D invalid_conversion)
>> +			warning(_("unsupported encoding %s"), =
encoding->name);
>> +	}
>=20
> 	/* There are 2 different types of reaction:
> 	      Either users  know what that a warning means: You asked =
for problems,
> 	      	        and do the right thing. Other may may ignore the =
warning
> 			       - in both cases an error is useful */

Agreed!


>> +	if (enc->to_worktree =3D=3D invalid_conversion)
>> +		enc->to_worktree =3D iconv_open(encoding->name, =
default_encoding);
>> +
>> +	/*
>> +	 * Do nothing if the encoding is not supported. This could =
happen in
>> +	 * two cases:
>> +	 *   (1) The encoding is garbage. That is no problem as we would =
not
>> +	 *       encode the content to UTF-8 on "add" and we would not =
encode
>> +	 *       it back on "checkout".
>> +	 *   (2) Git users use different iconv versions that support =
different
>> +	 *       encodings. This could lead to problems, as the content =
might
>> +	 *       not be encoded on "add" but encoded back on "checkout" =
(or
>> +	 *       the other way around).
>> +	 * We print a one-time warning to the user in both cases above.
>> +	 */
>=20
> Isn't an error better than "garbage in -> garbage out" ?

Agreed. I changed the warning to an error.


>> diff --git a/t/t0028-encoding.sh b/t/t0028-encoding.sh
>=20
> (I didn't review the test yet)
>=20
> Another comment for a possible improvement:
> "git diff"  could be told to write the worktree-encoding into the =
diff,
> and "git apply" can pick that up.=20

Yes, we could do that. However, I would tackle that in a separate =
series.


Thanks,
Lars



