Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 129C11FAE2
	for <e@80x24.org>; Fri,  2 Feb 2018 09:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeBBJgI (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 04:36:08 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:40940 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeBBJgG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 04:36:06 -0500
Received: by mail-ot0-f172.google.com with SMTP id x4so19698363otg.7
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 01:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cm1HRiURfvwP2dwu3oaeorwxx7U+519KN94+pw4XLdY=;
        b=mYA6zX3OB6H2lzUks/gBZDfjLS5xvG+J95/ksRkOTr1awP09aOnpGbt4KOhreFgcY+
         So+nU01IIb/dOtfCvQFEMussLOL3Qx7avC/hWzkQWAirGn5yylyOpkYjy4ah1OPt/tVI
         2/4mLr5ZUAQibNTyjE2L7890YzlR9hQ9NQUAa3lK6AF0aOhMR/e9iYrhcmR3V7GLeL1g
         eJJxTgPk1EEyX1pYlKGUJYnC+PEaGjkr8W9aRAOxMvPdZWrbvC+FlaM31IOm1Gw/QRpT
         5Xq4jb/CvZOVIC38HYWkYrGOEOn35641LdLxE82L8/W8wGVep606b1fxRUaadLgpC5T7
         Uc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cm1HRiURfvwP2dwu3oaeorwxx7U+519KN94+pw4XLdY=;
        b=Gmje0BTDYRhahnrIsY4aEU9NDgqpuWuDXKq32y7VkXOZVhbet3yqjgdOVS2H8TKBSQ
         7BHGVEiorfX3kr8eVA+NYYxV1jw0BcryI5OMo9AFWSB2W16+RDNHrN5Zy6qw/mmNi+CK
         yHJrvYBZUTJ/H22QVyYE1e+enN5MayJ/2KeM9/V6hdcV5gguQcE/npxoiMAWDT9pAETn
         aDAf2JapO+tVkKJK1Kv61e9kp8ySWvTGmM1WHqbChU6gt89YagzQ5A2A0G+P1oFsNkiO
         ZCcVeWHXgeQBFZeTyx0EnYjH1btPOBpmXLqSWe5X5eq1clnD0tnujEZ0ey5mwMftmBVl
         jaBA==
X-Gm-Message-State: AKwxyteNN5OczvqEwPJC0i9IXYTVMtdM4/m7HxQm21EbVoA0Opk8F6/k
        u9jR8qbBhHJazh15FXoe9YnO94lPSnRNsemSBnI=
X-Google-Smtp-Source: AH8x226Kq09AveQDJbL8vli1IoGIayy09E/tY3dllHl10Eoy/42IphECURAzJbyTyRzYu9SEVPOTIDUXFxQTv9Xr+AU=
X-Received: by 10.157.47.177 with SMTP id r46mr19647980otb.301.1517564165623;
 Fri, 02 Feb 2018 01:36:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Fri, 2 Feb 2018 01:35:35 -0800 (PST)
In-Reply-To: <CAPig+cQzdFhUzwDykO8su=ne0qZr6=51vTxXbMYYnceuH_N=iw@mail.gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-3-pclouds@gmail.com>
 <CAPig+cQzdFhUzwDykO8su=ne0qZr6=51vTxXbMYYnceuH_N=iw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Feb 2018 16:35:35 +0700
Message-ID: <CACsJy8ALCro_4n0u2TBp8Lon_2kX49w9UcAnD8awHmsoriQ7-Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] worktree.c: add update_worktree_location()
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 2, 2018 at 3:23 PM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Wed, Jan 24, 2018 at 4:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> diff --git a/worktree.c b/worktree.c
>> @@ -326,6 +326,24 @@ int validate_worktree(const struct worktree *wt, st=
ruct strbuf *errmsg)
>> +void update_worktree_location(struct worktree *wt, const char *path_)
>> +{
>> +       struct strbuf path =3D STRBUF_INIT;
>> +
>> +       if (is_main_worktree(wt))
>> +               die("BUG: can't relocate main worktree");
>> +
>> +       strbuf_add_absolute_path(&path, path_);
>> +       if (fspathcmp(wt->path, path.buf)) {
>> +               write_file(git_common_path("worktrees/%s/gitdir",
>> +                                          wt->id),
>> +                          "%s/.git", real_path(path.buf));
>
> For the path stored in 'worktrees/<id>/gitdir' (and in wt->path), this
> and other worktree-related code sometimes treats it only as "absolute
> path" and sometimes as "real path". As a reviewer, I'm having trouble
> understanding the logic of why, how, and when this distinction is
> made. Can you explain a bit to help clarify when "absolute path" is
> good enough and when "real path" is needed?

Of the top of my head, I think it's "anything but a relative path".
real_path() is normally used to normalize paths before I compare them.
Writing a normalized path down is nice to avoid "../" but I don't
think it's strictly necessary. Well, it's also prettier when you have
to print the path out. Printing "/foo/bar/abc/../../xyz" is not nice.

Hmm.. looking back in add_worktree(), we also write "gitdir" with
real_path(). I think the problem here is that I should have
real_path()'d "path.buf" _before_ doing fspathcmp(). Maybe that's
where the confusion's from.
--=20
Duy
