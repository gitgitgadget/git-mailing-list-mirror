Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FEA01F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 18:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbeKWFRd (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 00:17:33 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46173 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbeKWFRd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 00:17:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so8403240edt.13
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 10:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=97X7zSSTVGzmFGS8dQt5Mmad2wbBCxa16aTmwwyQrwI=;
        b=nvlQa2ay7smS03RZivE+4jiPjbJpbHGVTEKdCmh4rjYsz8DHTakVG4pSk0d66MwJZs
         NU9YcHyAX717ik+vOkxNu98WwY2c6tdGTY1yVJeEmXHxOByrzRSB1PEifhn3hT0wp37+
         gyBHmbpBun1lbxydZJfIUKa6dlskD7oFU8FgIX4o+bGF37B/qkXsBmJSduEc0WpSUY2B
         rrGJlobG7eN8/FV9yvn+ZJ+L9KGjO2DjNKl99s4+UyNZFU/rBL6caGWopC4pp2wMeHEe
         mBYNRoFmlW1tfEU3IClTtRUg4Wi2Pgvl+jzMx4fDk1PA0qoBV81hiYe5bBxvw5+jBSfJ
         WCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=97X7zSSTVGzmFGS8dQt5Mmad2wbBCxa16aTmwwyQrwI=;
        b=qu3v8Lq9MuHvllj4G7R5IeY2AA8FHCFOmiMs66QXD22Q50PhjpsC5vpcvvO2Erp6mj
         cLrUC985MxBaacsxCFSDH6K9rx7TR0gsX2qkGM5uWZdiW3ZD9KgRX7HIWcklzKE6R0NA
         nrplqi0rZ29jvi38hmvjeZBLC9dHryGXUg/nWRYW9pXupIwLwCIjqTpfKl6jJwsvXPab
         l9LXmklK/9kmToWtaFSSlx2hFXthxJKtZQ5nGJ91zDu4PXoX7zs3BHThzvTgjh0329f1
         Rjk6uu8JLkI2+ZS3nFuHOkVB1He2eJUWFGk7eha03YRteu2LLvcSMvM0XBzE1yVXG0LS
         eZWg==
X-Gm-Message-State: AGRZ1gKcpvTY/VxPkL/rnL32OVKJShwEhrX8LLGP5uEablpPYXawxn5+
        SnNDH/iVZkI6NPlIzN6JYfS3dPN4ZQE=
X-Google-Smtp-Source: AJdET5d6BlYHrFXF5xxDjMdSXRuY3+MnaPtzYWlOr4Zg7Ue0hdr4OHZ9yU8x/mSdPdR//7jptTSqsQ==
X-Received: by 2002:a17:906:1859:: with SMTP id w25-v6mr9041465eje.3.1542911815970;
        Thu, 22 Nov 2018 10:36:55 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id s3sm11906895edm.31.2018.11.22.10.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 10:36:54 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com> <87muq2zoy9.fsf@evledraar.gmail.com> <20181122175259.GC22123@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181122175259.GC22123@sigill.intra.peff.net>
Date:   Thu, 22 Nov 2018 19:36:54 +0100
Message-ID: <87efbd0xix.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 22 2018, Jeff King wrote:

> On Wed, Nov 21, 2018 at 11:48:14AM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>>
>> On Wed, Nov 21 2018, Junio C Hamano wrote:
>>
>> > * jk/loose-object-cache (2018-11-13) 9 commits
>> >   (merged to 'next' on 2018-11-18 at 276691a21b)
>> >  + fetch-pack: drop custom loose object cache
>> >  + sha1-file: use loose object cache for quick existence check
>> >  + object-store: provide helpers for loose_objects_cache
>> >  + sha1-file: use an object_directory for the main object dir
>> >  + handle alternates paths the same as the main object dir
>> >  + sha1_file_name(): overwrite buffer instead of appending
>> >  + rename "alternate_object_database" to "object_directory"
>> >  + submodule--helper: prefer strip_suffix() to ends_with()
>> >  + fsck: do not reuse child_process structs
>> >
>> >  Code clean-up with optimization for the codepath that checks
>> >  (non-)existence of loose objects.
>> >
>> >  Will cook in 'next'.
>>
>> I think as noted in
>> https://public-inbox.org/git/e5148b8c-9a3a-5d2e-ac8c-3e536c0f2358@web.de/
>> that we should hold off the [89]/9 of this series due to the performance
>> regressions this introduces in some cases (while fixing other cases).
>>
>> I hadn't had time to follow up on that, and figured it could wait until
>> post-2.20 for a re-roll.
>
> Yeah, my intent had been to circle back around to this, but I just
> hadn't gotten to it. I'm still pondering a config option or similar,
> though I remain unconvinced that the cases in which you've showed it
> being slow are actually realistic or worth worrying about

FWIW those "used to be 2ms are now 20-40ms" pushes on ext4 are
representative of the actual prod setup I'm mainly targeting. Now, I
don't run on ext4 this patch helps there, but it seems plausible that it
matters to someone who's counting on that performance.

Buh yeah, it's certainly obscure. I don't blame you if you don't want to
hack on it, and not ejecting this out before 2.20 isn't going to break
anything for me. But do you mind if I make it configurable as part of my
post-2.20 "disable collisions?"

>  (and certainly having an obscure config option is not enough to help
> most people). If we could have it kick in heuristically, that would be
> better.

Aside from this specific scenario. I'd really prefer if we avoid having
heuristic performance optimizations at all costs.

Database servers tend to do that sort of thing with their query planner,
and it results in cases where your entire I/O profile changes overnight
because you're now on the wrong side of some if/else heuristic about
whather to use some index or not.

> However, note that the cache-load for finding abbreviations _must_ have
> the complete list. And has been loading it for some time. So if you run
> "git-fetch", for example, you've already been running this code for
> months (and using the cache in more places is now a free speedup).

This is reminding me that I need to get around to re-submitting my
core.validateAbbrev series, which addresses this part of the problem:
https://public-inbox.org/git/20180608224136.20220-21-avarab@gmail.com/

> At the very least, we'd want this patch on top, too. I also think René's
> suggestion use access() is worth pursuing (though to some degree is
> orthogonal to the cache).

I haven't had time to test that, and wasn't prioritizing it since I
figured this was post-2.20. My hunch is it doesn't matter much if at all
on NFS. The roundtrip time is what matters, whether that roundtrip is
fstat() or access() probably not.

> -- >8 --
> Subject: [PATCH] odb_load_loose_cache: fix strbuf leak
>
> Commit 66f04152be (object-store: provide helpers for
> loose_objects_cache, 2018-11-12) moved the cache-loading code from
> find_short_object_filename(), but forgot the line that releases the path
> strbuf.
>
> Reported-by: René Scharfe <l.s.r@web.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1-file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sha1-file.c b/sha1-file.c
> index 5894e48ea4..5a272f70de 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -2169,6 +2169,7 @@ void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
>  				    NULL, NULL,
>  				    &odb->loose_objects_cache);
>  	odb->loose_objects_subdir_seen[subdir_nr] = 1;
> +	strbuf_release(&buf);
>  }
>
>  static int check_stream_sha1(git_zstream *stream,
