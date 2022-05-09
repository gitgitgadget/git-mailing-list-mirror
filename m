Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B23C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 15:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbiEIPQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbiEIPQs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 11:16:48 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C8F1FE1EF
        for <git@vger.kernel.org>; Mon,  9 May 2022 08:12:51 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id j12so10550660oie.1
        for <git@vger.kernel.org>; Mon, 09 May 2022 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P4ymQejNQ2JXsU4XxotNNHm7rJ+RQBn6dZcK+i2WW9A=;
        b=JNtBbnIdkHkJHDFb6aSzdB4sO7EcJwNWM2YZxBDQwq56lqNNkwuED1IQ2NUOL4UnPm
         8FQjR2ZDWnrSmRM5n80k6zygUVowVpCh1+wL5erWxXAteIZ6cuWgqipEqBk8mnsSx4/s
         tgPVxGjy0hveUk2KGQxxMBu3vc+tdX+jkdGxC4yA3DrzRiQzk37LlUG3yrju/VT5VtQv
         c+X7i13j2eedeNrcT8c56g/w734cL2pGZZ21UO8fS+C3y2DQaOcuRtn08H0ITXEX4Y9S
         l1OeOqRlSuP14Gylue/AttVCsRTc6B8Tj0B0cJ5y9LMRNxyARgqBqABlhH6brSu/44oB
         pwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P4ymQejNQ2JXsU4XxotNNHm7rJ+RQBn6dZcK+i2WW9A=;
        b=KQjTjYrSU3xklW4bqs48+kb9fGb8OXO4QgJCtG3koBkOomZ7+xc6HAH7i1W9SoZr7L
         44RhdM1+N2UQocU+hPU7zb1x6XIC08CSxWM/qJFQh76XiL/gpY4SR2f91GjzgujbLhQ2
         qid6COwj8TmVdHEuKB8cxp4ZC1VE06Jx0K/UdmtdUlSbV6YUQk9Kib++fE+qCEwBa6hG
         2vXtYu/7jTHK4byokMELfcP8TtZ6lhyFJM+wkm37A2eL7fwzA5bw66ZEhK7fMCsn/gbw
         t9dia6TK1E/Ll46sy206HWII8G5fiK04Q27xP4ssOpAfXxTmd4gvrP9i6bIA1iYhArU/
         5rAA==
X-Gm-Message-State: AOAM532vLidjdfPhg2ha954mzy9P991nlVhclufsjJ7/DrKtcimHFc5y
        1Q3p0Ar6AXqM4XFMMi4RVDt5h70rDXmM9VyhGKl3QLSeMth0dg==
X-Google-Smtp-Source: ABdhPJw6fJYikTDKwaRS/y/dLYbeUZAYZuOdeO2s3Zx1a+zN7ONylmJ1mBKMLEtxg53RojCXB9bKj5eE8oJFcE+Uqgg=
X-Received: by 2002:a05:6808:bc8:b0:326:bc22:c530 with SMTP id
 o8-20020a0568080bc800b00326bc22c530mr3562291oik.114.1652109170902; Mon, 09
 May 2022 08:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com> <965b5394-9f72-e4a3-9ed4-6abcf67fb524@gmail.com>
In-Reply-To: <965b5394-9f72-e4a3-9ed4-6abcf67fb524@gmail.com>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Mon, 9 May 2022 20:42:38 +0530
Message-ID: <CAC316V7dRjsLiVJLvB-PXRDVZ0NB0xin9XEWq9QBiARthNuGaw@mail.gmail.com>
Subject: Re: [GSoC] Contributor candidate introduction
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Plato Kiorpelidis <kioplato@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic,

At my job, my timings are flexible. I already discussed about GSoC
with my team and Microsoft is supportive for open source
contributions. I have done side projects and open source contributions
in past also, so this shouldn't be a problem. I also planned to spend
weekends on this (I usually spend weekends on my desk, so this is fine
for me).

I do not have any other commitments or planned vacations throughout
the GSoC timeline. I would be able to dedicate 35-40 hours per week :)

Thanks,
Shubham



On Mon, May 9, 2022 at 12:14 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hello all,
>
> We were reviewing the proposals and noticed some missing information.
> Hence we wanted to gather the information now.
>
> Shubham,
> You have mentioned that you'll be able to dedicate 35-40 hours per week.
> We just confirm if that's feasible despite you having the commitment of
> a full-time job.
>
> Also, do let us know if you would have any other commitments during the
> GSoC period that you're already aware of.
>
> Plato,
> Do le=E1=B9=AD us know if you would have any other commitments during the=
 GSoC
> period that you're already aware of.
>
> Apologies for reaching out late. Since the project selection deadline is
> approaching soon, do respond as soon as it is feasible for you.
>
>
> --
> Sivaraam
