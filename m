Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67931F404
	for <e@80x24.org>; Thu,  8 Feb 2018 21:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeBHVGY (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 16:06:24 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:51076 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeBHVGX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 16:06:23 -0500
Received: by mail-wm0-f53.google.com with SMTP id f71so11873368wmf.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=qwuiuX4QC+1z0l1jyY2ULu0+Z9j7L05u1C9zh9XpoTU=;
        b=s2N/NH2PcjMm4adM2tLUpOg+i4rirnyQZXthy5h3fu8Mp2hExpUam10GIB8fdUCBR0
         m2RaV5P1b6MqU8Q2eNa+lFGhqW+e7m5ixDc3U895T3py0A7wJTfV35NJ5O4wD81QYXs6
         ZYqlTGvlxTZ7OCC2+iAr5iBwBshSv1w02hk7h29Z7Wfppp2C7FQmUTkA88TExPyEFsoS
         Wov9rJawmfJTNzu3RZUs5DLLY4lRA/b3kjoccL2QapG7KPaDryqkI+afb1e0210Fdhxw
         5V9Hb4xX/+RDiAWTk+GFMG+Xo0fq2tfqD/rzwpwPlqbZULMs4zSAAySmSYDFugm4ewPG
         auNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=qwuiuX4QC+1z0l1jyY2ULu0+Z9j7L05u1C9zh9XpoTU=;
        b=FsxZFy3Kayk31GkVX2wEoND4DG2q+BPgIujFXFQz0TC9yoiVaQHzq0wgajFISEhRsB
         tV/zhy53/SjHzaB2my8JK0lKmt9gg0YnPAqQ5nN3QtbJlXNwPNxY5lePIR916UzVSK2T
         EYRxEl1a++Ubvc6QDB9ILj5il5SHt3JpRBGQ3fA6Sb3aSIqcrIUglI+COUgi8T00h6kG
         kFbDS7CsvOyYJ3w8XLTJj3Q3f+MdHDAm9zCd7bqDGvy2GUOYFmLXnNIFv9cg0oDf+IIQ
         8+Pc70LQcUy70A5XuvOdGYgqfwlkZ84wmM1GKPSlmUYFaxB8uZ4HeKIlBfZgQ/betuqE
         pVPA==
X-Gm-Message-State: APf1xPANAJx9j/TvBquKJ3oY6icwC9BaHpjcGNcKxPoqhHOBvLm8d9Ms
        wnK4GP5whmbVfZzm4D4lVGg=
X-Google-Smtp-Source: AH8x225jaB04iOCHOvAMxQaPyB0IcrvtigK7Pq02L3n+6liZ9xDJYoxQfJ3zITa2AY3EXEHQw2mm1w==
X-Received: by 10.28.156.67 with SMTP id f64mr287867wme.11.1518123982135;
        Thu, 08 Feb 2018 13:06:22 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id f19sm800342wmf.23.2018.02.08.13.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 13:06:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: Fetch-hooks
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io> <87inb8mn0w.fsf@evledraar.gmail.com> <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io> <20180208153040.GA5180@kitenet.net> <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
Date:   Thu, 08 Feb 2018 22:06:19 +0100
Message-ID: <87bmgzmbsk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 08 2018, Leo Gaspard jotted:

> On 02/08/2018 04:30 PM, Joey Hess wrote:
>> Leo Gaspard wrote:
>>> That said, I just came upon [1] (esp. the description [2] and the patch
>>> [3]), and wondered: it looks like the patch was abandoned midway in
>>> favor of a hook refactoring. Would you happen to know whether the hook
>>> refactoring eventually took place, and/or whether this patch was
>>> resubmitted later, and/or whether it would still be possible to merge
>>> this now? (not having any experience with git's internals yet, I don't
>>> really know whether these are stupid questions or not)
>>>
>>> PS: Cc'ing Joey, as you most likely know best what eventually happened,
>>> if you can remember it?
>>
>> I don't remember it well, but reviewing the thread, I think it foundered
>> on this comment by Junio:
>>
>>> That use case sounds like that "git fetch" is called as a first class UI,
>>> which is covered by "git myfetch" (you can call it "git annex fetch")
>>> wrapper approach, the canonical example of a hook that we explicitly do
>>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> not want to add.
>>   ^^^^^^^^^^^^^^^
>>
>> While I still think a fetch hook would be a good idea for reasons of
>> composability, I then just went off and implemented such a wrapper for
>> my own particular use case, and the wrapper program then grew to cover
>> use cases that a hook would not have been able to cover, so ...
>
> Hmm, OK, so I guess I'll try to update the patch when I get some time to
> delve into git's internals, as my use case (forbidding some fetches)
> couldn't afaik be covered by a wrapper hook.

Per my reading of
https://public-inbox.org/git/20111224234212.GA21533@gnu.kitenet.net/
what Joey implemented is not what you described in your initial mail.

His is a *post*-fetch hook, we've already done the fetch and are just
telling you as a courtesy what refs changed. You could also implement
this as some cronjob that polls git for-each-ref but it's easier as a
hook, fine.

What you're describing is something like a pre-fetch hook analogous to
the pre-receive hooks, where you're fed refs updated on the remote on
stdin, and can say you don't want some of those to be updated.

This may just be a lack of imagination on my part, but I don't see how
that's sensible at all.

The refs we fetch are our *copy* of the remote refs, why would you not
want to track the upstream remote. You're going to refuse some branches
and what? Be further behind until some point in the future where the tip
is GPG-signed and you accept it, at which poich you'll need to do more
work than if you were up-to-date with the almost-GPG-signed version?

I think you're confusing two things here. One is the reasonable concern
of wanting to not have your local copy of remote refs have undesirable
content, but a pre-fetch hook is not the way to accomplish that.

The other is e.g. to ensure that you never locally check out some "bad"
ref, we don't have hook support for that, but could add it,
e.g. git-checkout and git reset --hard could be taught about some
pre-checkout hook.

You could also have some intermediate step between these two, where
e.g. your refspec for "origin" is
"+refs/heads/*:refs/remotes/origin-untrusted/*" instead of the default
"+refs/heads/*:refs/remotes/origin/*", you fetch all refs to that
location, then you move them (with some alias/hook) to
"refs/remotes/origin/*" once they're seen to be "OK".
