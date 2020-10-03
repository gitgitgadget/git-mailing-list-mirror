Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B51CC41604
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 19:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2052D206C1
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 19:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgJCTyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 15:54:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43230 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbgJCTyC (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 3 Oct 2020 15:54:02 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8F34A6044F;
        Sat,  3 Oct 2020 19:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1601754811;
        bh=bezrzKFmoGPWpUqSr//rozt9E6XSo9kuKeZZczzGeC8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Yl2ibtZO5jMMV2ASjwPYhZxc621GupblGrCsLse+2DB7Wqy0dT5nPxHEMMA7yWCeB
         2jhJkaBuiuusSNx/ve1Tg8KP2FQJElhQTCfNe3QElrITcKyReB45xNsyZz47JxYdKa
         MaYCrGyAKIzSbA/Jr5grqCgHRYLVXdws9ps7bEl8bmS13Db/gXVR4esW1wFTUzIzCT
         EWDaixnSHE6DpAkSDRtxkcR6vkbnDuw6CpTMEgO75PNx9MBO7/KtHrXuy7u9num2H2
         D0nwhnnGe7sgcl+zmOfBJJaqQMRvogtZTkBJUYLs5yeB1z7Tolin7pVdQ3Z0IOS4HX
         YQ4eZsBiAgNLK5N8mkghIJvYi+Dbc7uLHRMNoa8fNZCOZOnwzkhLpINwXOXaZ62ekK
         N1XEx6UUnQRTuhu4JC3moma3GSzr+w4RIwb+vSg0z7E6F1vEC9ouyh2EtMq4A6oMCg
         zjCWBrcEkQqAoSmhv274hS1z/ppqDm5Kd3UmNhBXAq4if3/BD1N
Date:   Sat, 3 Oct 2020 19:53:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shengfa Lin <shengfa@google.com>, git@vger.kernel.org,
        nathaniel@google.com, rsbecker@nexbridge.com, santiago@nyu.edu
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
Message-ID: <20201003195325.GL1392312@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shengfa Lin <shengfa@google.com>, git@vger.kernel.org,
        nathaniel@google.com, rsbecker@nexbridge.com, santiago@nyu.edu
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
 <20200930232138.3656304-1-shengfa@google.com>
 <xmqqlfgqes95.fsf@gitster.c.googlers.com>
 <xmqqtuved70y.fsf@gitster.c.googlers.com>
 <20201001034350.GB2930867@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GeDkoc8jIzHasOdk"
Content-Disposition: inline
In-Reply-To: <20201001034350.GB2930867@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GeDkoc8jIzHasOdk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-01 at 03:43:50, Jonathan Nieder wrote:
> Junio C Hamano wrote:
> > You can let the existing code produce its natural result and then
> > when the "force UTC" flag is set, override the offset part to +0000
> > if and only if the timezone was obtained from the current
> > environment (this if-and-only-if is necessary, because you do not
> > want to rewrite and force UTC when you run "git commit --amend"
> > without the "--reset-author" option to update a commit that was
> > created somewhere else to UTC).  That way, we do not have to futz
> > with TZ environment or tzset.
>=20
> Yes, I think this is simpler and nicer than the proposal in my other
> reply.

Yeah, I agree this is more desirable.

> In addition to not having to futz with TZ, I think I like the
> semantics better.  The motivation that started this thread was not so
> much "I want to set a custom timezone to blend in" but rather "why are
> we recording the timezone at all here?"  In that context, it makes
> sense to me to have a setting such as
>=20
> 	core.recordTimeZone
>=20
> that I can turn *off* to say that I don't think datestamp() callers
> should consider the timezone to be information worth recording (and
> instead they should write +0000).  To me that seems a little simpler
> to understand than user.hideTimezone since this focuses on turning
> some functionality off (recording of the time zone) instead of turning
> on a new stealth mode.

I'd like to make one suggestion here, and that's that instead of writing
"+0000" in this case, we write "-0000".  As far as I'm aware, it should
be parsed equivalently but it mirrors RFC 5322:

  Though "-0000" also indicates Universal Time, it is used to indicate
  that the time was generated on a system that may be in a local time
  zone other than Universal Time and that the date-time contains no
  information about the local time zone.

This is exactly my case.  As you can tell from my emails, I'm not
physically located in a UTC timezone, but my system is in UTC and uses
that for timestamps.  I use UTC because I know and work with people from
around the world and it's more convenient to use an objective standard;
my real time zone is unimportant.  That's materially different than
someone who's located in Reykjav=C3=ADk, where we'd want to write +0000,
since they are physically located in a UTC-equivalent timezone.
--=20
brian m. carlson: Houston, Texas, US

--GeDkoc8jIzHasOdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX3jWtQAKCRB8DEliiIei
gZMsAQCaoY0ghXweIp/0LBmXy3OAPqdbs2Kd1R3wuZSypSNR6AEAwU5EcotH3uzr
Go/HJYW6J0uEFPyuFZcZ+rrgNTEqOwI=
=ht32
-----END PGP SIGNATURE-----

--GeDkoc8jIzHasOdk--
