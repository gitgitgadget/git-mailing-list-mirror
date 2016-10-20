Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FCF61F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 16:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbcJTQ5E (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 12:57:04 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35219 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbcJTQ5D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 12:57:03 -0400
Received: by mail-qt0-f195.google.com with SMTP id g49so2223122qtc.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TnvnVW4LWp4rA0UNR3PcniHxaBxQLixONwVvYvDDQLg=;
        b=GSBpqNrHI+j7PSbl5coc6awRIHCyRZtvhfoNV0nweRqFNovtU5W+rghhroHrdkJIe+
         8B2s6EgBDJWYDiCUXY5H62NNDpNDLTOxf4ZqYPy1aR2nJT+n7aulA5MTrJG18J9u45fI
         8E8X2lqpGMcAKzmWnzGNvCJg7qeTsBt8kHoYceMUWRx/x9q/MbYDxiNwjBiTbftY4fEM
         mCVKcFUloCaPW2IwrPenCtt8Ir8yOiVnrx/z77aHw3EhGXmYjEFNmRsARNseZ9WP7peq
         ASTZ/Tjto4GcynScMc5C0dlXHWq0YN1TtS5XweJgRYN+pZN17MGgenErjjqijTCegAQo
         Ohag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TnvnVW4LWp4rA0UNR3PcniHxaBxQLixONwVvYvDDQLg=;
        b=NHQ++M6yvkao0hYvJBofm7TmAQpR9fWO4UtZVjX+4a0FhD0YNe9ty/2kVc6PFihJMH
         LjxerLIbYzgcvEtbzmrsNJmg8yesAGR3GaC62c6di1t7HUS2foacv0bbTBZTFwakoeFA
         bczQFZiIhi4gYN23nKBhug1S1cDwRLMcIXprdqLOevXKbCHSunMKMyeOgCh54/U7oiJO
         0lPHzMpW6xcHaPNsYC7FAxIRijg+gS0GrhPm7EDWJM5EHvXAymMnHPdKTeWZFedyExlX
         xxwi7mWtlDNff13oOA9GghWYh8qHP0KAdYk2hV3dB//BD37J/6mBImSWhQzDZAa14d/m
         sFZQ==
X-Gm-Message-State: ABUngvflF5lIGtMeCKKsTkEt3WcQpFqfxveUehQbpThIbEMoCw9y/uoh++PAWyPnxU4EBJDi
X-Received: by 10.237.33.147 with SMTP id l19mr1342016qtc.58.1476982622564;
        Thu, 20 Oct 2016 09:57:02 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-12.NATPOOL.NYU.EDU. [216.165.95.1])
        by smtp.gmail.com with ESMTPSA id z188sm24046208qkb.8.2016.10.20.09.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Oct 2016 09:57:01 -0700 (PDT)
Date:   Thu, 20 Oct 2016 12:57:01 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH 2/2] tag: send fully qualified refnames to
 verify_tag_and_format
Message-ID: <20161020165700.qwgli5mbya3d7nzz@LykOS.localdomain>
References: <20161019203520.zevkb75at2nrogdm@sigill.intra.peff.net>
 <20161019203943.epjxnfci7vcqg4xv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bncfmi72et2upbvt"
Content-Disposition: inline
In-Reply-To: <20161019203943.epjxnfci7vcqg4xv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bncfmi72et2upbvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2016 at 04:39:44PM -0400, Jeff King wrote:
> The ref-filter code generally expects to see fully qualified
> refs, so that things like "%(refname)" and "%(refname:short)"
> work as expected. We can do so easily from git-tag, which
> always works with refnames in the refs/tags namespace. As a
> bonus, we can drop the "kind" parameter from
> pretty_print_ref() and just deduce it automatically.
>=20
> Unfortunately, things are not so simple for verify-tag,
> which takes an arbitrary sha1 expression. It has no clue if
> a refname as used or not, and whether it was in the
> refs/tags namespace.
>=20
> In an ideal world, get_sha1_with_context() would optionally
> tell us about any refs we resolved while it was working, and
> we could just feed that refname (and then in cases where we
> didn't use a ref at all, like a bare sha1, we could fallback
> to just showing the sha1 name the user gave us).
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I think you'd really just squash the various bits of this into your
> series at the right spots, though I don't mind it on top, either.
>=20
> The big question is to what degree we should care about the verify-tag
> case. I don't think it's any worse off with this change than it is with
> your series (its "kind" becomes "OTHER", but I don't think that is
> actually used for display at all; the name remains the same). I'd be OK
> with leaving it like this, as a known bug, until get_sha1_with_context()
> learns to tell us about the ref. It's an unhandled corner case in a
> brand-new feature, not a regression in an existing one.

I see now, I think I can sprinkle some of these changes on 2/7 then. The
rest should be doing 4/7 and 5/7. Does this sound ok?

--bncfmi72et2upbvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYCPdaAAoJEEaPEizoFiKV+k0P/0XIEZJ0pLb0H0QnWPzyyIk3
AQfVVqVPaOVpJd2AptT9wh12dETuL3gezXHHj7NI1GA3+QEfi7R9rCHU6Lsl6ASy
pUotJHc/T0f9EilDm+4DVLk8NKzestyDAWdnjDTHHH27uSr0SIKtM2bn1sn5taze
qSKO67rvA1ZDtLzDoqdFzbxVt0rk+/e2ABzokNEBPAtXuOqKViZKLbotfBS07CqB
MHH09iCIEcMO6k0qPxm32+VFKyKDf7nc8J8vh13oNSRRYR9sz5O6CmALM8QoeISw
6iUwIlV6FyYdd4Uk5zvmmh1T7BhVW1u3PwITEBZYtmIlOWKLY/DUbADNGua8DQ9h
8UM9Q0U3FzRaVsn3joVaKgygC2xElMSYsgSBhP8LzDSeQsBB6fiXiEVeg3XC3pzL
rROIWQmUplZzy3A+IvJR21CXz6lmg458blcdjPX+KvCrPBZlo0xgO9VbJ0GOiYH0
ZDXQbNkFkYZPEUlZPWE4kAidbr4a90ljrdhgU8yHLVg5PhLURGas8+9TelJPSaQp
r3wGvf5LlQuzsR4lxxBXGmj5GbEHKB/lgHlsZG0qFl6ousCRuTQ83n/EEVckTSTZ
g4Fyhou1m09VZ2yL1NchTKgjz1UXS2Kpd20VSwsref//2y4TEgJl14Ycy/eochjF
TR6kcnkpiGYGfT5plkZm
=QaoJ
-----END PGP SIGNATURE-----

--bncfmi72et2upbvt--
