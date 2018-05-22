Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120631F42D
	for <e@80x24.org>; Tue, 22 May 2018 11:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeEVLLV (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 07:11:21 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35126 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeEVLLV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 07:11:21 -0400
Received: by mail-pl0-f68.google.com with SMTP id i5-v6so10709771plt.2
        for <git@vger.kernel.org>; Tue, 22 May 2018 04:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cE6anr+hf7f9oNlqCBwMMFXQo6cJWnbZFFRpxem3hKU=;
        b=nLtbQql7RWxKBmPmq+oMC5dvyHeuWNf3iPCpN2HyDMDXF03/dfZ5Xdly0HeUHE6+vS
         X0mIj6LJ4Jvwg4mLAN6dXePwJzAs044fWcx0gzPSXIFBQwMKEwsQfRFYLeomU4ylKLg0
         9k1bMLXB14WmDKiPO21S0Fcnpa7hDtXwQCiN9ESZrvvBiMrVkdbG3Pd714Gbdrr7d20D
         Ra+vzJ0ezzWibMV1AZI2+882OesIrAAA6mISzHXlZosyI6d6bplzn+81aQUKozgAnsFu
         i2fN9M1TFdX0+c+a7CBVt+xrCSSB+uOsO+eXLeCwcQddSlIBjA9zBkc0P6efgRRBWSta
         cMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cE6anr+hf7f9oNlqCBwMMFXQo6cJWnbZFFRpxem3hKU=;
        b=po+Vrwr9orFBrDUUQsaNsegwWC/l+od+sP30ZLmzekj2tmLkyptLlh3oJ2plw3DQFh
         24prjMS6pTaKSRiJ6DvXhEo2s50z1DRd43vtOTDUobXsGzdarAHtPWyXKnVPtV4qgGa5
         JW4PGCsrn4G8WD5ogGYP/msqIMF53bfcW+0nd0gf6nZ7ydgLMzkP4Btxhiw2E4wzqZlU
         wDTG4htgmUgYSTUu8+hHBuAKTDIZ+oJ2iUJaaCFtc7UInDMhhRZ1iVKe4iefLFRbWCpY
         0zHoOwPmc5e5aoYQ3oeWLYLVe7JErQlUpayqntS2LLD2U1Drtt1FO8DfNVPD380SAHCi
         60ag==
X-Gm-Message-State: ALKqPwdl1fKO6qb1dknR7ttauhe7e9LMscLgo3L7Od9/O3CtyClcSiRK
        FPcp9EU3fEzmw2Mkl+xUS1LPTT67ME1Ihs8fAe0=
X-Google-Smtp-Source: AB8JxZrqKgNhKpS5u4cWcdbxXQA++WD+j+cw6/ckHHe8MxlhlYQyMa12ezv9ksOXYmTJRa5/zy7GfK8JRMUHobmGOWI=
X-Received: by 2002:a17:902:284b:: with SMTP id e69-v6mr23590484plb.240.1526987480761;
 Tue, 22 May 2018 04:11:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:bb8b:0:0:0:0 with HTTP; Tue, 22 May 2018 04:11:20
 -0700 (PDT)
In-Reply-To: <xmqq1se4z9fu.fsf@gitster-ct.c.googlers.com>
References: <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com> <cover.1526913784.git.martin.agren@gmail.com>
 <xmqqa7ssz9u1.fsf@gitster-ct.c.googlers.com> <xmqq1se4z9fu.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 22 May 2018 13:11:20 +0200
Message-ID: <CAN0heSr0uZvaRqjNmD5=8RLpcLiWHjG2OoZovYK7TkGkCKu=7g@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] unpack_trees_options: free messages when done
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 May 2018 at 04:54, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> Hmph, this unfortunately depends on 'next', which means we cannot
>> merge it down to 'maint' later to fix these leaks.  I guess it is
>> not a huge deal, though.  We've lived with these message leaks for
>> quite some time now and earth still kept rotating ;-)
>
> Oh, what was I thinking.  This, just like its previous rounds, is on
> top of bp/merge-rename-config^0 and it is expected *not* to be
> mergeable to 'maint' (or 'master', for that matter, at least not
> yet).

Right. The reason it depends on that topic is the user in
merge-recursive.c. Other than patch 2 and a small part of patch 4, this
should be mergeable to 'master' (as I recall) and probably also to
'maint'. I suppose this series could have been done as three patches to
fix all users except one, then one or two patches to fix
merge-recursive.c.

That would have allowed merging the first part of the series to 'maint'.
(Maybe not to fix the leaking as such, but to keep 'maint' more up to
date with 'master' for easier merging of other topics?) If you'd prefer
an ordering like that (now and/or in the future), just let me know.

Martin
