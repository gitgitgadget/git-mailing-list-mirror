Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D4A1F461
	for <e@80x24.org>; Tue,  9 Jul 2019 17:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfGIRAk (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 13:00:40 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:61778 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfGIRAj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 13:00:39 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id BC8B7A1196;
        Tue,  9 Jul 2019 19:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:references:in-reply-to:message-id:from:from
        :date:date:received; s=mail20150812; t=1562691634; bh=9fJ2uwhflj
        I3PAzixZoyGkjbJttndc05LNitQ9W0cfc=; b=x7PAv24YQjkKuVqdNR4KZJ1o4f
        7dgVe4YgO44ht34xZ3JMinGFciLr1yvSk+QHGVmdwLQyOdjVdn41RUO2xOdl37zX
        R+8mLKgEhF9o9t1qAOsIl+pW8XEszWxy4lEdXIzwH2JPL86Z+kDJBuIYUzquIqbJ
        xspRkQPhK56JXQyR941L515fQoBSAHJTA8fUHufWdBvRh3C+dFAfVwo1THLXFBFc
        GjcjXOvjRgmGiBkN2L5qCB3DbCgEhRPHyDYiSkdmBPP/ijIXLi2sI2xdDZ3tQhki
        UJwtqEP4/M4CeuOBVTwTEAl4M1ymirpOqU2UzRdxlFoXXOWVAmCO/BlNXS2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1562691637; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJF2R5m2gqTBHgPy5VplkDpENu8T4F3CEa1XqNxor8I=;
        b=w2oZY/uyyWULalRGJq8pQJx8+YOpSstN4/VxOtABgJ2g/Q5Die9pAh1cBmLybNZxCaDHZE
        nC1752/0YZoClGv4NdXLQ98Y3v6nqWCjTYeigXFyss7MAcm1zYSFMbBaIrgL0QS55iZ5ae
        BIhgkYRoVF9KNY2cZvl9srYx/qU5G2Obat1ZgRNMYonIhIGdVo6KrTadavragSGvv1vXsL
        Ibjpr1YEsfInVvbfSGlFampuj7Ry0G+s9vCD/ZB8tzbukMuXPTBmhFMlxZvqZ+IJV1zw59
        WbXwQfBje22uTLtxPorQInRdAKKYiWwchbg3elFnkmkpAEd+0mJpZhmAy0t5Ug==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id FOJyoB6YhYok; Tue,  9 Jul 2019 19:00:34 +0200 (CEST)
Date:   Tue, 9 Jul 2019 19:00:33 +0200 (CEST)
From:   usbuser@mailbox.org
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <275487563.12198.1562691633735@office.mailbox.org>
In-Reply-To: <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
References: <423596682.8516.1562665372094@office.mailbox.org>
 <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
 <1152121968.7459.1562688927235@office.mailbox.org>
 <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 09 July 2019 at 18:35 Elijah Newren <newren@gmail.com> wrote:
>=20
>=20
> Hi Roland,
>=20
> On Tue, Jul 9, 2019 at 9:17 AM Roland J=C3=A4ger <eyenseo@mailbox.org> wr=
ote:
> >
> > Thanks for answering Junio.
> >
> > I get what git does. But I believe that either the documentation ist wr=
ong/ambiguous or --no-ff and --ff-only should be able to be combined and ei=
ther should be fixed - preferably the later. What I want to say to git is "=
I never accept a real merge; please make a merge commit, even if it is redu=
ndant/empty". And I believe that github and gitlab allow to configure somet=
hing like that.
>=20
> Please don't top-post on this list.
>=20
> I agree, the documentation is wrong or misleading and there is a
> wording change we could make to improve it.  But, in particular,
> --no-ff and -ff-only are completely incompatible.  A fast forward
> implies no commits of any kind are created, while --no-ff explicitly
> requires one to be created.  More on that below...
>=20
> > My manpage tells me the following:
> >
> > --ff When the merge resolves as a fast-forward, only update the branch =
pointer, without creating a merge commit. This is the default behavior.
> > =3D> Allow either
>=20
> Yes.
>=20
> > --no-ff Create a merge commit even when the merge resolves as a fast-fo=
rward. This is the default behaviour when merging an annotated (and possibl=
y signed) tag that is not stored in its natural place in refs/tags/ hierarc=
hy.
> > =3D> Always create a commit, even when FF
>=20
> Not quite; I'd instead say:
>=20
> =3D> Always create a merge commit, even if FF is instead possible.
>=20
> In particular, FF means there is no commit creation.  I agree the
> documentation needs correction here, it should be:
>=20
> "--no-ff: Create a merge commit even when the merge could instead
> resolve as a fast-forward..."
>=20
> Would you like to try your hand at submitting a patch with this change?
>=20
> > --ff-only Refuse to merge and exit with a non-zero status unless the cu=
rrent HEAD is already up to date or the merge can be resolved as a fast-for=
ward.
> > =3D> Fail if FF is not possible
>=20
> Yes.
>=20
>=20
> Hope that helps,
> Elijah

I hope this is not-top-posting? I'm new to this and know nothing apparently=
.

If I were to write a patch then I would very much prefer to implement the b=
ehaviour that I expected and want to exist - either by a new flag and fixed=
 wording, or just fixed behaviour. I guess the latter is a no go. Could you=
 point me in the right direction where I would need to start to add such a =
flag?

Additionally I would also want to change the wording for --ff-only, as it c=
urrently reads as if it only performs a check (which would lead to the expe=
cted behaviour) but does more than that, as it prevents "real merges" altog=
ether.

Thank you for your time,
Roland
