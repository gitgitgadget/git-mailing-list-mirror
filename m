Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC3BC1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 18:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934526AbeGCSbC (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 14:31:02 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:38020 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934463AbeGCSbB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 14:31:01 -0400
Received: by mail-ua0-f169.google.com with SMTP id 59-v6so1868591uas.5
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gPo5CcwarFAqRajknC4QvvZUuh5Fau7YEfrSTlhmhwA=;
        b=uq0T7izzUeuaYz+brM29nDKonWCWCrZD1JLrRUnbqxPcYaXUlitOZGAv5dSY606dXF
         9PfmfpLbRpTqOiMgZ7Xa1o5+4+jHPCGbyb1P5O+bfGmrFLtwnfo65UouU4hAlEx9KIXj
         hK7oi8RqgWohsA7wrgtOw8Q9iTAAzSC37nQuonX9rrAxJOvjGcpnKqlC4h6+/xqwtfFd
         pcPx0ViKBZTNwq1XcOtlcHoDKeGH3VBOUUPou3V3VJAAdk6as4UFSD6Vgvdmbp13hisd
         vs+kOyHIWlXKWWzM2N6IaIkjfDYyIEyOmZ/KExy1T/hNDL5bxtYR6sgZiseXJnjbfQkt
         Dw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gPo5CcwarFAqRajknC4QvvZUuh5Fau7YEfrSTlhmhwA=;
        b=D+D1J1We211DOB40OviL71HxRpzz7aM4lkbvlRFdX8NVWxF80kbGEixyApPg37ZVce
         bt8Xy6ToEA5jH+EpIe2g77SgLufKtaDz5Vp9++wAhFG3iq+7RFklho+iEPzU8q+Yok7Z
         6pS6y9+c7AgiwyHs9zMPKo/ShBPpzVuDJy144r+I9zhSzkDf6GUJ79YtUf2Y5LZvPqt0
         xtj9rnfaThlbE0wDWAfURotUPYiCh1siksOL6wSGM7CyogiEn2rquF5nfiQbOk//yO9H
         PFIaRIqBeyvFa9aHR9ZM209FXzHhsQ9RBzd5LwfGbg6nF3w9enD/r5nJ96pzjYOtjQhX
         ROew==
X-Gm-Message-State: APt69E349enI6dNIjjvZoLr0c4A5jYzzCH6TG3ct6UTGRWDvxhsDXegJ
        P2hpBXu/40c4RSNWAlvNpWrrVtE8qsVON17dou8=
X-Google-Smtp-Source: AAOMgpdVJUXLICVwAGWFCRcoH/PWW9iYR3+/TYRZs8IO4bt9edowxxF3zhj3sqf8JaZA0rbT7IByncXGqySxaJxVnH0=
X-Received: by 2002:ab0:12e2:: with SMTP id o34-v6mr11230228uac.154.1530642660127;
 Tue, 03 Jul 2018 11:31:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 11:30:59 -0700 (PDT)
In-Reply-To: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Jul 2018 11:30:59 -0700
Message-ID: <CABPp-BE=2nzEG=X0Jv3++J3Yo3H0yfJ9vd4pDYYBw5fpzDYc_g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2018, #07; Thu, 28)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

On Thu, Jun 28, 2018 at 2:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * ds/multi-pack-index (2018-06-25) 24 commits
>  - midx: clear midx on repack
>  - packfile: skip loading index if in multi-pack-index
>  - midx: prevent duplicate packfile loads
>  - midx: use midx in approximate_object_count
>  - midx: use existing midx when writing new one
>  - midx: use midx in abbreviation calculations
>  - midx: read objects from multi-pack-index
>  - midx: prepare midxed_git struct
>  - config: create core.multiPackIndex setting
>  - midx: write object offsets
>  - midx: write object id fanout chunk
>  - midx: write object ids in a chunk
>  - midx: sort and deduplicate objects from packfiles
>  - midx: read pack names into array
>  - multi-pack-index: write pack names in chunk
>  - multi-pack-index: read packfile list
>  - packfile: generalize pack directory list
>  - multi-pack-index: expand test data
>  - multi-pack-index: load into memory
>  - midx: write header information to lockfile
>  - multi-pack-index: add 'write' verb
>  - multi-pack-index: add builtin
>  - multi-pack-index: add format details
>  - multi-pack-index: add design document
>
>  When there are too many packfiles in a repository (which is not
>  recommended), looking up an object in these would require
>  consulting many pack .idx files; a new mechanism to have a single
>  file that consolidates all of these .idx files is introduced.

pu fails to build for me (with the standard 'make DEVELOPER=3D1 ...'),
and it appears to come from this series:

midx.c:567:15: error: =E2=80=98write_midx_pack_lookup=E2=80=99 defined but =
not used
[-Werror=3Dunused-function]
 static size_t write_midx_pack_lookup(struct hashfile *f,

It looks like the use of this function was removed in v2 of your
series, but the function itself was left behind?  Could you take a
look?

Thanks,
Elijah
