Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B19C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353202AbiCUUO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353160AbiCUUOo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:14:44 -0400
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9892647
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:13:06 -0700 (PDT)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
        (Authenticated sender: jn.avila@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 4682E5FFBE;
        Mon, 21 Mar 2022 21:13:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1647893584;
        bh=LDbwWe8DIs+CxsvZQ27aZFC7y9sfIbXeSp0zVpSxBwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xunii4gkpTqC+9K41XvNuUs8m6Jl+PW+zcwDL8i0FDH5a0PuAJTvlsH+EwdwXTyTq
         Kafv8dwog9RrwylonFNTg++pDtj1a0rDE5xFerqT5daLUpiig4N3VJ+tPctbR2QNoI
         IollNmTLLYzFj1TZboKDnETYqbHn+EaT0Rj3GIM0JXS5xPIWdoldHgVFYapVcz6aAt
         u7WQ0n86NOxShEy5RqMLKjkFkoS/i9xv62Dg+GUpXgjJmH5Tt0Xibyy7J2wuJaE2p3
         2bXyd+F6kpK1axoYXkzoxs/NOTsGqDKAx7b0S2gOfG6sVcjrFrmLi2fGYITQytjnmY
         AVo/5LyhCvHSQ==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 0/7] More i18n fixes
Date:   Mon, 21 Mar 2022 21:13:01 +0100
Message-ID: <2096494.irdbgypaU6@cayenne>
In-Reply-To: <xmqqlex3xh4d.fsf@gitster.g>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com> <220321.86ils79z0c.gmgdl@evledraar.gmail.com> <xmqqlex3xh4d.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, 21 March 2022 20:03:46 CET Junio C Hamano wrote:
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>=20
> >> Disclaimer: neither am I a translator nor a user of a translated Git.
> >
> > Just to add to this:
> >
> >  - Careful use of sentence lego is OK, but e.g. in my native language a
> >    command-line option would use a male noun article, whereas commands
> >    would be feminine.
>=20
> Hmph, if we gather wisdom from folks with different native languages
> and varying rules, I am unsure that we still can say that "careful"
> use of sentence lego is OK.
>=20

To me, this is not sentence lego because:
 * the placeholders are replacing constant strings that won't have declensi=
ons=20
or grammatical agreements
 * the placeholders are linked to content where the variables have the same=
=20
type, which makes them have the same genre for each language. This is the c=
ase=20
for commands, options, env variables,...

Given these prerequisites, there's nothing that needs careful lego, because=
=20
there is no risk at all. The only needed refinement, which I haven't addres=
sed=20
in this series,  is making it clear for the translator what the placeholder=
 is=20
referring to in order to get the wording correct.



