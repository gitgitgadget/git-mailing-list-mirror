Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A69C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 15:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C7060F46
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 15:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhJXPp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 11:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhJXPpv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 11:45:51 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970F7C06122F
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 08:43:07 -0700 (PDT)
Message-ID: <348299a1-1333-9792-7b75-fc310f5ce47e@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635090185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ccxC8RVeOk3/ZuFByWk3RG3tLc/b4eqrf9BoWJiONw=;
        b=H2ttgnCdCUG7AU9Km2kb5R+RQxWRAZqTfYkZ49hNQ6jtQHbhErAC2sVw3CEs2uA5ModwJc
        CRP3QuHD0W7Ohx2k7bzzhDC+12n2UdJdHoI7+B7CKt3pCyqpFiEgGVgiZdSCwRsRHx7cKg
        kbE/HFKIe47Jap8sGQj+BDj0frkLw06udcIvnDtUvBMIuWaR5x6jOo+D9tdFFZkMsdcqCZ
        FgC2mlX1mNGTvUrufAwcFIkI4vNUi/2Mn9dspbSVHXHKFHMhZmmpdALz+7wJ8XSFNTreVO
        mvvPnihBacdBiuNq2Xb8rK5zZu+PFA2MPVTs8TP6Ti069ak0GyTjqtSQs9yAJqviGCQrfS
        3h+BJNHWo0z13vjYUGpmud6v1lUbdNdVLsWT8RRYChUhzm+K2YRsiRjBdBxauz7m792gDB
        LjMOQPLMjW0zfxoBb4i9oVYLmJJUt6FnQjWu5qNnuPWQwRAm0+FlI5IOp9T5GQjVBvyjGv
        ySJH6xposBpjDH+4VYPV2p+rgqxOLUsQ+4w75vZTTgVujzkFVnqLZTa2QwcZyxxwOdwskH
        WWaZo90+yfWbZqeT8bpNrbanG4AbEtKAj3P0yR8vmqE3dowvSzzTkC1ZudLz0wlmOrC1VN
        LaOeqp9c8u2/1Sgxute272ppuRfz9zejIitMhD63Q0EsMW31t9ivM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635090185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ccxC8RVeOk3/ZuFByWk3RG3tLc/b4eqrf9BoWJiONw=;
        b=MT2wu76fzzf4PdTNGIhzBEX3S8ELpMPe1pHdH3TEcpBGApbnBfrYpGuhenIdydW/bztMze
        ZwlfA3if0FQd0pBw==
Date:   Sun, 24 Oct 2021 11:43:02 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] pretty: add abbrev option to %(describe)
Content-Language: en-US-large
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211024014256.3569322-4-eschwartz@archlinux.org>
 <xmqqv91n57g4.fsf@gitster.g>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <xmqqv91n57g4.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------T9ArUOwc30My99Ff6fp5DU4g"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------T9ArUOwc30My99Ff6fp5DU4g
Content-Type: multipart/mixed; boundary="------------YIPhg7Cu1vxjjYO9h0zSP5Ma";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <348299a1-1333-9792-7b75-fc310f5ce47e@archlinux.org>
Subject: Re: [PATCH 3/3] pretty: add abbrev option to %(describe)
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211024014256.3569322-4-eschwartz@archlinux.org>
 <xmqqv91n57g4.fsf@gitster.g>
In-Reply-To: <xmqqv91n57g4.fsf@gitster.g>

--------------YIPhg7Cu1vxjjYO9h0zSP5Ma
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/24/21 1:15 AM, Junio C Hamano wrote:
> Eli Schwartz <eschwartz@archlinux.org> writes:
>=20
>> The %(describe) placeholder by default, like `git describe`, uses a
>> seven-character abbreviated commit hash. This may not be sufficient to=

>=20
> "hash" -> "object name".
>=20
>> fully describe all git repos, resulting in a placeholder replacement
>=20
> "all git repos" -> "all commits in a given repository" (there may be
> other valid way to clarify, but the point is that 'describe' does
> not describe 'git repos' in the sense that my repository gets
> description X while your repository gets description Y).


Good points.


>> changing its length because the repository grew in size. This could
>> cause the output of git-archive to change.
>>
>> Add the --abbrev option to `git describe` to the placeholder interface=

>> in order to provide tools to the user for fine-tuning project defaults=

