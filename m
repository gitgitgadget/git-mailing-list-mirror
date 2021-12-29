Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6A7C433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 14:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbhL2OGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 09:06:12 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:37094 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233228AbhL2OGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 09:06:12 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c5e0:3de3:cfd4:f8ca])
        (Authenticated sender: jn.avila@free.fr)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id E1A517802E5;
        Wed, 29 Dec 2021 15:05:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1640786771;
        bh=CnqEWUXXSd99pTp9Cwubd9CBbiCwJP/8CPNAMCWJRC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1GIaz8MOMnjBL5hsSjz/XVXEOoQ1tWbOr9n8bfF0bSR8HsarHnx3VQyDZJvaFqeW
         AyoIGAlH72tE7J1FAr9K5CBSeVQ2E18An2eeDcv5ffcssbdViYzWvcHTRbgPsX7xvn
         rOaVxZDfR+/RfbGApbMGi6UEnuC18E1bTgNRSNdBhEMbMVA9vXmCWsUeRCP4dFd7qe
         uJYkWsZ1PXF21NpFTh1zI4wqsCLCOfnTPg72POXhtJjYNzdoPzVl+4RYqpv6M6hDma
         n7a1ZbJVoAcVmfd0eRnzIZ95qX8xZuKyel+BbHEji97VyK/g/aXjHBuDoYDZwMwxon
         /8xCz+OHZ0v9g==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 05/11] i18n: tag.c factorize i18n strings
Date:   Wed, 29 Dec 2021 15:05:59 +0100
Message-ID: <2759083.5hoLIL5Qz8@cayenne>
In-Reply-To: <xmqqee5xvb13.fsf@gitster.g>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com> <211228.86wnjpip1i.gmgdl@evledraar.gmail.com> <xmqqee5xvb13.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, 28 December 2021 01:16:40 CET Junio C Hamano wrote:
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>=20
> > Does it really matter? I.e. we've got plenty of options parsing code in
> > various places that might complain about issues A and B with your
> > command-line, but will only emit one of those at a time.
> > ...
> > But until such an improvement something as trivial as minimizing the
> > diff size (i.e. not needing "if" -> "else if") seems preferrable to
> > slavishly maintaining compatibility with the exact sequence of errors
> > we'd emit before.
>=20
> The patch is already touching every other line.  Making the change
> into a replacement of solid block into another solid block would
> probably make the resulting patch easier to read.
>=20
> And by doing so, the submitter demonstrates to reviewers that they
> _care_, as such an attention to detail is a sign that the submitter
> thought the ramifications of changing an early die() into an
> assignment that keeps going.
>=20
> So, yes, it does matter.
>=20

Sorry. The developer hat was taken off ; will reroll shortly.



