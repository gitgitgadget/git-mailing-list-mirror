Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D211F45F
	for <e@80x24.org>; Fri, 10 May 2019 12:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfEJMoe (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 08:44:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33505 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfEJMod (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 08:44:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id k189so3571910qkc.0
        for <git@vger.kernel.org>; Fri, 10 May 2019 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CZxPvn6Q8fxlbmUo8c/GbY2CBGayvdA/hX3LOQWza08=;
        b=hWLLeNP9C1wpOFQJlZduURG6M2fm/eymh6tTRl8kOFAAGeGJ9aQXQ7bJTiczKP9SnT
         G3h9+Uq2AzLMgw3aRn3qtJfS4yVN/SRnl3DnmTSjjIlrwSAKvxKCiu/Ryse1w4f6ylp4
         /9OjEJSJAQB2B3Tru1+7Zulh+a8OT78+V4GXENLkzgIElLOqFc4EkmtWF9IbSNp/v4wS
         Nl+mEpFeWzCZA8kDtH5DvhXPzKWlGQUS4UuUHcDpbr+mSh20R0szOLcCciGFYm4D4Iq9
         RRDh0eof2uENQY937tTs0oeQ9CiLdFTsLRpFFPCV6dwqQrxaA73/ZaYXtajxe7lGvZzi
         n84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZxPvn6Q8fxlbmUo8c/GbY2CBGayvdA/hX3LOQWza08=;
        b=tKv2w8cO2j3e1GfYamne1jwfj09BaEvtC5HrS5lZyJh64zwzhyk9u7oUADKckHGBvQ
         6LoqcflkJV0KCWzl/DnXQwRPCzjm0Kty67QWBhKjAzcAZEXGH4oLjpTcDWszE6KttKCr
         tDd0+gFCfqe2mkWsxyO/oKK8wGMjXz/NSWOS07F91FVdjEUKdX4MJXT+P3EZspxNmD5R
         LvLBubooxnC5bsNeeVQ8IsiX0f/kJ9CF/cXUNN1aQc8wPIrjegEDHx7UVevvyWemlNx4
         e72fZFwdBcYPs6cQIA8P1u8BYIxYqDBjnZHI+gPp5oCnic6TArYe0YXrJYzseHfv3RYe
         V4TQ==
X-Gm-Message-State: APjAAAUgxZZ2Ei5f7pEbaKQpkfHyw9kT9RV9uYVBDTcn/Zbnu7rwE6BH
        yw+p9digHrsyP4KI/MsKuOs=
X-Google-Smtp-Source: APXvYqznLJ7MWUM+ZLP2Km8WnWLLcaunTf1gkUvMnd5yh/ZI+7fZLN/54drZHqb/b8sXsnivzjgCRw==
X-Received: by 2002:a37:7183:: with SMTP id m125mr8475910qkc.119.1557492272309;
        Fri, 10 May 2019 05:44:32 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id t63sm2426290qka.33.2019.05.10.05.44.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 05:44:31 -0700 (PDT)
Subject: Re: [PATCH 12/17] Documentation: describe split commit-graphs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.git.gitgitgadget@gmail.com>
 <7bbe8d9150a623ea684c94d129eda1607dd32a79.1557330827.git.gitgitgadget@gmail.com>
 <20190508172029.GP14763@szeder.dev>
 <d5ef1bcb-a910-295f-fc95-e461d34f3883@gmail.com>
 <87pnoshfkq.fsf@evledraar.gmail.com>
 <f27db281-abad-5043-6d71-cbb083b1c877@gmail.com>
 <875zqjy6ga.fsf@evledraar.gmail.com>
 <caefe73d-828f-5668-91bf-1f5a82931ad1@gmail.com>
 <874l63xpwx.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6d9c0911-6f36-3fb7-2be9-2be9bc68fc69@gmail.com>
Date:   Fri, 10 May 2019 08:44:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <874l63xpwx.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/9/2019 5:45 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, May 09 2019, Derrick Stolee wrote:
> 
>> How far apart can these concurrency issues happen in the file system?
>> One benefit to Option 0 is that there is only one file _write_ that matters.
>> The other options require at least two writes.
> 
> You need to write() and then fsync()/close() to be guaranteed that the
> data was written to the file.
> 
> As an aside I see that the current commit-graph uses CSUM_FSYNC (but
> without CSUM_CLOSE, probably doesn't matter), I thought it
> didn't. Maybe we should remove that unless core.fsyncObjectFiles=true
> (or have another "looser" fsync config).
> 
> So writing is cheap, but it's asking the OS to sync to disk that
> generally hurts. As noted in the discussions when core.fsyncObjectFiles
> was introduced some FSs are really stupid about it, so it's better to
> avoid these caveats if you can.
> 
> As noted in the fsync(2) manpage on Linux (ditto POSIX) an fsync to a
> *file* doesn't guarantee that the directory entry is updated. So we'd
> also need to opendir() the containing directory and fsync that FD as we
> juggle these renames/replaces.

I think any plan should not rely on directory scanning for this reason.
Starting from a known file (info/commit-graphs/head?) and then navigating
directly to files would avoid these issues, right?

>> That would prevent breaking old clients, but they would also not have any
>> commit-graph data to use. Option 0 and Option 2 can leave a valid v1
>> commit-graph file with the majority of the commit data. This is only a
>> performance issue for a narrow case, so maybe that's worth ignoring.
> 
> Indeed. As noted in the thread about the v1->v2 format if we just append
> new chunks we have leeway like that, i.e. it's completely OK if we
> choose to from the POV of old clients write no data to them so they're
> not helped by the optimization, that's a more graceful way than them
> dying on a format change.
> 
> And yes, we could stick the proposed commit-graphs/info "index" in a
> chunk there. I've got a preference for a \n-delimited list similar to
> objects/info/packs, but that's mostly for aesthetic reasons.

I think a \n-delimited list would be better because using the commit-graph
format with zero commits creates at least a kilobyte of data for a
zero-valued fanout table. If we relax the format to say "the head file
has zero commits, so the fanout, commit oids, and commit data chunks
should not exist" then we would be fine, and get versioning "for free".
But the file serves a different purpose.

>>> Whereas if I run something with "ionice -c 3" I could possibly hang for
>>> however many hours/days/weeks we wait until another "gc" comes along and
>>> unlinks those old files, but if I'm running it like that I'm not
>>> expecting it to be fast, so it's OK if the files went away, and it won't
>>> ever get the wrong file (since the filenames are hash-addressible).
>>
>> How do we recover from this situation? Have no commit-graph at all? Or
>> do we try again?
> 
> I think just no commit-graph at all is fine. If it lazily took you N
> hours from reading the "commit-graphs/info" to getting around to looking
> at now-disappeared files it sucks to be you.

Sounds good. We can revisit if this actually starts hurting any real
scenarios.
>>> And we'd have the reverse problem with a git-for-windows wouldn't we?
>>> I.e. the fork is "far ahead".
>>
>> This is the quintessential example for why we can't have a single chain
>> of commit-graphs long-term. It deviates from most fork networks enough
>> that we can't say "just take the base repo's commit-graph" but typical
>> fork networks can't say "just take my local commit-graph chain". The
>> two-dimensional graph position would be valuable to help both shapes.
> 
> Indeed. I just thought about e.g. a [branch|tag] --contains for the
> current repo, but for things like "how ahead of gitster/pu is my GFW
> topic?" one graph for the network is needed.
> 
> If we can help it it would be useful to not unduly box the user in and
> offer them flexibility to choose. I.e. some (e.g. my staging server
> use-case) might want base+local repo and never need 2x local repos
> v.s. each other, whereas github/gitlab might need one giant graph etc.

I made a note to follow up with the two-dimensional graph position [1].

[1] https://github.com/microsoft/git/issues/138

>>> This makes it easy to e.g. say "we retain old commit-graph files for 2
>>> weeks", and "we re-gc everything in cron weekly".
>>
>> Here, I think, is the most crucial point of why Option 2 may be worth the
>> added complexity over Option 0. Option 0 _requires_ that the files be
>> replaced immediately on a new write, while Option 2 provides a way to
>> leave old files around and be cleaned up later.
>>
>> But how should we actually perform this cleanup? I would imagine a
>> 'git commit-graph gc' subcommand that cleans up old files. A 'git gc'
>> run would perform the same logic, but we need a way to do this outside
>> of 'gc'. It needs to use the modified time as an indicator, since we
>> could run 'git commit-graph write' twice an hour before our two-week
>> cleanup job and need to keep our hour-old stale file. Perhaps the
>> 'git commit-graph gc' subcommand could take a '--window' parameter that
>> can be 0, while 'git gc' uses a config setting.
>>
>> The decision can then be: "is this file not in our graph chain and
>> older than <window> from now?"
>>
>> But also, I expect the stale commit-graph files will pile up quickly.
>> We rebuild the commit-graph file roughly every hour. I would write
>> our maintenance to call these subcommands in order with no delay:
>>
>>     "write" -> "verify --shallow" -> "gc --window=0"
>>
>> (Here, "verify --shallow" would only verify the tip of the
>> commit-graph chain.)
> 
> I think a sane default would be to just unlink() the old ones as soon as
> we're done writing the new ones & writing the commit-graphs/info file
> saying "here's your current ones".
> 
> I.e. as noted in what I said about fsync above it's not that we need to
> keep the old ones around, but avoiding the tight dance with N & N+1
> updates, and being friendlier to stuff like lookupcache=positive.
> 
> Users with more advanced use-cases (e.g. cross-repo graphs) could then
> always increase such an expiry.

Noted. Thanks.

>>> It would work best if we can also pull this trick on the "base"
>>> commit-graph file, which I believe we could do in a backwards-compatible
>>> way by making "commit-graph" a symlink to whatever "commit-graph-<HASH>"
>>> is the current "base".
>>
>> Could we do this, anyway? Use 'commit-graphs/info' to point to the tip
>> and let the symlink 'commit-graph' point to the base. Then, old clients
>> would load a full commit-graph and new clients would get the full chain.
> 
> How's the Windows support for symlinks? We don't symlink anything in
> .git/objects/ ourselves now (but see[1]).

Maybe this won't work in all scenarios, but it could be left as a future
enhancement if anyone cares. The "support two versions" scenario is rare
enough to avoid building something specifically for it, but often enough
to not _break_ it.

> On *nix just manually symlinking it works fine (you need to go out of
> your way not to support it, which we didn't).
> 
> So something like this would be desirable:
> 
>     $ tree -a .git/objects/info/
>     .git/objects/info/
>     ├── commit-graph -> commit-graphs/commit-graph-2492e0ef38643d4cb6369f76443e6a814d616258
>     ├── commit-graphs
>     │   ├── commit-graph-2492e0ef38643d4cb6369f76443e6a814d616258
>     │   ├── commit-graph-988881adc9fc3655077dc2d4d757d480b5ea0e11
>     │   └── info
>     └── packs
>     $ cat .git/objects/info/commit-graphs/info
>     2492e0ef38643d4cb6369f76443e6a814d616258
>     988881adc9fc3655077dc2d4d757d480b5ea0e11
> 
> I.e. create new ones as needed, and when done say what sequence they
> should be read in in the "info" file, and symlink "commit-graph" to
> whatever the latest "base" is as a courtesy to old clients (or not, or
> eventually don't bother).

OK. Glad that the idea would work.

Thanks,
-Stolee

