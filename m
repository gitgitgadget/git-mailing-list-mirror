Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192FAC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 15:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKBPpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKBPpq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 11:45:46 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7367729346
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 08:45:05 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-369426664f9so169561037b3.12
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 08:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwrqINt+o3VBNJ0MXhIVUnE2Lm24zgUZdqAgbUTnD3I=;
        b=trE8eyijZavBFdrvKzRSNhaurEelmE8wfFja+FiA6GvzNSuhXgUO1Tcd2gUaktTS5q
         QjdsyaTu/oSFRA3QyOEEtnFE4cTbLsOo1ihLNEHOmHirIotD3AQ1/s+TbW4XHdx3mT9R
         YlXVxiGgZib99Sbp8dMvVThOw9lGS/EA7gO4b8xR82jD2SL/VJ/hPLfzk6ZNxCTNrsQU
         fMZMLEpagkn7e3LUdeyrDtYm8usx9haE/2flLKMyPWVzxiTj9Oa2T6K/GD2YaGlPeXKO
         H+bJ5lCcA/i5iL9KqPtO61tRszAuZDCFg8XRiggOhRoyQtDmOWPQfClQfNgvuT+Th035
         GuvA==
X-Gm-Message-State: ACrzQf3W9brKp1OfmbefBG34j4lZawjgMfloHwpzs9dHApvDxwI0tfDx
        70chBzYNNQtiF4f5ScDLDTehrmhpH1m1vqccLnz0GXOkNMQ=
X-Google-Smtp-Source: AMsMyM5Jy7BaSS0N18hu+Et3WGVdE3OxLMT/mSYviQktJILBrczamqEWgJ1PtxdG1O0OzS5g+RH4LkvTbB5uFv2pebM=
X-Received: by 2002:a81:4fcf:0:b0:36f:cd8d:fefd with SMTP id
 d198-20020a814fcf000000b0036fcd8dfefdmr23523097ywb.199.1667403904497; Wed, 02
 Nov 2022 08:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1396.git.1666845947898.gitgitgadget@gmail.com>
 <pull.1396.v2.git.1667385022103.gitgitgadget@gmail.com> <CAPig+cQ2Tqt8rzvXsRjCsPFTkbq7B06gq2pourKXi5dKNx8oAA@mail.gmail.com>
In-Reply-To: <CAPig+cQ2Tqt8rzvXsRjCsPFTkbq7B06gq2pourKXi5dKNx8oAA@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 2 Nov 2022 08:44:53 -0700
Message-ID: <CAPc5daXmnkGpScihLpTPDXEFOAQF0vm-aWOpeym90X=tktLC2w@mail.gmail.com>
Subject: Re: [PATCH v2] Mention that password could be a personal access token.
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 2, 2022 at 3:55 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> How about a different approach, calling it a "secret" first, and then
> defining "secret" as different names for "password".

Or more directly, say "password" and parenthetically add that some hosting
sites may call it with different names like "personal tokens"?
