Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC7CC77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 15:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjERP5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 11:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjERP5A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 11:57:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004CDE1
        for <git@vger.kernel.org>; Thu, 18 May 2023 08:56:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510e5a8704bso6038a12.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684425417; x=1687017417;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Onyej0q1PwUDhBJsiH1+UGN2nF/IiZvCGqQs73FRCc=;
        b=hUmVusoQMWQUeUXVRpLdGW1/GzzjfqcnOqCFz8w6ojCmXVaqcLh3f89566ZsmzOm1l
         XFswiUpszg7R2C7nWUVxutnTeipgqsldY+efopsEDzZFHOjVYH04oz+ToMQJFdls3V/A
         eclkJxf2mHSETi1S6vUY9oOYVz7Ee0RSgyoYZVdtg/wQFVMS6NxTndPBbHX/l2Mrf/fX
         LN/An1k5EddM54mQLg/1rK7V0dCrcNKIPtgM0wmocyHr3aLH8QzZPt2WBzrth9vaEZxl
         y5wdbm+0LbteZABVe8mC9CGAhQ5bL89usSDqp1Of1M/qELJe3gKkCIpCLccsEvENpvR7
         jc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684425417; x=1687017417;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Onyej0q1PwUDhBJsiH1+UGN2nF/IiZvCGqQs73FRCc=;
        b=Ogi6iuQhNJu+Z/qObcRpyikziSPxcGGUrCQ2MdrVe9ggMxFGAbd2gHEXaqLbTnfFjw
         vIc3/XyrGKde0nVk4lymKjs8h1QdPbSdCZoPpmQA4SMjMRDndIG3XVU3S3Vrqg6ifUn2
         ey0UNtsv/BNSIsp54u33eX26wlLQ7rGDDKXOF7d5zFkR/o103jLiEjvPIoOd/K7Flb7l
         y8LFamk47SSEz5qscEDoWcASF+o2PDYAP/6X7gY0mrh6gvrRjSpVHNEkjqcCKwDPkxi2
         14yIn8b2VGvP/kJyGjZOrpv3COp3Yh3t7tnS7SgzSqkrsatxAoblWwXi25rbVgIwvm6f
         gDaQ==
X-Gm-Message-State: AC+VfDz57SUTKVsptwOrC/hvE5S69mx83CDuY+gDs3ZXnD9KfbwgTN9f
        s3HaGlJL8yMPJ0+jKBe0B6TfTTQSXgBVq3TxZof4SeoHMu+RftBXU17f9BT9
X-Google-Smtp-Source: ACHHUZ7YBPD6kC5qZBsycPXQOLoODchmoLnacy89argP48btWB5ChgaHzZ8mGOCwXsCUKl44rFSfQCV2CcxsVC9XovM=
X-Received: by 2002:a50:f696:0:b0:510:d1ac:eb1f with SMTP id
 d22-20020a50f696000000b00510d1aceb1fmr77154edn.5.1684425416886; Thu, 18 May
 2023 08:56:56 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Thu, 18 May 2023 08:56:46 -0700
Message-ID: <CAJoAoZk9m-yjOGa34pnc4-6vf5BBV=nMCN-QdFW-YV+jYruVUQ@mail.gmail.com>
Subject: Video conference libification eng discussion, today at 16:30 UTC
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello folks,

Google is hosting a standing engineering discussion about libifying
Git, for contributors interested in participating in or hearing about
the progress of this effort. Expect this discussion to be free-form
and casual - no powerpoints here!

We're hoping to hold this meeting every Thursday at 9:30am Pacific
(16:30 UTC) via Google Meet.

To get an invite to the video conference and the notes document,
please reply to this email. Please also add points to the agenda
(template follows) if you want to raise awareness of them.

We'll choose a topic to discuss at the beginning of the meeting, and
I'll reply afterwards with the notes.

- (asynchronous) What's cooking in libification?
  - Patches we sent regarding libification
  - Patches for review related to the libification effort
