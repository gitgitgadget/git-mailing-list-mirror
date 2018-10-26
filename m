Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2BC1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 03:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeJZLvV (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 07:51:21 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55676 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeJZLvU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 07:51:20 -0400
Received: by mail-it1-f194.google.com with SMTP id c23-v6so4109083itd.5
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 20:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=51ARn8Jpj675g3r68sX56Uf15g+0Xnk99my/nU5jT5s=;
        b=VKWECA0ILTQNNq0bzZWzSTNxk8oHab3SDcSwY55SiiFs+wrLqh1OYas7J2YCwpHU3K
         07ynuxCjAqFq0CCJ8xkePi+3npqmKBGe9ThmRx/ADu8s6ByxfDMF+gITvVh+UaA56yom
         SvFsF1hycnLr3H3vJSpFILjSQURQUL0QjNYkZh0WBLbgtH2ADxNbUYJ4qfdXj965d5z8
         BMu9wef3Mum6xK+p3SCGrFRTmOKAfya3+kghFA/0vAT1W93TfkQC8F37x5pumkZ/z5l+
         aEpDSE3FKTUfvnZDnsc1Sz3cJ5npkE9xPTbqU//ya3q7PZi35dRqwOqZwI57ZBKFqTkd
         AfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=51ARn8Jpj675g3r68sX56Uf15g+0Xnk99my/nU5jT5s=;
        b=QmSiTRuXfWdnrmq1MhQTM5Kwz77fz75f0wFe/Z0+tMEd0GeTy5+dD0R7np1mn1Q+vH
         n212TtpcP7YL1p+TQyR1sDa9oO0YR+lpkp4wCms+uNCEL/mCqG0nBHRYyGGvB4NILPWF
         b8Whg6dzueYsVxrRLvFRrkRAJhbCUwBiAcwHGBVYJCueUxp6ktT9TB8jXLV+lGVjH0Wk
         Cbv9HyULEn8p/MOqZsPCIZSSHKCwAX7Twc4OMGhITc8zyPF4LwUmsebeBX0dYyPwrSAW
         TjjUcJJp0al1r0Brb3jx0dtXMv+5SvLdDBp7/dJArYa3bVqfAyW+eYqrAHAZcrLeAepU
         FNjA==
X-Gm-Message-State: AGRZ1gJyCoVsIsm3eSxpY+SQjqXg3iJrU4PwFxAIp4kNtxOH8tGH39U+
        1FFhposbHVtKa30jGYqjlrq+2U6heFm8GXYReaI=
X-Google-Smtp-Source: AJdET5cu77Q3DGRaNVYH0Aboq31C9SdTeLJgwyFIUDya0fXzSAlx4PbUYmfZSE2DVH8f60oFsxSiUb/aORINhETV57s=
X-Received: by 2002:a24:4687:: with SMTP id j129-v6mr2662821itb.6.1540523767092;
 Thu, 25 Oct 2018 20:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181025110427.13655-1-carenas@gmail.com> <20181025110427.13655-4-carenas@gmail.com>
 <b6fe7e58-5b3f-f139-be8d-210526a26767@ramsayjones.plus.com> <d5b54ed8-689b-6f12-5888-fb598db8f083@ramsayjones.plus.com>
In-Reply-To: <d5b54ed8-689b-6f12-5888-fb598db8f083@ramsayjones.plus.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 25 Oct 2018 20:15:56 -0700
Message-ID: <CAPUEspiFDX8280qezkQ0WvJ5-9cp2eG3p+zX4F6HZNgLBACoHw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] commit-slab: missing definitions and forward
 declarations (hdr-check)
To:     ramsay@ramsayjones.plus.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, peff@peff.net,
        chriscool@tuxfamily.org, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 2:09 PM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> Yes, this will 'fix' the 'commit-reach.h' header (not surprising),
> but I prefer my patch. ;-)

I apologize, I joined the list recently and so might had missed a
reroll; the merged series in pu doesn't seem to include it and the
error was around the code I changed, so wanted to make sure it would
be addressed sooner rather than later.

eitherway, I agree with you my patch (or something better) would fit
better in your topic branch than on mine and while I haven't seen your
patch I am sure is most likely better.

> Still puzzled.

this are the last lines of a `make hdr-check` in Fedora Rawhide, it
should behave the same regardless of OS or compiler used IMHO

    HDR commit-reach.h
commit-reach.h:45:28: warning: =E2=80=98struct object_id=E2=80=99 declared =
inside
parameter list will not be visible outside of this definition or
declaration
 int ref_newer(const struct object_id *new_oid, const struct object_id
*old_oid);
                            ^~~~~~~~~
In file included from commit-slab.h:5,
                 from commit-reach.h:4:
commit-reach.h: In function =E2=80=98contains_cache_at_peek=E2=80=99:
commit-slab-impl.h:47:14: error: dereferencing pointer to incomplete
type =E2=80=98const struct commit=E2=80=99
  nth_slab =3D c->index / s->slab_size;    \
              ^~
commit-slab-impl.h:7:2: note: in expansion of macro =E2=80=98implement_comm=
it_slab=E2=80=99
  implement_commit_slab(slabname, elemtype, static MAYBE_UNUSED)
  ^~~~~~~~~~~~~~~~~~~~~
commit-slab.h:49:2: note: in expansion of macro =E2=80=98implement_static_c=
ommit_slab=E2=80=99
  implement_static_commit_slab(slabname, elemtype)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
commit-reach.h:57:1: note: in expansion of macro =E2=80=98define_commit_sla=
b=E2=80=99
 define_commit_slab(contains_cache, enum contains_result);
 ^~~~~~~~~~~~~~~~~~
commit-reach.h: At top level:
commit-reach.h:69:41: warning: =E2=80=98struct object_array=E2=80=99 declar=
ed inside
parameter list will not be visible outside of this definition or
declaration
 int can_all_from_reach_with_flag(struct object_array *from,
                                         ^~~~~~~~~~~~
make: *** [Makefile:2685: commit-reach.hco] Error 1

Carlo
