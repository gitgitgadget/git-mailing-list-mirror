Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5D5208CD
	for <e@80x24.org>; Wed,  6 Sep 2017 11:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbdIFLT5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 07:19:57 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33655 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753684AbdIFLTy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 07:19:54 -0400
Received: by mail-oi0-f67.google.com with SMTP id k191so4494565oih.0
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 04:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0rTel2UXvCsViiViO51bjqO+Fh/Hyv1NWeG4KYNHWPg=;
        b=ASxiNnU00KXwknl5TOnLxzsYT3kfH9qZEWmwSHGPIFOo+8h3gX6cheI/MfdnaZWOKB
         86b1lxTCS5X0LozjGaVU3LIIhMW/gubwvFKmRme3n2bPR/MEcJX68C2roLqo1MfVTc6d
         N7BfBvpporDFMXWfe1gEGn5KQdf8gTs+PZeQrepeHsJrzGK66/tEzQt9XTCiAksBhI3X
         M8Xj5znDOOlNPfsMybTOGvI/+lNxkIcY+RK4qIN3y6Q233zFn7D5AidCk6eqFgMIktV+
         8gAs0eH9o4i8FauT4W+87qb2BkaH15TfGX0orEueZmNsvD4wV8FvCxUgz3Gc85+NxYpm
         5q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0rTel2UXvCsViiViO51bjqO+Fh/Hyv1NWeG4KYNHWPg=;
        b=ll0FBbggLWFdex926aGAMGCyXJZW6Apo+qkULHuVVmgVYHWkSRJKCBAsmAPPH4bCPp
         A7G+ng544KpFXKWLCpvGrOl60MlCaEyXKuWxenQhRUmLQOxSBDOrqVRt3/tCbTlGJ7c1
         IEQpS/8i0J4Fax7mzUACTJwacMCdoJqWiG5UDCWSyzxlzYrUiR4WTuKNNOkEeRslB5RX
         EMnMRl1eg872cBWBPJtriYYiyCpvNzux2Ab3G/TZu7qvquU1XCobEz4nLQOSVaWUcskw
         ByXkxk6T2twDJIDwg3dfFmXIefx408PDHpQwMquKYRkysjd0cf3R1aWTp8GyYNCSd/9H
         1gJQ==
X-Gm-Message-State: AHPjjUie1G+IWb3Gcft6kDyCkygC7coHCyh7r5d8vH89CQazrl+GeVcT
        VMee3fNlvMUWUWF/226HnL0i8jA/9g==
X-Google-Smtp-Source: ADKCNb6oMZUFeSqB7XXW/XMWXpfUJ8GR9UsUfEPkZqCZIQqDZNeAEluu8RNZA01Pc0zua5yKYgfxgqi79PDha2nhNKA=
X-Received: by 10.202.81.194 with SMTP id f185mr2233764oib.31.1504696793647;
 Wed, 06 Sep 2017 04:19:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.176.69 with HTTP; Wed, 6 Sep 2017 04:19:23 -0700 (PDT)
In-Reply-To: <CAGZ79kY8cW+6+60bgSAhS69nBWZbn1LA7gT3t4Ddii+MB2V_cA@mail.gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com> <20170823123704.16518-12-pclouds@gmail.com>
 <CAGZ79kY8cW+6+60bgSAhS69nBWZbn1LA7gT3t4Ddii+MB2V_cA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Sep 2017 18:19:23 +0700
Message-ID: <CACsJy8BiRM5HE5vkt6pa+dsNmoPjEbRM+UTA3323kPe9rwu9VQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/16] revision.c: --all adds HEAD from all worktrees
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 2:54 AM, Stefan Beller <sbeller@google.com> wrote:
>> +int other_head_refs(each_ref_fn fn, void *cb_data)
>> +{
>> +       struct worktree **worktrees, **p;
>> +       int ret = 0;
>> +
>> +       worktrees = get_worktrees(0);
>> +       for (p = worktrees; *p; p++) {
>> +               struct worktree *wt = *p;
>> +               struct ref_store *refs;
>> +
>> +               if (wt->is_current)
>> +                       continue;
>
> As said in an earlier patch (and now this pattern
> coming up twice in this patch series alone), the lines
> of this function up to here, could become
> part of a worktree iterator function?

There are a couple "loop through all worktrees" code so far, but the
filter condition is not always this.

While I like the idea of iterator function (especially if it does
"struct worktree" memory management internally), I think it's a bit
overkill to go for_each_worktree() with a callback function when the
equivalent for(;;) is so short. We would need to declare struct to
pass callback data, and the reader may have to got read
for_each_worktree() code then come back here.

So, probably no worktree iterator (yet).

>> +               refs = get_worktree_ref_store(wt);
>> +               ret = refs_head_ref(refs, fn, cb_data);
>> +               if (ret)
>> +                       break;
>
> with these 4 lines in the callback function.
>
>> +/*
>> + * Similar to head_ref() for all HEADs _except_ one from the current
>> + * worktree, which is covered by head_ref().
>> + */
>> +int other_head_refs(each_ref_fn fn, void *cb_data);
>
> This is already such an iterator function, just at another
> abstraction level.

yeah.. but we can't mix and match (or combine) ref/worktree iterator callbacks

-- 
Duy
