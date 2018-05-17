Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4DC1F42D
	for <e@80x24.org>; Thu, 17 May 2018 06:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeEQGkE (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 02:40:04 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39183 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752301AbeEQGkB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 02:40:01 -0400
Received: by mail-pg0-f65.google.com with SMTP id e1-v6so1373513pga.6
        for <git@vger.kernel.org>; Wed, 16 May 2018 23:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=kUx315RVDiUgwvqEjcg4PjcE4ef9FW9YLy+6x1k4HIE=;
        b=CZkwiyPc+6IGu4aY8ggj77xiMILO4jzfJr4Ihp6eBoR6kMwFbBPeY3jRFThMdf7JSx
         XF1j0+V0dDQAs0Tm9eZcgj2zQeP1503KO78E3bpO2fffqUIFiYMO52S8DZC17NbQ1oAV
         FCA7TnSVE5U4V0/KxxZboruw1NJFNrifYOhH7oJ4tVzGHkU9l0/BE5eQVisPv1cEiCVw
         0brXWKoguToBPf7bytK/YaAWKNQg1p7Hn5ZlkGCBlKjuWqkrV8wqGvkvsecmcJsemEO1
         bIGyb/Hzq+dgU5DkMi1FxXmE3ynXXsUw6WEKKTMybG0BkE9JgILHnkKwgA1YIG6BzWT/
         uqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=kUx315RVDiUgwvqEjcg4PjcE4ef9FW9YLy+6x1k4HIE=;
        b=ttc2kmTpisGAEILLV7v57tsszsyz3PFampkDAtR4HI/oI/HgWPZcbN57HNUUY+o5C7
         i5ytjospCFKEnlZkpkgqvkwyFLbiIQsGWpboKW3G0VgfDCufrQziEV+OB+kt34j9NjMR
         lkwLHHIk0XujrMbcE1Y12HljmDiaP4wh0Acn0QMryd1SW87eG9GLTbhaiSoU5ULb1IFj
         gaELOM6mvMFINVucyX8YLBE9gUuTg5CdbF+zB+2STKAb7+akLwx3vFX677fgWVtgoQMf
         lRu/rLtEfDn/bzafxkVG04+z8WEo7yNKTRVGGIRWcZ/zCdDHxZoFh7blyqIV49p8+dgO
         QX8g==
X-Gm-Message-State: ALKqPwfhznS5vYdatywr9yIDGwfHLlUBY4KxF68DhaH05T50GDT0tOvs
        mpor3c/i1EDV2PXjKW0z/s4=
X-Google-Smtp-Source: AB8JxZqd7mL9394AUu4/sIw7UfSjdovWiQM21YQQq+3C6/cHfg0CoGNCQkHPLVyB+ipR98RJlonalA==
X-Received: by 2002:a63:494:: with SMTP id 142-v6mr3193792pge.179.1526539201255;
        Wed, 16 May 2018 23:40:01 -0700 (PDT)
Received: from [192.168.206.100] ([117.249.229.154])
        by smtp.gmail.com with ESMTPSA id i1-v6sm7554947pfj.83.2018.05.16.23.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 May 2018 23:40:00 -0700 (PDT)
Subject: jk/branch-l-0-deprecation (was Re: What's cooking in git.git (May
 2018, #02; Thu, 17))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
Cc:     Jeff King <peff@peff.net>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
Date:   Thu, 17 May 2018 12:09:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9hAACz46A57lyYNL2eiPqRVdapH0BT6bt"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9hAACz46A57lyYNL2eiPqRVdapH0BT6bt
Content-Type: multipart/mixed; boundary="SD2fdWOmhrck1YVliRWjcagSRFJwG0i72";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Message-ID: <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
Subject: jk/branch-l-0-deprecation (was Re: What's cooking in git.git (May
 2018, #02; Thu, 17))
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>

--SD2fdWOmhrck1YVliRWjcagSRFJwG0i72
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Thursday 17 May 2018 11:31 AM, Junio C Hamano wrote:
> * jk/branch-l-0-deprecation (2018-03-26) 3 commits
>=20
> ...
>
>  The "-l" option in "git branch -l" is an unfortunate short-hand for
>  "--create-reflog", but many users, both old and new, somehow expect
>  it to be something else, perhaps "--list".  This step deprecates
>  the short-hand and warns about the future removal of the it when it
>  is used.
>=20
>  Will cook in 'next'.
>  Perhaps merge to 'master' immediately after 2.18 release?

I still have a slight feeling that we shouldn't list the branches for
"git branch -l" during the deprecation period. If feel this because

	i) It would avoid confusions for the users during the
	   deprecation period

	ii) The warning message seems to add to the confusion:

	    $ git branch -l
	    warning: the '-l' alias for '--create-reflog' is deprecated;
	    warning: it will be removed in a future version of Git
	    * master
	    ...


	    If there are ample branches, the warning message might be
	    hidden out of screen but we shouldn't rely on that, I
	    suppose.


--=20
Sivaraam

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - John Sonmez


Sivaraam?

You possibly might have noticed that my signature recently changed from
'Kaartic' to 'Sivaraam' both of which are parts of my name. I find the
new signature to be better for several reasons one of which is that the
former signature has a lot of ambiguities in the place I live as it is a
common name (NOTE: it's not a common spelling, just a common name). So,
I switched signatures before it's too late.

That said, I won't mind you calling me 'Kaartic' if you like it [of
course ;-)]. You can always call me using either of the names.


