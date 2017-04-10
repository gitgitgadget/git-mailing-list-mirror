Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CB920960
	for <e@80x24.org>; Mon, 10 Apr 2017 23:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbdDJXeP (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 19:34:15 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36645 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753077AbdDJXeO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 19:34:14 -0400
Received: by mail-lf0-f54.google.com with SMTP id s141so42978735lfe.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 16:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hoJj79ATBKt71zmjNRKu2TIZ6CPyXXYI5IO3zp0rPOM=;
        b=Mlp+xrAvtZCReLWR335hXME4YupohloI99/1dcpKKzTJb8FcswTAnA1GOjdoCFq66N
         StbqAwtCgLd+/Ub4xDhCr0+SeROHHo1WqZhcTcWJim+gHM1vUAbKRdgDLbxzWVJsq1Sl
         qlwSM+ctY7gik8+/uWK7S/4pjU4N9fu42MyhIAoj0iFXZ+mHvD+lhzRaa5wUi8UOCGgf
         EGSMqT94e6FKvxiql8yKcXYk/nXZywzEt7Q4bFOmPqkuV7lVzRrs2zVfA+tREVJFFbUR
         XlGwye718t/2pio0J0wFEQ/xXr55shyQBP/V7CGqe281lnYIg3Vbw2hCjA94DIoCMQ3V
         9E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hoJj79ATBKt71zmjNRKu2TIZ6CPyXXYI5IO3zp0rPOM=;
        b=YtyLtOHxgjG7cTi/SIaEnREN3e3rEEqycX62WkLQTzNme5yGyM5FRfLYoi41n9vv2n
         fg984k+m4Szh/gP44MHTnVUgBeBILxIzj75dp0exQEI3TrF0+sCKMyrW3IrelGycvRcv
         8R3DRvJNBsHjYwfadI8YIz8+UEtmlA2dYJl7ME3FQ3iKz2dlQxPRT+992fIpOw2tkj6U
         humkTiI3p2cpeYsW1XdeNfGCPlMZdU+Ei1QOZ8j3AbPobppxD9VWgqWhKpEIyUd10ZpT
         /9Ycqicxc1gHNPrFYhQoWzrYjLMyzT698A53zRJEXDgta7zE3mOkM4l/a8zGOQRLu5Ld
         qeOg==
X-Gm-Message-State: AFeK/H3PG0AagSMyRN2cgV2hCB540CbyT7GWP1CejwNvtkUQnYtZbOXnZk3gPUK6njQOHpBQGrqHqf0o2GvLCg==
X-Received: by 10.46.32.156 with SMTP id g28mr17344638lji.86.1491867252905;
 Mon, 10 Apr 2017 16:34:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Mon, 10 Apr 2017 16:33:52 -0700 (PDT)
In-Reply-To: <CACBZZX48RanjHsv1UsnxkbxRtqKRGgMcgmtVqQmR84H5j8awqQ@mail.gmail.com>
References: <CA+P7+xqS1Fh0aDV=QYbVMdRa=M4e-mBtjvknR=U_RShDoccNjQ@mail.gmail.com>
 <1n47so5.9e6qvf1bbqww4M%haller@ableton.com> <CA+P7+xq6MJa-J5cj2Om20d+g7KBretShpxH=13HWV7vFR9be8g@mail.gmail.com>
 <CACBZZX48RanjHsv1UsnxkbxRtqKRGgMcgmtVqQmR84H5j8awqQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 10 Apr 2017 16:33:52 -0700
Message-ID: <CA+P7+xowo+qXZ+Vr5vYg8wSpNzF44X9RsV34s_fKhBtVcddBvw@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Stefan Haller <haller@ableton.com>, Jeff King <peff@peff.net>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 2:58 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Apr 10, 2017 at 10:08 AM, Jacob Keller <jacob.keller@gmail.com> w=
rote:
>> On Sun, Apr 9, 2017 at 4:00 AM, Stefan Haller <haller@ableton.com> wrote=
:
>>> Jacob Keller <jacob.keller@gmail.com> wrote:
>>>
>>>> Agreed. You "take" a lease whenever you push to the remote or when you
>>>> pull from the remote and when you pull into the branch. It should
>>>> store something that tracks both the branch and remote branch together
>>>> so that you can generalize it to multiple remotes.
>>>
>>> I don't see why it has to support multiple remotes (but then I don't
>>> have much experience with workflows involving multiple remotes, so I ma=
y
>>> well be missing something). A local branch can only have one remote
>>> tracking branch on one remote, and in my view --force-with-lease withou=
t
>>> arguments works with that remote tracking branch only. Is this view too
>>> simple?
>>>
>>
>> I think that's fine. Thinking in terms of only one remote at a time is e=
asier.
>>
>>>> It doesn't necessarily track perfectly with a branch that contains
>>>> extra work such as when doing pull --rebase, but maybe you have an
>>>> idea about that?
>>>
>>> Maybe I wasn't clear enough about that in my proposal, but I propose to
>>> always store the commit hash of the remote tracking branch as a new
>>> lease after push and pull, not the local branch. This way it works
>>> nicely with pull --rebase and a branch that has extra local commits.
>>>
>>>
>>
>> Oh right. The main thing it doesn't give is that this doesn't enforce
>> that your local branch *has* to have at one point prior to the push
>> matched the remote branch that you're overwriting, which would be even
>> more evidence that your changes are what you expect and aren't
>> deleting anything unexpectedly. However, I think that's not strictly
>> necessary to require that since it would also break pull-rebase
>> workflow anyways.
>>
>> So something like:
>>
>> For a branch, also store its last known "lease" sha1 value, which
>> updates once every time that we push that branch to the remote
>> tracking branch or any time that we pull into the branch using the
>> remote tracking branch.
>>
>> This value is what we would default to, and we only need to store the
>> latest one, since that's the last known good value. If the value is
>> wrong then we will error and avoid deleting work, and if it's correct,
>> then we know that the remote branch is correct for this specific push
>> and is safe.
>>
>> I think this is straight forward and reasonable approach to solve the
>> problem, and makes using force-with-lease much nicer.
>
> Does this proposal require that all the things that can update a ref
> be hooked to maintain these lease values?
>
> In lieu of patches it would be nice for us trying to follow along to
> at least get some partial list of things that would need to be hooked
> up, how the command workflow would look like, what things wouldn't
> work that do now, or work that don't now etc.
>
> E.g. now if I:
>
>      git fetch
>      git show origin/master # manually note the sha1
>      git checkout -b blah <that-sha1>
>      git commit --amend
>      git branch --set-upstream-to origin/master
>      git push --force-with-lease
>
> It'll work unless origin/master was updated in the meantime, but
> there's no hint in any log that the branch was created from
> origin/master to begin with, just from the sha it happened to point
> to.
>
> I think this is a really important property of git, you don't have to
> go through some chosen UI that'll record things because you told it
> "I'd like to checkout stuff from that branch", you can just copy/paste
> the sha1.
>
> How will this work in this proposed "lease" workflow? Will some lease
> metadata not get created and I'll need to manually retcon that with
> some new command?
>
> I'm not just trying to come up with contrived scenarios, I've had to
> do several force pushes (on repos used by many people) and it's
> usually due to some giant commit being pushed. At that point the
> machine I'm investigating the situation on might not be the machine
> where I do the push from, so often I'm just copy/pasting a sha1 across
> machines.
>
> To me the *main* feature of --force-with-lease is that it's less
> shitty than --force, without imposing too much UI overhead. We have to
> be really careful not to make --force-with-lease so complex by default
> that people just give u and go back to using --force, which would be
> worse than either whatever current problems there are with the
> current --force-with-lease behavior, or anything we replace it with.

If you're already copying sha1s around you could use those as the
--force-with-lease=3Dbranch:<commit>, no?

That's better guarantee than just using --force-with-lease alone.

Thanks,
Jake
