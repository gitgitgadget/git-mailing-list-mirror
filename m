Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740751F45F
	for <e@80x24.org>; Mon,  6 May 2019 08:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfEFI1w (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 04:27:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38203 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfEFI1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 04:27:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id w11so14393242edl.5
        for <git@vger.kernel.org>; Mon, 06 May 2019 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pSb7TmgrMDtpgG759/OJdCAd+u9Nx1L244ij//y14b0=;
        b=Aqlth2bvvv8UVakv0GgYUjUr2mF3IMG27M0YQOC34tManywh3E244874ZABIqUEL11
         20foT2H8AVxoA0sVKUiwlz6VMH8+0L29GqiyMjyf2i8YCBEF+va3R7Z70M8jn4p0m3wz
         pL9aTJIfQYwn3bQhfA00olemdCfh+vknXkfkbjwAPZIF/RsN7q56VCPYPqtNaViqb9T+
         hRt7iJSij1pcVDcU0umNo7qb69mL6qClZynpWx3lVWxRbfuZIww5ygI4bgPU9bZV0Lrq
         3aEZK15QPhoON4kpjqgWYz5dhM4qe4/DVaW6YWp8UixhOhk/fTMn0yszeHMhhQ/bZIOC
         MOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pSb7TmgrMDtpgG759/OJdCAd+u9Nx1L244ij//y14b0=;
        b=bKD+pc9LrtTW5Tje6GZFsXg1njd6NphjRh8Z2iPiWf0f3TOZbFEBaNFZ71LcnrjZvJ
         av/+GQMSuMATBYKYfVou+mLdAZ21d28G2SlV3UonE/ftmxpHL2CjwDdW2cJFialvMEEU
         /nnmSVLYwIC9gOu38GFZYzkXJWltNkCVfaXMRbPpcIqrDg+2q0A8/+c1iNa3HESGYXTQ
         lYiZSjTmGszD57OhPdkSf9V+LUsYYaO80ShVQ91EJRBWOG7yw5/luLVyqNBWlsoR5h7r
         bedYI98bpcaPsF5X92zmcdYEh/GteGFr7wbqztw6p/GzNdMYsCdZo+UlwOOMA3R0fQ1i
         jLVQ==
X-Gm-Message-State: APjAAAVSZXmgm0TtJc9Tw9TUaqhRiFrRFjSRLDeEEuVW9dJpWq7WL/K2
        vaARizKtVawuweRauMjh1JneTRq5iZR7i+9dJqQ=
X-Google-Smtp-Source: APXvYqwy35BOKItma8GH5UFIpZ64LmwmTrQ3E5mUtmtoGlI9vG7ZkwARgilVYQt70WvEGKmxSobKWw4iTZ0jcfwNJXw=
X-Received: by 2002:a50:947c:: with SMTP id q57mr25023789eda.81.1557131270036;
 Mon, 06 May 2019 01:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.112.v2.git.gitgitgadget@gmail.com> <pull.112.v3.git.gitgitgadget@gmail.com>
 <87lfzprkfc.fsf@evledraar.gmail.com> <bb0c22f9-9d0b-0fa6-e826-8e2ac146c6f9@gmail.com>
 <87h8acivkh.fsf@evledraar.gmail.com> <04ac97c5-ab2b-2b23-4c84-8ed8aab0e2f5@gmail.com>
 <87bm0jirjj.fsf@evledraar.gmail.com>
In-Reply-To: <87bm0jirjj.fsf@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 6 May 2019 10:27:38 +0200
Message-ID: <CAP8UFD2tnkNfgjm=H__=YPG-+BuOHwHs9=OoXnL9wnj_eOtbQg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Create commit-graph file format v2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 3, 2019 at 3:44 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Fri, May 03 2019, Derrick Stolee wrote:
>
> > On 5/2/2019 2:02 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >>
> >> But those are separate from any back-compat concerns, which is what I
> >> think makes sense to focus on now.
> >
> > Thinking more on this topic, I think I have a way to satisfy _all_ of
> > your concerns by simplifying the plan for incremental commit-graph file=
s.

[...]

> Just on this, consider storing them in
> .git/objects/info/commit-graphs/commit-graph-<THIS-FILE'S-CHECKSUM-SHA1>,
> because:
>
> 1) We can stat() the "commit-graphs" directory to see if there's any
>    new/deleted ones (dir mtime changed), similar to what we do for the
>    untracked cache, and can (but I don't think we do...) do for packs/*
>    and objects/??/.
>
>    As opposed to ".git/objects/info" itself which e.g. has the "packs",
>    "alternates" etc. files (can still do it, but more false positives)

About incremental commit-graph files and alternates, I wonder if they
could work well together. The main use case would be for servers that
use a common repo for all the forks.
