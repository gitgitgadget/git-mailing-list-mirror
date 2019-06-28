Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2EE11F461
	for <e@80x24.org>; Fri, 28 Jun 2019 09:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfF1Jrr (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 05:47:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42009 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfF1Jrr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 05:47:47 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so2693136ior.9
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 02:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h974Ek1hqiMdHu0JFaHY2x0UCVfDbJHpevZi80897pI=;
        b=k/NT141SClUm5qUYMDPu1zC2jZEo/yQd8jzMQUGchLlxtQ4tz9JsLGOioF95zRUije
         seYM1Pe+WmOKmZvYds6emmDWyt3OwkVB2mjby0hNWXXpsoKh+AtH1R94WImy3AbtKW00
         8r1ib/eo2NxoZkLQYxFKMTfgLDCkGBB52S0SjYJKGp3tWUWzQuf6lQ/InffZAxeYjuPw
         MUGCeIxP36rOAA4vCYtb55slHlC73xsROqF2DQnMt35V29dJ1fceEvkd9/Y6RbhF1FeM
         19+4Pv6TIJjbviNBW8EFQLyafANM1QvZvGjLs5/L62iW4dhX0MKjmIKytAiLioi+1GUf
         tFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h974Ek1hqiMdHu0JFaHY2x0UCVfDbJHpevZi80897pI=;
        b=OXrDw4m3Z9jRk3TGWOgQVe/6IoveHJW76Vrv/zScSfQaSTJxd4pna91v/8/aWXN2lq
         rUb9jMZCocX8dDMnVzu2hrIRPLO4kN8iIMxIb7BTL3/2WudBtIdpQenKXh/Ipor12CEB
         dyvsC3UXZdZZw7wjRcaFyJAefZyFIAZsBBWASAhRtB0EMhe91JyPYJ8kVUrKOf120Xv2
         J64bR/HRTb1Q3myThv5Fksyxvd03JjxkMGxugkTyZPbqPI22e+uewA/LHPcEBT5FBquM
         KB+1j+5yBSOVoyh5IFxIetA77bPBNNNsY+zJJG8R0vwTnkiQyvcKQQbhxrVG0rNJ2KNr
         4Yrg==
X-Gm-Message-State: APjAAAUVc/dhviKInp3gmCsqKWBSsJxkRZuReqSzFTgXYbjYS1Y0WIwn
        eTN0+0zOHUetlNvIquQpn4avoTA/FVGvNau1ODIyeobO
X-Google-Smtp-Source: APXvYqwI2mMcoeWvRK+t7crszrFYcaYPq38mjoe3G+7TVZiTOaHU9aLO8jae1ndN8E/dDnT9C8h+4428A2xIAvOykwk=
X-Received: by 2002:a6b:f711:: with SMTP id k17mr78046iog.273.1561715266315;
 Fri, 28 Jun 2019 02:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com> <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
In-Reply-To: <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 28 Jun 2019 16:47:20 +0700
Message-ID: <CACsJy8C7Qr3JauRqUkB957ZDzVVZ0+wofzs7N2NzCbu+e00JnQ@mail.gmail.com>
Subject: Re: Git Test Coverage Report (Thurs. June 27)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 12:35 AM Derrick Stolee <stolee@gmail.com> wrote:
> > dir.c
> > 3b2385cf 2840) static void jw_object_untracked_cache_dir(struct json_writer *jw,
> > 3b2385cf 2845) jw_object_bool(jw, "valid", ucd->valid);
> > 3b2385cf 2846) jw_object_bool(jw, "check-only", ucd->check_only);
> > 3b2385cf 2847) jw_object_stat_data(jw, "stat", &ucd->stat_data);
> > 3b2385cf 2848) jw_object_string(jw, "exclude-oid", oid_to_hex(&ucd->exclude_oid));
> > 3b2385cf 2849) jw_object_inline_begin_array(jw, "untracked");
> > 3b2385cf 2850) for (i = 0; i < ucd->untracked_nr; i++)
> > 3b2385cf 2851) jw_array_string(jw, ucd->untracked[i]);
> > 3b2385cf 2852) jw_end(jw);
> > 3b2385cf 2854) jw_object_inline_begin_object(jw, "dirs");
> > 3b2385cf 2855) for (i = 0; i < ucd->dirs_nr; i++) {
> > 3b2385cf 2856) jw_object_inline_begin_object(jw, ucd->dirs[i]->name);
> > 3b2385cf 2857) jw_object_untracked_cache_dir(jw, ucd->dirs[i]);
> > 3b2385cf 2858) jw_end(jw);
> > 3b2385cf 2860) jw_end(jw);
> > 3b2385cf 2861) }
> > 3b2385cf 2958) jw_object_inline_begin_object(jw, "root");
> > 3b2385cf 2959) jw_object_untracked_cache_dir(jw, uc->root);
> > 3b2385cf 2960) jw_end(jw);
>
> Duy: I know you were working on some tests for these options. This is specifically
> in the "untracked cache" mode, so enabling the cache with at least one entry and
> running --debug-json should be sufficient.

It's a bit more complicated than that, but I see your point. I
initially looked at the output and saw "something" and moved on. I
should have examined the json output more carefully.

> > read-cache.c
> > 8eeabe15 1752) ret = error(_("index uses %.4s extension, which we do not understand"),
> > ee70c128 1754) if (advice_unknown_index_extension) {
> > ee70c128 1755) warning(_("ignoring optional %.4s index extension"), ext);
> > ee70c128 1756) advise(_("This is likely due to the file having been written by a newer\n"
> > 272b3f2a 2026) jw_object_true(jw, "assume_unchanged");
> > 272b3f2a 2030) jw_object_true(jw, "skip_worktree");
> > 272b3f2a 2032) jw_object_intmax(jw, "stage", ce_stage(ce));
> > f0f544da 2309) ieot = read_ieot_extension(istate, mmap, mmap_size, extension_offset);
> > f0f544da 3651) static struct index_entry_offset_table *read_ieot_extension(
> > f0f544da 3673) return do_read_ieot_extension(istate, index, extsize);
>
> Duy: more JSON output cases that could be interesting to cover.

This is because I changed the function signature, I think. Both IEOT
and EOIE extensions, if I'm not mistaken, are never tested in the test
suite. You need to set GIT_TEST_INDEX_THREADS, then the last three
lines should be covered.
-- 
Duy
