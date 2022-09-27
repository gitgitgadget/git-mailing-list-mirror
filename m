Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5159EC07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 22:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiI0W4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiI0W4e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 18:56:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2F27E038
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:56:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u24so395010edb.11
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 15:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OjWcOgpWH3RIXKd7SSKk77wjtYj0beKlkfmrpnkOHL4=;
        b=BOVi8xplta/wmaUcfJSL9QPjpAGNJdW+19Snjz9ZrubmZKmHNQJDFen0BaTnzCoQ7K
         2qdcf/bE5TS1pYFxj9hr3ez2KzAal7rGhJKSHdPidu/ooSyM+ScA1WEkrGXcvJvcHpyd
         golrPGFjtkLV9cnDO4YemjWVpVPLvXJsrSze5KLmFMHD+3TC5LAIL5TwpcBqr2PJZPEe
         mp0eFlDbgdUJk+i5xoRxni46f9iiF8u7SDoR46jFSSME+uanNqaqV29s0uHTszy9kD+f
         dURvJOWBSKLrn1aLQQP4MNNt+d3E6C0wQOvN/Twhp1DBRkWphJq7GvQAhJpixmFyx8gw
         Rhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OjWcOgpWH3RIXKd7SSKk77wjtYj0beKlkfmrpnkOHL4=;
        b=1zCXc6CqPIRDWtOP1b11jHNq/FqvOS+hSIvmRoK9efNquaxjHCLViCfUI5Hx7v/Ha4
         mIvG7ldntvMG84kPM6ZsbHUkzZrWEt/sA2JcFwyfmx9LrDQ3XzOY+qDNwIjBLg4r0s9A
         1/IOwC9ZKIqAjOPA6AqnotmpaEtk7L6lnFy5XoRsLGAOZVGDjirVorhObaoplRmRAFhw
         +Zvru//nu0xcidJ3ZEibnCNc3lNkbk4/DdLLhDkxy3EyOoFHU0uRGpx+WBsFm44N1fcm
         N0O2FEx+HZf70vBEyxEDf7l0GZYrKAoaMNT9hKQ+CEqL1Ze1Co4VuhYBpUhfHkU1H0o7
         q2/Q==
X-Gm-Message-State: ACrzQf3ITMaW6Z7UM/KatnL1Pnf9fWFjry0w7hFsFC7my8VVOvUjFJ+n
        3s8eIvasBEwT4dZ9ukcCB1dqrzANm7LOYcX9eCYniA==
X-Google-Smtp-Source: AMsMyM6GiNtQcZuMm1wmBkPnaAuWQY/TRsax885ZwyP4ck452TKF3MidtPAuyiRPlgImi9EvAJHBKygw2krn2MN8lWg=
X-Received: by 2002:a05:6402:2201:b0:44f:443e:2a78 with SMTP id
 cq1-20020a056402220100b0044f443e2a78mr29685123edb.76.1664319391595; Tue, 27
 Sep 2022 15:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com> <xmqqa67h8zac.fsf@gitster.g>
In-Reply-To: <xmqqa67h8zac.fsf@gitster.g>
From:   Julia Ramer <prplr@github.com>
Date:   Tue, 27 Sep 2022 15:56:20 -0700
Message-ID: <CADq8SzUUoi6=6ggxkeTUf2y0WmeAMMjuq8_OCej0smF7OabPiQ@mail.gmail.com>
Subject: Re: [PATCH] embargoed releases: also describe the git-security list
 and the process
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, git-security@googlegroups.com,
        Julia Ramer <gitprplr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taking these responses one by one:

All of Junio's edits and call-outs are reasonable and I'll incorporate
them into the next version.

Julia
(she/her)

On Fri, Sep 2, 2022 at 10:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Julia Ramer <gitprplr@gmail.com>
> >
> > With the recent turnover on the git-security list, questions came up how
> > things are usually run. Rather than answering questions individually,
> > extend Git's existing documentation about security vulnerabilities to
> > describe the git-security mailing list, how things are run on that list,
> > and what to expect throughout the process from the time a security bug
> > is reported all the way to the time when a fix is released.
>
> Thanks for writing this down.
>
> > +- Once the review has settled and everyone involved in the review agrees that
> > +  the patches are ready, the Git maintainer determines a release date as well
>
> s/maintainer determines/& and others determine/ or "stakeholders
> discuss and agree on".  You might want to mention that the schedule
> for disclosure and release tend to be constrained by so called patch
> Tuesday, which is the least flexible among various binary packagers.
>
> > +- Subsequently, branches with the fixes are pushed to private repositories that
> > +  are owned by the Git project, with tightly controlled access.
> > +
> > +- The tags are created by the Git maintainer and pushed to the same
> > +  repositories.
>
> Between this point in time when the tags are prepared and release
> materials are made available to packagers and ...
>
> > +- Less than a week before the release, a mail with the relevant information is
> > +  sent to <distros@vs.openwall.org> (see below), a list used to pre-announce embargoed
> > +  releases of open source projects to the stakeholders of all major Linux
> > +  distributions. This includes a Git bundle of the tagged version(s), but no
> > +  further specifics of the vulnerability.
>
> ... the time when we start to disclose to a bit wider audience, is
> when binary packagers are expected to prepare updates for their
> users.  So ...
>
> > +
> > +- Public communication is then prepared in advance of the release date. This
> > +  includes blog posts and mails to the Git and Git for Windows mailing lists.
>
> ... the following two bullet items are better written before the
> "Less than a week before...".
>
> > +- The Git for Windows maintainer prepares the corresponding release artifacts,
> > +  based on the tags created that have been prepared by the Git maintainer.
> > +
> > +- Git for Windows release artifacts are made available under embargo to
> > +  stakeholders via a mail to the `git-security` list.
>
> It also is probably a good idea to avoid singling out GfW too much.
> Folks who package Git for macOS, BSD, Debian etc. are all expected
> to work on the same timeline.
>
> > +- On the day of the release, at around 10am Pacific Time, the Git maintainer
> > +  pushes the tag and the `master` branch to the public repository, then sends
> > +  out an announcement mail.
>
> OK.  Thanks for being explicit about 10am Pacific.
>
> > +- Once the tag is pushed, the Git for Windows maintainer publishes the
> > +  corresponding tag and creates a GitHub Release with the associated release
> > +  artifacts (Git for Windows installer, Portable Git, MinGit, etc).
> > +
> > +- Git for Windows release is then announced via a mail to the public Git and
> > +  Git for Windows mailing lists as well as via a tweet.
>
> Ditto for various distro packagers.
>
> > +- A mail to <oss-security@lists.openwall.org> (see below for details) is sent as a
> > +  follow-up to the <distros@vs.openwall.org> one, describing the vulnerability in
> > +  detail, often including a proof of concept of an exploit.
> > +
> > +Note: The Git project makes no guarantees about timelines, but aims to keep
> > +embargoes reasonably short in the interest of keeping Git's users safe.
>
> ;-)
>
> --
> You received this message because you are subscribed to the Google Groups "Git Security" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to git-security+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/git-security/xmqqa67h8zac.fsf%40gitster.g.
