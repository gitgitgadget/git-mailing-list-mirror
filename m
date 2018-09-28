Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E76D1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 21:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbeI2EZB (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 00:25:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39195 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeI2EZB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 00:25:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so1505139pgv.6
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j5ErxYVoqW5YGvfgrBPXl5i+QWaJzc1fQ8Xedw8Yqs0=;
        b=ImtY1MXgs1gnzfHEmtq69IP9DSgd46u24kMrZaEEagc4/rL/gYYPZLOtxQlAhGP4yi
         RU6e1UKz6qW1D+VF9TnqBr8mzO6Ps2wLafmKKf6VSNkP0ZTGqkmVgW/+SjhTjXePrVeb
         brt2mkH2+JjbpIn8p9Ezw2o3xXvy+XLD1X0JPFhe80ppZm7rlLC1H/OIvYrTO+tLV/Ow
         U2X846fm4Vjs6EaZp3vh6hrs2BlJbanB3S+EzaPIQXBammyqgv8L1k55h8XEUEjivJot
         6/RQu1JrHg3iEE50d9s+1DwpNduhEhXKedw0BiOSeSZGyaAW0ET5bqqPhWSsLVljklR3
         0FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j5ErxYVoqW5YGvfgrBPXl5i+QWaJzc1fQ8Xedw8Yqs0=;
        b=FYXnPTjM2p5wzQJPhzMEDT8rXvXFjJ0IPnmL3FwA+jv9vOPhAm7y/3kMfsU+kDqFUO
         NHu6fN0sGJjzVrQWzyANqEnF9lHlCYe1YXfrI4thWHHru1TDyh87HOqsRVJiGqLNZlW8
         yPT3tg2KREygPBTMdXommDQ8vrJwB6tjgLL6Omp8v+w2mn0zEblvgwRC4ddQ/oe/TyhO
         D1HieWWwzguPF7u1YLr9OrK9e+xJjaxa9pX3mX7+D4hp/R8lAcw50RuLLsId8jQu6Waq
         +MLsaEj5WHdS22cWi54yk/VnMrqF0H+08Ypx3P0PBUD8aKv4XdfIDcmxqmsrd0DI55Zc
         4WPA==
X-Gm-Message-State: ABuFfohaM8QHRpXKqKv5HihCvjml4LFCVOUJNOiSs5r9JfKwAeU9rsHo
        u8zUT8EDt+uIlBBkWd2or26MEKiP
X-Google-Smtp-Source: ACcGV63UvfnxHsON0gD2FFh8qDXW7Hw+L7pYdiXRE0CV6/N84/9+szIlLJLKs0arvsEUr8LYgz6FAg==
X-Received: by 2002:a17:902:d704:: with SMTP id w4-v6mr512959ply.230.1538171957339;
        Fri, 28 Sep 2018 14:59:17 -0700 (PDT)
Received: from smckelvie-mbp2tb.corp.xevo.com (hq.xevo.com. [4.14.243.50])
        by smtp.gmail.com with ESMTPSA id l6-v6sm8601940pfl.169.2018.09.28.14.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 14:59:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] submodule: Alllow staged changes for
 get_superproject_working_tree
From:   Sam McKelvie <sammck@gmail.com>
In-Reply-To: <xmqqftxtcxjb.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 28 Sep 2018 14:59:15 -0700
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A26D56C-59E6-4F69-B0CA-4849EBE7EBC9@gmail.com>
References: <20180927181054.25802-1-sammck@gmail.com>
 <xmqqbm8ifvka.fsf@gitster-ct.c.googlers.com>
 <D09E2583-BD1D-4C56-9C19-6B1E97CEEDAA@gmail.com>
 <xmqqmus2e6rp.fsf@gitster-ct.c.googlers.com>
 <37DC7525-209F-49CC-90AA-D55463456D20@gmail.com>
 <xmqqftxtcxjb.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Sep 28, 2018, at 11:00 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>=20
> Sam McKelvie <sammck@gmail.com> writes:
>=20
>>> Ah, that, too.  I meant to correct triple ell, though ;-)
>>> ...
>>=20
>> I wholeheartedly approve of that plan and your tweaking commit below. =
Thank you, Junio.
>=20
> Thanks for a fix.  But now I re-read the title and think about it,
> this is mistitled.  The word 'stage' in "ls-files --stage" is not
> about 'stage' people use when they talk about "staged changes" at
> all.  The latter is what "diff --cached" is about---what's different
> between HEAD and the index.  The 'stage' "ls-files --stage" talks
> about is "which parent the cache entry came from, among common
> ancestor, us, or the other branch being merged".
>=20
> Also we are not really "allowing" with this change; "allowing" makes
> it sound as if we were earlier "forbidding" with a good reason and
> the change is lifting the limitation.
>=20
> We used to incorrectly die when superproject is resolving a conflict
> for the submodule we are currently in, and that is what the patch
> fixed.
>=20
> submodule: parse output of conflicted ls-files in superproject =
correctly
>=20
> is the shortest I could come up with, while touching all the points
> that need to be touched and still being technically not-incorrect.
>=20
> Or perhaps
>=20
> rev-parse: --show-superproject-working-tree should work during a merge
>=20
> may be more to the point.  It does not hint the root cause of the
> bug like the other one, but is more direct how the breakage would
> have been observed by the end users.
>=20
Haha, that is closer to my original title that Stefan wanted to change:

submodule.c: Make get_superproject_working_tree() work when superproject =
has unmerged changes of the submodule reference

Though I could see why mine was too long.

I=E2=80=99m really happy with both your suggestions. If you still think =
you can squash it with your own tweaks, great. Let me know
If you=E2=80=99d prefer another patch.