KIND NOTE TO THE NATIVE ENGLISH SPEAKER:

As I'm not a native English speaker myself, there might be mistaeks in
my usage of English. I apologise for any mistakes that I make.

It would be "helpful" if you take the time to point out the mistakes.

It would be "super helpful" if you could provide suggestions about how
to correct those mistakes.

Thanks in advance!


--SD2fdWOmhrck1YVliRWjcagSRFJwG0i72--

--9hAACz46A57lyYNL2eiPqRVdapH0BT6bt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlr9I7cACgkQveda2sPW
GWmcvRAAj7k123B36yT/3CSFpvjXw7DIedTg7AVv57cHVeMUHJ1ie0LLcxsJLuQf
kPNHlB+mrhKNNRrtXrfGnBKUNtcpdiTHfK6S2NlRhJryzdn4FjFVdr2n1ogVkTIw
aR+4G3Iw4vViUJIhKvQZkljHUTINWuQiK4lM1PA8PGtf8sGx/Qx0pqdmCPcY0B92
pWxhGGZkfEw0PNMQISq+BKPwqzrILAVJf2xxzV17qAvvA++zQTxUBIAACGY7hHYq
t2Pd92oNiyjWIE23OxigEjXxYhWUibqgugltcWogr3Iovz+5e/7M6UVBBl5EO3cm
g1GzjauL8+dx6VZgVjLQqveKGW8rS8Bkx8WDDd2bryenRqMfyy4gQiueCdlYp1OD
oyKPXQZcpU4NJeYxDSv+bF2fDu/lKcmTqXFJxSaxIbz834EmpqjIKVVAvJCsOdGk
YYp6g1kI7ox1s9b27Fh4InlE45g3AfZnFgmh8TvfurPdc5vUMgBnbt8jB1AV5T2o
eugc6cHx0/GUkA0P13jdNDGv6VjO9jGcajJ3iLnDJwv7K1vbMBlXv8/znBl+j1PW
IuGI04TrHLODSjLyJ2I0FTx6Qlhxxbq6S49PncjIoePuatCSiCFvKrLwBIoRw7NB
dQHhotSS9Rye7eW5OrejhAr5eAkldWVYQ2D0CwqWq7Op/fNDawo=
=gQCv
-----END PGP SIGNATURE-----

--9hAACz46A57lyYNL2eiPqRVdapH0BT6bt--