>> and ensure reproducible archives.
>=20
> Note that it is sad that --abbrev=3D<n> does not necessarily ensure
> reproducibility.  To be more precise, I do not think it sacrifices
> uniqueness to make the output reproducible.  You can get more than N
> hex-digits in the output if N is too small to ensure uniquness.
>=20
> So it indeed is that this line of thought ...
>=20
>> One alternative would be to just always specify --abbrev=3D40 but this=
 may
>> be a bit too biased...
>=20
> ... to use --abbrev=3D999 (because 40 is not the length of a full
> object name in the SHA-2 world) is the only reasonable way, if what
> you care about is the reproducibility.


Right, I keep forgetting about the current work towards SHA-2... that
being said I somehow feel that 40 hex-digits will probably be reasonably
sufficient even if commit object ids can become longer than that. So it
is technically true...


>     Side note.  I think "git describe --no-abbrev" is buggy in that
>     it does not give a full object name; I didn't check the code,
>     but it appears to be behaving the same way as "git describe
>     --abbrev=3D0" (show no hexdigits).  Fixing this bug may possibly
>     be a low-hanging fruit.


I... did not realize that --abbrev, which takes an integer value, could
be specified with a leading --no- in the first place. :o


> But even if the feature cannot be used to guarantee a full
> reproducibility, it is a good thing that we can now add this feature
> with minimum effort thanks to the previous two steps.
>=20
> The refactoring I suggested in my review for the previous step will
> shine, if we want to do a good job parsing the --abbrev=3D<n> option,
> since such a code organization would make it a fairly easy addition
> to introduce "integer" type that calls match_placeholder_arg_value()
> to read the option value (like "string" does) and validate that the
> value is indeed an integer.
>=20
> Would we want to support "--contains" as another boolean type?  How
> about "--all" and "--long"?  All three sound plausible candidates.


I didn't have any immediate use for these options. To be honest, I don't
entirely understand the purpose of:

--all, which causes git describe to report things like "heads/master"

--contains, which causes git describe to report different output
depending on the status of later commits being tagged


They may have their uses, but I'm not sure those uses include writing
metadata to a git-archive tarball at least. I believe the results would
inevitably end up changing after the fact, whereas only matching
existing tags will tend to be pretty reliable as a tag is, in most
(all?) cases, pushed at the same time as, or before:
- the commit it describes
- commits which are later than the tag


On the other hand...

--long could be interesting to some people, although for, say,
generating software version numbers, a tagged release will typically
omit that information in my experience. For the sake of thoroughness I
could add that too.

--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User

--------------YIPhg7Cu1vxjjYO9h0zSP5Ma--

--------------T9ArUOwc30My99Ff6fp5DU4g
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmF1fwYACgkQzrFn77Vy
K9aDlA/+Lay19T9J/CmK0GYQ+Jo7RlVQDyK7RcU8BscDOt5qlcP7gPggr8LrHMLj
+WVH505jILcJ6j7hBvgNLGD3BQovjYMFhRDuCfXoP4h0rjmrWqarmOw+DwinAzpy
Q+YSA0dZpLW837mOm/qVn5/xY+RtStUguEHm62+klvFwE7SyvcnjvuJNIj/kcof/
cnkDX+DU9MhcGHAq18hAwOksZifpAFbRhvASFtccHMPKrX3Xi4NGAmvArpVj1/fp
zHZ6Rbt034sz8chaGknhpBvkrRhcC6e4gYXrnxqP/xPoRZR2wKu+9sEXe0WTaQTg
SzYiIQY7E9qPOmfwTd4z0564u1E7wY6gAuZntmpxv5OwRTzbMvpBw9aZCIDZxtlI
BmX4kOBLp5JHHw+D3TF4EZL+9tpuqKKUVt3hfaOzqU7VtI7QTr4DUYeHmtLhTQcZ
deTlz4RStI4s9jhujwjyG0W0auJ0yvar8AfOo0cG1SWVrkWDyjoSdPA9HNtghI4G
+u5Vqd56uBcB2mh22nEBShIMhGHq9wB6KFDAsHNj5xDt5+VEE/gE5hV1o0lOKJzf
ba6AWa7FfzT5frc6v8/x9dFN/Zk6cJ4Nrz3bL1vywYrGI2rHXtPQ7juln7+HOPhS
0sO7JhIgcfwE69Dm9VR7CDDY7t2MtRcQ73c3L/v8pJjUq6Z+qsc=
=apeX
-----END PGP SIGNATURE-----

--------------T9ArUOwc30My99Ff6fp5DU4g--
