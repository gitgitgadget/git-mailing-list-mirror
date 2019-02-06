Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 701911F453
	for <e@80x24.org>; Wed,  6 Feb 2019 15:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfBFP4x (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 10:56:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35001 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfBFP4w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 10:56:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id j13-v6so230347ljc.2
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 07:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=A/dyHK0jtJPZC4Kw9C6FHf5kLENNGPQpPj+lvrEdmuU=;
        b=pIEZGlizhdDIbi0LB0GnJoSvZol4NT3CI5G+cDclJWALqmGp/DIr+8eLNGIH/cM2lb
         Z4Pj3c4CPdZDZp2QLCmuKj7pexYbGSUn5ph+AAXLkiSjCEqR73z9afn0FlDsOyao5DZI
         +nWpJlAfiZ1nc4QZxsb50lcNfiZ3i0iJTGyxdZ+ZVc3JaGi24rc/M42CCrMSfgQyUz9i
         ejwJ0Tetnfk1GzOWhWP2x15YBpz06F6fI+imqETNvw002+lQJEgNla0Kbi8RbDy4a9ru
         mY/ORz/5bjUcgxno44bVwLDiRk8uB5HPFBtR+Ig/ZaDAjJtOWagXnGJZSzPixXsV8urL
         ytng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=A/dyHK0jtJPZC4Kw9C6FHf5kLENNGPQpPj+lvrEdmuU=;
        b=PpElhTGNcAEo/sgFEgLekPwbz+ThGhkNgVYiPhZAdz0HP4KCKqiikIUelWtnz1IJnh
         jP5McT3lSMiLHYzCKf2YPcpd5r70hYk+PpxHFK3WY9z2fwP+7z8qZaxxcZKAispfOYLm
         ORPcJDgoPUJ2TXGbQaZQWc7yvhg0XQcSx+ETeUwUoPRjc/6lG7xjXDa6sL51IVLQimXi
         OklnQ5+wGuufLdGKZp+TH/+I1qYDCgdA1vBg0KA60MHZPmIYdExMdkBT8LdubB5MndRM
         I9kQauSp47sY3YWYuNmFODglgi03nlQWZpIYlbngF1+1KjMp10aRzgyIT6y4+q6n4AKj
         eq6Q==
X-Gm-Message-State: AHQUAuZP8FNzsJqr+yk91GYGlAXA/t10R24ICeOXSB6vUcQd2C0PSti+
        P0GUJS4Lv3STQg4Jl+qd1lhRr/0m9Tqk+4FvuSinSHYVrRZH4w==
X-Google-Smtp-Source: AHgI3IbZ/CZqpNKrcumeMGcfbxYufxsK7GDn05vpu5kJTR4q8jYHc2wsB1rCVNPZUhAG4p5dDj07JA3fRLSevMIMpkM=
X-Received: by 2002:a2e:9457:: with SMTP id o23-v6mr6870260ljh.7.1549468610159;
 Wed, 06 Feb 2019 07:56:50 -0800 (PST)
MIME-Version: 1.0
From:   Corentin Bo <corentin.bompard@gmail.com>
Date:   Wed, 6 Feb 2019 16:56:40 +0100
Message-ID: <CAB=mBWk8u32m1i1=NcB-FETVs5GcCx_DP8dKKDC-_B3hNiuP_w@mail.gmail.com>
Subject: New contributors' grettings
To:     git@vger.kernel.org
Cc:     pablo.chabanne@etu.univ-lyon1.fr,
        nathan.berbezier@etu.univ-lyon1.fr, matthieu.moy@univ-lyon1.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, we are a team of French CS students and our project is to
collaborate to a free software.

We chose GIT as our subject and we will try to implements some
improvements during the three next months.

Our tutor Matthieu Moy, proposed some on this page
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas and we were
interested about the =E2=80=9Cgit pull =E2=80=93set-upstream=E2=80=9C were =
the idea is add
=E2=80=9C=E2=80=93set-upstream=E2=80=9C as a new argument to the =E2=80=9Cg=
it pull=E2=80=9C command and the
argument work like the =E2=80=9Cgit push =E2=80=93set-upstream=E2=80=9C com=
mand , and the =E2=80=9Cgit
bisect=E2=80=9C witch can find what commit is bad between two given, even i=
f
the old is bad, and the later is good. Are those still possible,
already done or bad ideas.

https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#git_pull_--set-ups=
tream

https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#git_bisect:_automa=
tically_determine_which_commit_is_old_and_which_one_is_bad

We look forward to working with you Nathan Berbezier, Corentin
Bompard, Pablo Chabanne
