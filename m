Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD30C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 08:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiAEIVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 03:21:11 -0500
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:60006 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230407AbiAEIVL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 03:21:11 -0500
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:d7a9:f807:da56:3cee])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 27D9558F319;
        Wed,  5 Jan 2022 09:21:09 +0100 (CET)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1641370869; bh=su1+ZCEk7Rq+45QQlTQ1Cv7D+ym3UGK0ccFEO3zKI1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Df+4rCq6PSAXQTH2J+gQGTrBeOLLviWZOhnpx0UXk1IMblvAXoWbSKi004cSomoby
         CO+Ocb1stfe0Y16LBZvj7CRnaIJYyDm2zy5nQq9cmngR4Ve1e6G7zJ+GvssnisF2vM
         EmJR/IvmMYGOIEjFooZ9PskpIl4YKLqNKzcHL4hc=
From:   =?ISO-8859-1?Q?L=E9na=EFc?= Huard <lenaic@lhuard.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 0/1] grep: align default colors with GNU grep ones
Date:   Wed, 05 Jan 2022 09:21:02 +0100
Message-ID: <12926486.uLZWGnKmhe@coruscant.lhuard.fr>
In-Reply-To: <xmqq4k6kjvdd.fsf@gitster.g>
References: <20211216115622.85506-1-lenaic@lhuard.fr> <xmqqh7b88b3o.fsf@gitster.g> <xmqq4k6kjvdd.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le lundi 3 janvier 2022, 23:40:46 CET Junio C Hamano a =C3=A9crit :
> Junio C Hamano <gitster@pobox.com> writes:
> > [=E2=80=A6]
> >=20
> > The UI color choice is so personal, which does not help us either.
> >=20
> > Having said that, I'll keep an eye on what others say on this
> > thread.
>=20
> It's been a bit more than a week and it seems nobody else is
> interested in supporting this change [*1*].
>=20
> Whether we want this change or not, I just noticed that the real
> patch [1/1] has no commit log message, and most of what is in the
> above "cover letter" would would make a good material for the log
> message.  Perhaps we'd want to redo the log message if it turns out
> that we want to take this change.
>=20
> [=E2=80=A6]

Thank you very much for your feedback.

I=E2=80=99ve just re-rolled the patch to only move the cover letter to the =
commit=20
message in case the patch is eventually accepted.

I proposed this patch because I thought that people picky about colors woul=
d=20
have customized them anyway and people less picky about colors would leave =
the=20
default and would find smarter to have the same color scheme for different =
tools=20
doing the same thing (`git grep` and `GNU grep`).
I choose to align `git grep` on `GNU grep` because the latter has a more=20
colorful scheme and elements already colored in both schemes are already=20
sharing the same color.

I however understand your points and I would understand if the patch is=20
dropped if it isn=E2=80=99t worth having to justify a change of default val=
ues.