- (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
- (asynchronous) Where are you stuck? What eng discussions do we want
to have? (We'll choose a topic from this list at the beginning of the
meeting.)

Here's the notes from last week:

*   What's cooking in libification?
    *   Patches we sent regarding libification
        *   https://lore.kernel.org/git/pull.1497.git.git.1682104398.gitgit=
gadget@gmail.com/
config RFC
            *   Some split opinion upstream, interested in reaching
agreement before continuing
            *   Whether to stand up libified API in parallel, or
replace internal callers with new API
            *   Not many places are using extra metadata. Avarab is
suggesting to only change the API invoked for some callers, not all of
them.
            *   Glen: my concern is that the config API is already
huge (bigger than it needs to be). I don't want to add another
parallel set of APIs there =F0=9F=99=81
            *   And, passing the metadata is something we probably
wanted for a while, but considered too churny. With that refactor i
think we can improve a lot of the diagnostics and error reporting in
config in git overall. Would be less painful to not carry the burden
of the two APIs and add new logging piecemeal.
            *   Plus, we need to be able to make these large scale
refactors for libification in general
            *   Emily: how can we move forward? Pros and cons? Get
avar to come to a chalk talk?
            *   Jonathan: avar proposed something, glen explained why
he disagreed, i don't think it's our turn, i think it's avar's turn.
            *   Junio: avar is on pat leave =F0=9F=99=82
            *   Emily: so we shouldn't be waiting for avar, we should
be convincing someone else on the list to agree with glen, right?
            *   Jonathan: originally i was interested in migrating
stuff to the configset first, but past me didn't say that, so i trust
past me too =F0=9F=99=82
            *   There's a summary of that approach in the cover letter
at the bottom.
            *   Glen: avar proposed another option, also linked in the
cover letter.
            *   Jonathan: based on the nature of these patches,
probably there is not less churn by converting to configset first.
            *   Glen: I found the conversion to configset to be really
difficult actually
            *   Glen: The other approach suggested - the config API
has a low-level get\_config\_from\_file() which doesn't evaluate
includes etc. and git\_config(), which reads various sources and
caches in a configset. git\_config() does cache. Avar's alternative
proposal is that since very few places need to read from file
directly, we can drop get\_config\_from\_file() and always use the
caching api to read from things. So we do one complete pass and then
read from cache the rest of the time.
            *   There's a little extra cost of memory and runtime but
it's not that big, and we have a smaller public API.
            *   But it's taking away a sensible purpose-build API and
replacing it with something more specific to the git binary. We don't
need the caching to read a bundle-uri file, for example, we can just
read the file directly.
            *   Junio: one example of reading from file is bundle-uri,
but that's not really a config, same for gitmodules? Why are we still
reading from config file directly at all, even the oldest git config
functions go through the in-memory cache, right?
            *   Glen: yeah, we only use this to read stuff in config
syntax that isn't actually config, those examples and also the
sequencer.
            *   For libification, it makes sense for a libified caller
to want to leave things in config file format, and we can put that in
a low-level config library somewhere, right? But config.h is huge now
so it's not suited to a public api
            *   Jonathan: are you looking for others' opinions? Do you
want to rearrange the patches?
            *   Glen: Would like someone else to agree the approach is
promising before I start
            *   Jonathan: well, I agree =F0=9F=99=82
            *   Emily: might hold more weight to find a non-googler reviewe=
r
            *   Randall: I don't know enough about config to take a
look at it unfortunately. I have a gut feeling of trepidation and not
sure why. Not offering to review it in depth =F0=9F=99=82
            *   Glen: because of the scale of the change, maybe?
            *   Randall: users of the API vs. internal users of the
API, what's the use case for not using cached config?
            *   Emily: probably makes sense for VFS to use a file-only
lib for reading local, gitmodules, etc.
            *   Junio: that's not a reason not to use caching, though, righ=
t?
            *   Glen: basically, we don't have a general "read from
file and put it in cache". Implementing it wouldn't necessarily make
the API simpler, so nobody implemented it internally yet
            *   Randall: Are we increasing IO as a tradeoff? If we
normally should be using the cache, then getting config values
shouldn't usually require going to the filesystem (except the first
time). But if we have an alternate path to config data, then we're
double-reading, right? Does this approach increase the amount of
redundant IO we perform?
            *   Junio: historical context: we didn't have
git\_config\_get\_foo() that names a variable, we only had the
git\_config() callback, and that callback always reads all the files.
If you had this call twice, then it was very expensive, historically.
That's why we added caching behavior.
            *   Jonathan: nobody is proposing double read. The
callback approach doesn't double-read anymore, right?
    *   Patches for review related to the libification effort
        *   Elijah=E2=80=99s final cleanup for cache.h:
https://lore.kernel.org/git/pull.1525.git.1683431149.gitgitgadget@gmail.com=
/
            *   Calvin: currently finishing up review for this
            *   Jonathan: does it need more reviews than calvin's?
            *   Calvin: my main concern is that the split between
objstore and objstore-lowlevel is not super clear. Otherwise i'm happy
with the series
            *   Jonathan: is that a blocking concern?
            *   Calvin: depends on elijah's response. Right now it's
unclear which file to add a new function to, so we need some kind of
definition. So yes, it's blocking-ish? But I think elijah can solve
the concern easily
            *   Jonathan: i'll take a peek tomorrow
            *   Glen: on a previous series, elijah referred to
low-level as having no textual dependency on the header. Would be good
to clarify this upstream
*   (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
*   (asynchronous) Where are you stuck? What eng discussions do we
want to have? (We'll choose a topic from this list at the beginning of
the meeting.)
*
*   Glen: how are the c-tap-harness discussions going?
    *   Josh is taking this series over including pursuing
discussions, so no update here unfortunately
