Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4571F51C
	for <e@80x24.org>; Thu, 24 May 2018 09:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965950AbeEXJUq (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 05:20:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55535 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965741AbeEXJUo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 05:20:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id a8-v6so3049724wmg.5
        for <git@vger.kernel.org>; Thu, 24 May 2018 02:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IzWOlJg1bDe8PHxQgjmnMxRSQ0aE4hlqe67EdRtzpqA=;
        b=AhEKQtbj4NlSG5/E7Ka7pP/rR4IjIY3WlisoRhOVrEbD8YSO/iJe5dJjjT4Na+Sss7
         BoUVRM0OQvKVx70Tv/vnEAQVWxWMPWk0ZTyP8X1V1MGwVtaufZmNxZr01xleBAh2TyS9
         JCmQ/2/Sw/OIdCUux1bbRPcEMo+sC4YuW/2fywJBivOZsYasBLnRROvFydc0B8h/1NDr
         qYf4EHPWm9hpBqancr0CHU/bwg1sEpsCHQGx081X4ozxU8aQn5UXN0xhwyR0PeIJcHXj
         I+/RG8dybSK6sIy8HHjyf/S1jyAo/sFTWZ6hTVo71bCngU+D5oN4ij9Vq9jsAfXj2ECZ
         mL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IzWOlJg1bDe8PHxQgjmnMxRSQ0aE4hlqe67EdRtzpqA=;
        b=mCg6BLdKkJ54I1bCvIRm+N5sVPAerJBKqvtN10CayKWV2XkurcguelzMFfkFsVpI9v
         cZzGtKKx9NcPEfNo2u10uFoEut//RfDmseAjg7N5oSQEvs2TCudNs4CoetPsdK3l9vIs
         lypNx0quvG6wNJtu8FaEAZt2a1X1lgLCtehN6q6hf3rXhKW+XeFiPVhC3fW6bI+tGlLx
         d/JxCBa3ukYS80j1ypZXDvEGRxPrzimVVZBjNC5BiXk7bXjEjv1DYdXXECym4l4YPg0m
         NSnJOXuxpPeDqLl3n5DFHvPuLtW8BD19Iu0o5yWo2eMxNiUDhBywr/uXVdvE3d8hts8/
         qiVw==
X-Gm-Message-State: ALKqPwehzm+cTQWDPwzXy/jBBb/SBwYavG6m5iHiJ5TZpu/kOKkETiHt
        mnjVI65ojh7V8CjuU4+gVdnzgk7B
X-Google-Smtp-Source: AB8JxZovIE39HFp3UDe8HXYwVtH5PC2UwM0VtnISp5pLQHKeY70nub/YMmVooXijTOPK7/QTKj/mPg==
X-Received: by 2002:a1c:6f9a:: with SMTP id c26-v6mr6622792wmi.139.1527153643058;
        Thu, 24 May 2018 02:20:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o9-v6sm22777067wrn.74.2018.05.24.02.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 02:20:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH 3/7] rerere: add some documentation
References: <20180520211210.1248-1-t.gummerer@gmail.com>
        <20180520211210.1248-4-t.gummerer@gmail.com>
Date:   Thu, 24 May 2018 18:20:41 +0900
In-Reply-To: <20180520211210.1248-4-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 20 May 2018 22:12:06 +0100")
Message-ID: <xmqqr2m1quja.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +Conflict normalization
> +----------------------
> +
> +To try and re-do a conflict resolution, even when different merge
> +strategies are used, 'rerere' computes a conflict ID for each
> +conflict in the file.
> +
> +This is done by discarding the common ancestor version in the
> +diff3-style, and re-ordering the two sides of the conflict, in
> +alphabetic order.

s/discarding.*-style/normalising the conflicted section to 'merge' style/

The motivation behind the normalization should probably be given
upfront in the first paragraph.  It is to ensure the recorded
resolutions can be looked up from the rerere database for
application, even when branches are merged in different order.  I am
not sure what you meant by even when different merge stratagies are
used; I'd drop that if I were writing the paragraph.

> +Using this technique a conflict that looks as follows when for example
> +'master' was merged into a topic branch:
> +
> +    <<<<<<< HEAD
> +    foo
> +    =======
> +    bar
> +    >>>>>>> master
> +
> +and the opposite way when the topic branch is merged into 'master':
> +
> +    <<<<<<< HEAD
> +    bar
> +    =======
> +    foo
> +    >>>>>>> topic
> +
> +can be recognized as the same conflict, and can automatically be
> +re-resolved by 'rerere', as the SHA-1 sum of the two conflicts would
> +be calculated from 'bar<NUL>foo<NUL>' in both cases.

You earlier talked about normalizing and reordering, but did not
talk about "concatenate both with NUL in between and hash", so the
explanation in the last two lines are not quite understandable by
mere mortals, even though I know which part of the code you are
referring to.  When you talk about hasing, you may want to make sure
the readers understand that the branch label on <<< and >>> lines
are ignored.

> +If there are multiple conflicts in one file, they are all appended to
> +one another, both in the 'preimage' file as well as in the conflict
> +ID.

In case it was not clear (and I do not think it is to those who only
read your description and haven't thought things through
themselves), this concatenation is why the normalization by
reordering is helpful.  Imagine that a common ancestor had a file
with a line with string "A" on it (I'll call such a line "line A"
for brevity in the following) in its early part, and line X in its
late part.  And then you fork four branches that do these things:

    - AB: changes A to B
    - AC: changes A to C
    - XY: changes X to Y
    - XZ: changes X to Z

Now, forking a branch ABAC off of branch AB and then merging AC into
it, and forking a branch ACAB off of branch AC and then merging AB
into it, would yield the conflict in a different order.  The former
would say "A became B or C, what now?" while the latter would say "A
became C or B, what now?"

But the act of merging AC into ABAC and resolving the conflict to
leave line D means that you declare: 

    After examining what branches AB and AC did, I believe that
    making line A into line D is the best thing to do that is
    compatible with what AB and AC wanted to do.

So the conflict we would see when merging AB into ACAB should be
resolved the same way---it is the resolution that is in line with
that declaration.

Imagine that similarly you had previously forked branch XYXZ from
XY, merged XZ into it, and resolved "X became Y or Z" into "X became
W".

Now, if you forked a branch ABXY from AB and then merged XY, then
ABXY would have line B in its early part and line Y in its later
part.  Such a merge would be quite clean.  We can construct
4 combinations using these four branches ((AB, AC) x (XY, XZ)).

Merging ABXY and ACXZ would make "an early A became B or C, a late X
became Y or Z" conflict, while merging ACXY and ABXZ would make "an
early A became C or B, a late X became Y or Z".  We can see there
are 4 combinations of ("B or C", "C or B") x ("X or Y", "Y or X").

By sorting, we can give the conflict its canonical name, namely, "an
early part became B or C, a late part becames X or Y", and whenever
any of these four patterns appear, we can get to the same conflict
and resolution that we saw earlier.  Without the sorting, we will
have to somehow find a previous resolution from combinatorial
explosion ;-)

These days post ec34a8b1 ("Merge branch 'jc/rerere-multi'",
2016-05-23), the conflict ID can safely collide, i.e. hash
collisions that drops completely different conflicts and their
resolutions into the same .git/rr-cache/$id directory will not
interfere with proper operation of the system, thanks to that
rerere-multi topic that allows us to store multiple preimage
conflicts that happens to share the same conflict ID with their
corresponding postimage resolutions.

In theory, we *should* be able to stub out the SHA-1 computation and
give every conflict the same ID and rerere should still operate
correctly, even though I haven't tried it yet myself.

