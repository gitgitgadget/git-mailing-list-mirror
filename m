Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBCDF1F461
	for <e@80x24.org>; Wed, 15 May 2019 23:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEOXKY (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 19:10:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36580 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbfEOXKY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 May 2019 19:10:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8C73360443;
        Wed, 15 May 2019 23:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557961822;
        bh=x7d9BiOZHzwLWaEcPPNUL8eg0woPhfZkI8mzjjvsXpc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gfn/YVk5C3EpamJ8M3cxSH1cwW+ARW3yzIjpe2RdybkDLyIKJeSEdAcGUld/Uu2mV
         OQ8ljNwlESrr3PuW6gGe2/8FuFliUnUoCkXSh1pnm27zL1gWnmqYghA+4uJWZXhScN
         P+hptUlDF7g5CimEfSuVfSOfMPs8DJ76CbnMBUgBiQn0ZkCXigSOMtuRAAUL3yZhhs
         l8l9D3idsRGa7+iVh4euUfwZpZKWF3Ua5SgYycORXPHMMXLk727txtCingMvpMIltF
         12TWShrnOm5Ym8HZ7qddbhlv6cMfEGk4XwroMHqdv7Ih6q4iXAV6k2iOP47bK5GjgF
         ngUsp+QlUDkjTzWHuoKHA8dei8AfKIq68OLeyGQEpOW99/Ak3/hirvPbfQuNsDQKA6
         JsAK39Dw1dOipG3voqBtj7yBpzEWhV+UqEGg6MM3WG9V2D8ox50AjlFI19Jz0n2bzG
         ILJ6EUw8sDpE+pNwl6eMsG7XZXv0AD7niu2oXCfBjCrRy2V3MJ6
Date:   Wed, 15 May 2019 23:10:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 6/7] config: allow configuration of multiple hook
 error behavior
Message-ID: <20190515231017.GM7458@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514002332.121089-8-sandals@crustytoothpaste.net>
 <CACsJy8BN32Jm62MQPLsRwKST8DDNZ7NxnJbsqBO3PJ0K2qU-Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NZtAI5QFBF0GmLcW"
Content-Disposition: inline
In-Reply-To: <CACsJy8BN32Jm62MQPLsRwKST8DDNZ7NxnJbsqBO3PJ0K2qU-Ng@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NZtAI5QFBF0GmLcW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2019 at 08:20:10PM +0700, Duy Nguyen wrote:
> On Tue, May 14, 2019 at 7:24 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > There are a variety of situations in which a user may want an error
> > behavior for multiple hooks other than the default. Add a config option,
> > hook.<name>.errorBehavior to allow users to customize this behavior on a
>=20
> An alternative name is onError, probably more often used for event
> callbacks. But I don't know, maybe errorBehavior is actually better.

I'm going to use "errorStrategy", since we already have
submodule.alternateErrorStrategy.

> > per-hook basis. Provide options for the default behavior (exiting
>=20
> should we fall back to hook.errorBehavior? That allows people to set
> global policy, then customize just a small set of weird hooks.

Sure, that sounds good.

> maybe stop-on-first-error (or if you go with the "onError" name, I
> think "stop" is enough). I know "stop on/after first hook" does not
> really make any sense when you think about it. Maybe stop-on-first is
> sufficient.
>=20
> I was going to suggest strcasecmp. But core.whitespace (also has
> multiple-word-values) already sets a precedent on strcmp. I think
> we're good. Or mostly good, I don't know, we still accept False, false
> and FALSE.

I think with errorStrategy, "stop" is fine. Simpler is better.

I literally picked what Peff had suggested in his email (mostly because
I'm terrible at naming things), and I don't get the impression he spent
a great deal of time analyzing the ins and outs of the names before
sending. I could be wrong, though.

> > +                       behavior =3D HOOK_ERROR_STOP_ON_FIRST;
>=20
> This is basically the logical "and" behavior in a C expression. Which
> makes me think if anybody's crazy enough to need the "or" counterpart
> (i.e. run hooks, expect failure, keep going until the first success).
>=20
> I guess it's a crazy mode. We should not care about until a real use
> case shows up.

Yeah, I think that's unlikely to be the case. Nothing prevents us from
adding it later.

> > +               else if (!strcmp(value, "report-any-error"))
>=20
> I couldn't guess based on this name alone, whether we continue or stop
> after the reporting part. The 7/7 document makes it clear though. So
> all good.

I'm open to hearing better suggestions if anyone has any.

> > diff --git a/run-command.c b/run-command.c
> > index 191d6f6f7e..70fb19a55b 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -1308,6 +1308,8 @@ int async_with_fork(void)
> >  #endif
> >  }
> >
> > +struct string_list hook_error_behavior =3D STRING_LIST_INIT_NODUP;
>=20
> Maybe stick this in 'struct repository'. I know most config variables
> are still global. But I think we have to move/reorganize them at some
> point. Most may end up in 'struct repository'.

Okay, sounds fine.

> > +                       default:
> > +                               BUG("unknown hook error behavior");
>=20
> maybe BUG(".. behavior %d", behavior);

Sure.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--NZtAI5QFBF0GmLcW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzcnFgACgkQv1NdgR9S
9otg7BAArhOnTRytZ6QH87hx1R+wArD3st9YjDoRWtLxEXQ1FRiqjK21h7/x4Y2a
/l7AImcG9nSqjOze0ZLJy7T5VXabFUS3HmkbqxwFu4J4KOyUe3X8+KJPn0IDkRcJ
lu2XFfenhXHX6Zx+v1dVg3LqtZNtNbBfVEWoI0endJNB7Qo6RSTLV0hb/dp1rjoD
FVsiyu6wKs4t0Xy1YDn8RkMXKKwlVl+AFt/Lfn4Jh/f+R6Z+xJaC31ViI2QekbZ5
jRIFNb0B/uvZ6N5jKeBoQwKBU6C4BszK3yO5mIslwZAPsaUlhMnT2hdE9R7kQLZW
cDgqMpis6M0ayo8hcSQDK+/wZ4YLMl8kSFGbWaHLVKn+wbO/VezFsytMYI8k2fWQ
SBa0i2oPbOQJwLvuYlILwj+YQqHxpzvejBz2FzarIsn4oXcKt+5q4uA0ZD20lng/
flB/jiMdCy+QOKvP4jk88tO42X3NhJfWiBQQkgv4W8CKHJe8BWeouROS6gh3pgaJ
IAXU4+UZsBJ9vRGc1ZHsEk8O/H8wCSguRjtYjxqgH0nP1F5ejJUOpYvlu8M6LuJs
EryWD1NLeA63gUaTDWjEvDq8HWH2EVit3TdRubWBq6x/5uZHcnUkU8LcLq58tG6B
DB7/XSMfL0G2Dpk5tZU71y2TTglyaUq9ae/LsUQnqdOrOD8yD28=
=9vRS
-----END PGP SIGNATURE-----

--NZtAI5QFBF0GmLcW--
