Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 706B51F453
	for <e@80x24.org>; Wed,  3 Oct 2018 14:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJCUuQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 16:50:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38083 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeJCUuP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 16:50:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id 193-v6so5751551wme.3
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7d51oLRXJvDaA+N/Cgpzz2YTgwQVwOGmslr9qzKCx6Y=;
        b=vdv+Zc6sIiBjoaFvoEPnQgHIflq1zIWzXiftlzUhWca16r53nb6ZZYqs+NTQ61f091
         WyelGKlv8won0cxhBPs1NuNrx+LbYmy2rdkLHvzMI09cdgevCsdgbek6zJHn6FhBSHkF
         dGQV2MsqZ4i+D739ekEOyatqTGgbxXIzXpy+PJSskHVffMooLLoIGCGLogGZ2ZSLoMcq
         sX8GUGBiItjQTfNEDGKfG+wj2fKEt1yJjncLD+xYOGwHOoUv3le+IJ2zwnzq8l44cLoc
         vffCoL0jE8tsyWkzStVixnGDGsNkt2dqtP0igDaLxL+AZzehxm8N5mA/gRnDO2po9Eiv
         hang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7d51oLRXJvDaA+N/Cgpzz2YTgwQVwOGmslr9qzKCx6Y=;
        b=hiiOuRWoeOEMZ9CNqS93Ga0rj0WcuPCm4yYlcc0MEZQ6D707t6IgVeU7i2s87zPNRn
         phPgMnshAjMaslTunrt/fW46Go8T25ZfEYr0mGvSYScxQ1e2PzWcVS8sUFYsb5cZPgo4
         ZbvA3cRdM4xSHkAWdSZlhyxIwpTI0UBmZEq9xsn3H1EmsM5dv4gBW2RVEBstDPOu25Ta
         dqdNTGxnhjLAN7TUaDMTSBtv2FiN+pUUfl5/+S/Dk/o9+grZOaUuNrAe4zowWIrRC1N5
         5gG5hiuNu4g/TYRLH+f2VsdOQBh8h5rpWN9wYZnk2k9h3iOcfQCNrJb/szNfS5PUJqEV
         Esqg==
X-Gm-Message-State: ABuFfoiFvc5IW9EV7EnukcK6BG5wWorHKD+LZ/C37nYNBIcXL6LL5+8V
        b3LNZo4h5VCNYFZFK8vozTkUabJA
X-Google-Smtp-Source: ACcGV62LOWLk7yRfRCcZMD0Q0Nu4ZR/ZVk0TYiDv3eg3u2oSipEhagVpMc6iiM9h09CSoqU3JicRVg==
X-Received: by 2002:a1c:dac9:: with SMTP id r192-v6mr1540156wmg.141.1538575301898;
        Wed, 03 Oct 2018 07:01:41 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id y184-v6sm1736583wmg.17.2018.10.03.07.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 07:01:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit graph
References: <87tvm3go42.fsf@evledraar.gmail.com> <20181003133650.GN23446@localhost>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181003133650.GN23446@localhost>
Date:   Wed, 03 Oct 2018 16:01:40 +0200
Message-ID: <87r2h7gmd7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 03 2018, SZEDER Gábor wrote:

> On Wed, Oct 03, 2018 at 03:23:57PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> Don't have time to patch this now, but thought I'd send a note / RFC
>> about this.
>>
>> Now that we have the commit graph it's nice to be able to set
>> e.g. core.commitGraph=true & gc.writeCommitGraph=true in ~/.gitconfig or
>> /etc/gitconfig to apply them to all repos.
>>
>> But when I clone e.g. linux.git stuff like 'tag --contains' will be slow
>> until whenever my first "gc" kicks in, which may be quite some time if
>> I'm just using it passively.
>>
>> So we should make "git gc --auto" be run on clone,
>
> There is no garbage after 'git clone'...

"git gc" is really "git gc-or-create-indexes" these days.

>> and change the
>> need_to_gc() / cmd_gc() behavior so that we detect that the
>> gc.writeCommitGraph=true setting is on, but we have no commit graph, and
>> then just generate that without doing a full repack.
>
> Or just teach 'git clone' to run 'git commit-graph write ...'

Then when adding something like the commit graph we'd need to patch both
git-clone and git-gc, it's much more straightforward to make
need_to_gc() more granular.

>> As an aside such more granular "gc" would be nice for e.g. pack-refs
>> too. It's possible for us to just have one pack, but to have 100k loose
>> refs.
>>
>> It might also be good to have some gc.autoDetachOnClone option and have
>> it false by default, so we don't have a race condition where "clone
>> linux && git -C linux tag --contains" is slow because the graph hasn't
>> been generated yet, and generating the graph initially doesn't take that
>> long compared to the time to clone a large repo (and on a small one it
>> won't matter either way).
>>
>> I was going to say "also for midx", but of course after clone we have
>> just one pack, so I can't imagine us needing this. But I can see us
>> having other such optional side-indexes in the future generated by gc,
>> and they'd also benefit from this.
>>
>> #leftoverbits
