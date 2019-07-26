Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15FB1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 21:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfGZVd6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 17:33:58 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:44050 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfGZVd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 17:33:57 -0400
Received: by mail-yw1-f44.google.com with SMTP id l79so20787293ywe.11
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JeJYhCJZDUtbhUrXkNGlVvRaow+U+ntBk0hB+rx5WKc=;
        b=A8tOqbpqw39MpRGYSTft/EWocx9QOKdPIYhhD9cZSC0l/fytp/JRB5tmPjrpwfIubA
         x9oJp0ZQdJOTzcM3HIArdFpLRJrot3rgUPPpbS3YexBzbhE13lRlAkhsI7YiT8lVNFXo
         THJaFSZAMLMT60uQN+LA0Kqjfr2/7+GUk5bXBo6m1TArZTydjafgIUkSflp/pUev8h+G
         Ppx1EmBUulL2SboVDjOlQL8Ksw9oA/UCEUpDyAMNAA3VYPuQGmfeiyW69mVkm0If+vo0
         r2NXnm/lgRx2ZwLRRG3DmIQ8izuXP/Wp+AxtLvtkmJ+y01EUqK1zzKElCOjwpRh4aj37
         A/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JeJYhCJZDUtbhUrXkNGlVvRaow+U+ntBk0hB+rx5WKc=;
        b=AJav78FCxxsGBG/ccWX+EHSLsqay/pbxAUsfsFAsffekXwk6fMAbYc0tOwf3MbJ6fO
         LgboxGAWbka5NiG1iECNBndd5eeHQjBojWoqbikouAZj96csvSUXXvrnkH9jkCjmaSma
         PiNThTSec6al3xO2QKAPmHpMfltc8fgJJScmV2VzB7ouVppGXgmtvp2J9vVjXZtG1dRm
         zYQZKPce5eID/rauhuXwE+M4I/BpGY0gZjY1iTYdHK4kSFOj/gkWO4k+aH/zntaE4vzl
         ZFKTJh28UR+/6E3FHGewEsmQUAn7Dh2wUuIlsDxGZ3Mat4lWrNKlPlJsHoVCd7fi7KEM
         /QZQ==
X-Gm-Message-State: APjAAAW01aFqZc/i7i1wYpXCrZ7+WUZJUc3DDdg6fSkNPQYAZLkauUJq
        O5Idnel3I01ooZCkxUfvVxs=
X-Google-Smtp-Source: APXvYqwBIuSZp79+Fj901AnYvOZkamU4EdOb91nlRTHPMctOoyHe1KaKdGgu9aobrmtD4E3rFoQ9Kg==
X-Received: by 2002:a81:9c0b:: with SMTP id m11mr56464038ywa.3.1564176836608;
        Fri, 26 Jul 2019 14:33:56 -0700 (PDT)
Received: from localhost ([2600:1700:6e90:7930:34c8:864:563a:d5b0])
        by smtp.gmail.com with ESMTPSA id 197sm12384543ywb.56.2019.07.26.14.33.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 14:33:56 -0700 (PDT)
Date:   Fri, 26 Jul 2019 16:33:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Alternates advertisement on GitHub
Message-ID: <20190726213355.GA37697@TaylorsMBP9145.attlocal.net>
References: <20190726031840.GB23056@TaylorsMBP9145.attlocal.net>
 <19a0d5a9-864e-584d-d869-f15b5959beba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19a0d5a9-864e-584d-d869-f15b5959beba@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Fri, Jul 26, 2019 at 09:18:50AM -0400, Derrick Stolee wrote:
> On 7/25/2019 11:18 PM, Taylor Blau wrote:
> > Hi everybody,
> >
> > Pushes to forks of git.git hosted on GitHub now advertise the tips of
> > git.git as well as branches from your fork.
> >
> > You may recall that Peff and I have sent a handful of patches to allow
> > repositories to customize how they gather references to advertise from
> > an alternate, and then to use those alternate tips as part of the
> > connectivity check (in [1] and [2], respectively).
>
> I'm glad to hear you deployed this so quickly after review!

Thanks :-). There was a good chunk of additional work having to do with
how we replica repositories at the storage layer, but it didn't have
much to do with upstream git (which is why I avoided mentioning it in my
original email).

> > GitHub used to advertise '.have's on pushes to forked repositories, but
> > hasn't done so since 2012. We aggregate data from all forks into a
> > 'network.git', and expose the tips of each fork as:
> >
> >   refs/remotes/<fork-id>/<refname>
> >
> > Each fork lists the 'network.git' as its alternate, and thus the
> > advertisement can get prohibitively large when there are many forks of a
> > repository.
> >
> > Michael Haggerty's work on packed refs makes finding references
> > pertaining only to the root computationally efficient, and [1] makes it
> > possible to filter down when computing the set of references to
> > advertise. With [1], we can specify that computation exactly and only
> > advertise branch tips from the root of a fork network.
> >
> > We've been slowly rolling this out to a handful of repository networks,
> > including forks of git.git hosted on GitHub. If you host your fork on
> > GitHub, you shouldn't notice anything. Hopefully, pushes to your fork
> > will result in smaller packfiles. In either case, nothing should break;
> > if it does, please feel free to email me, or support@github.com.
>
> I tested this by updating 'master' in derrickstolee/git to match gitster/git
> and the pack was empty (ref update only). This makes fork management so much
> simpler!

Interesting. I'm glad to hear that it was working, but I took a
double-take at this paragraph since I see that 'derrickstolee/git' is
forked from 'git/git', not 'gitster/git'. I wasn't sure quite what was
going on, until I realized that 'git/git' and Junio's had an identical
'master'.

Even so, it shouldn't matter if they didn't, so long as 'git/git' was
ahead of 'gitster/git'. If Junio's fork was ahead, you would end up
pushing the new objects, and we'd immediately gc them away.

This makes me think about whether the situation could be improved,
perhaps by having your client tell GitHub that it has Junio's copy as a
remote, and then GitHub responding by also advertising Junio's branch
tips (if they are ahead of the network root).

This could feasibly even be implemented behind a v2 capability, but it
seems to reveal a lot of information about the pusher's setup, so
perhaps it would make sense to hide this behind a configuration option.

> Thanks!
> -Stolee

Thanks,
Taylor
