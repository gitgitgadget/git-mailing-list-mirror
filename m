Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AA2A20248
	for <e@80x24.org>; Wed, 17 Apr 2019 08:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfDQIIN (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 04:08:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50431 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfDQIIK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 04:08:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so2238294wmi.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 01:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aQYbrDnuaKb4edQMwX3GdaP63dPR4kG1vINoTfBXWo=;
        b=fY/1jUILkWZIifoOhCmBgY1OJufW76BZd0m8ucXqjCrIVvDUGTGzjqUVZ4zxlZc77k
         +vT0/06hFe8QeFbJGwDbjjrGpIC9PVEaADYiofGLLmriRvfjt8RSmEZF/b3CUwL+Rtrv
         Hgwh6KuPVfyei6mozNHEPLEEKcH/sIiwEltYXAOx1JSFezhck/pCUaSoyn/pin8oCUNB
         RvQ80thYhLE7eulrniDhweD5SR8lCHOfkp02vJsQSMdmHNMuckWEXdWYjPnGR1zo4BES
         ddyn29dqV+zojwU8NjZUe36iUtD8j4tOhJL1HjlT5Nh+7vRXYvLrWjM9JeW2CS4oCawC
         zOjA==
X-Gm-Message-State: APjAAAWQh9D0OpuqpXgBU7knFO8yxod8TZBSXBJN+2RLUmLxt1umVKqR
        C2xaqNpmI6IZXx+4hnv/cJNW/ikSjh2bwgBS7zc=
X-Google-Smtp-Source: APXvYqwRUky4+HgyUHvzUb0nrpqbIvyiXItXQBm03MLuR1qhx07sN+zCdfgjwrgqsBPPtN00tgTWjCG35iqwiZSe90s=
X-Received: by 2002:a7b:c446:: with SMTP id l6mr1788665wmi.80.1555488489299;
 Wed, 17 Apr 2019 01:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.177.git.gitgitgadget@gmail.com> <pull.177.v2.git.gitgitgadget@gmail.com>
 <71d5ab539c8b47155f6a3c92e26c9224d8214298.1555446372.git.gitgitgadget@gmail.com>
 <xmqqbm15kxi0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm15kxi0.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 17 Apr 2019 04:07:58 -0400
Message-ID: <CAPig+cS+cx+2dn+-a9nigrVJdWBba3MrthivA-QSo9d3T2nLnQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] documentation: add lab for first contribution
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 17, 2019 at 1:32 AM Junio C Hamano <gitster@pobox.com> wrote:
> "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > +Now that you've written your manpage, you'll need to build it explicitly. We
> > +convert your AsciiDoc to troff which is man-readable like so:
> > +
> > +make all doc
> > +man Documentation/git-psuh.1
>
> Hmph.  I didn't know you can do that without "-l" (local) option.
> Perhaps with "-l" spelled out, it might be more portable but I
> dunno.

It's more portable[1] to eschew the -l (local) option to 'man'.

[1]: http://public-inbox.org/git/20180831063318.33373-2-sunshine@sunshineco.com/
