Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41C391F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 09:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbdBBJcm (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 04:32:42 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37258 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdBBJcl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 04:32:41 -0500
Received: by mail-wm0-f50.google.com with SMTP id v77so78944352wmv.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 01:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=4YUBMHZKg4gnmV+Sy/uugL25tbezbAth03LhmeLjU5s=;
        b=l1629nTLaBmkQ2IRE00HQdwZJ4Qe4B2pJRrGWIAqoLk24AWQ6xKUFFG6SChC3Kq8f4
         mPqIpXAJVbSFVA5lBI2J0F716tRnogeL/5gxUhW4BFJAo5WPGCVsiKB4NCRDvnoz3Q8r
         fxznbJnVCCEvfYVhpFy62BielKoPJWsttucP1fqn1gpJNJPYU0y4jxXtRkOkALvT3Ot4
         p+fkiobXs2ESkUAaujIHNpS+lJc3hiwLgCjyuBsEzc8UiWX/9mczmB/jUyBEIo2Woizd
         Ut6KFXvxVFt1xpnPNzvfEMJy/1Wz6z6t8ovVoh7Mjr6bwBsH8ldjO/OOppJmqjZvCtke
         dDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=4YUBMHZKg4gnmV+Sy/uugL25tbezbAth03LhmeLjU5s=;
        b=FN9fRzLGx9cY+48mFGe7oalAleznf5VIC7F4t3c7YFD0ncTKzdocVt8aySOZHt1gMW
         MRdESmar0QJ1WHJPg3bDS3bOSghxd7plvRGLaCduBZBoOsAMFQ47wy0I+cGZycXeesKs
         wvWi27qwyfHngRXL+D+J7rgClLaORSB3M8Dr7n6G88nxpWGvsRBQUNeaj5ObWqxwwwy4
         1zSZyov9BWrm4SIrFIOSxqJ7qe7QV8vr6ZjMBwFDScw05wJxbEkS49kMh9jnwJ0o090N
         KPmqqDouPoZHvDIgInU+LIuWTSSUqv0/AIGKhd5TINmmmXjpCxoQuzrpHJbo9SH1Yr3K
         PG+g==
X-Gm-Message-State: AIkVDXJAYQFXvU/2bz4KmAwwx7H1UkDEzfI4ssT7KFMZE5bL5cPV4hPr2B8YUFszn0BKv8f1jmiX9CEyUpAzzzKg
X-Received: by 10.28.23.66 with SMTP id 63mr6845497wmx.46.1486027959879; Thu,
 02 Feb 2017 01:32:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.49.137 with HTTP; Thu, 2 Feb 2017 01:32:39 -0800 (PST)
In-Reply-To: <CAKoko1q=6agpGsABxy8rmm6sGFWx9gE_c1j44h4M=yJ3r4JJBQ@mail.gmail.com>
References: <20170201230753.19462-1-cornelius.weig@tngtech.com>
 <xmqqinotmrhe.fsf@gitster.mtv.corp.google.com> <CAKoko1q=6agpGsABxy8rmm6sGFWx9gE_c1j44h4M=yJ3r4JJBQ@mail.gmail.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Thu, 2 Feb 2017 01:32:39 -0800
Message-ID: <CAKoko1rvxLWi+WgEnQEnzjhMpSe1-f_jXQcDT=ALWDHcj1RnmQ@mail.gmail.com>
Subject: Fwd: [PATCH 1/2] doc: add doc for git-push --recurse-submodules=only
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks good to me!  Thanks for writing the documentation.  I really
need to be better about getting documentation done at the same time
I'm adding features :)

-Brandon

On Wed, Feb 1, 2017 at 3:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> cornelius.weig@tngtech.com writes:
>
> > From: Cornelius Weig <cornelius.weig@tngtech.com>
> >
> > Add documentation for the `--recurse-submodules=only` option of
> > git-push. The feature was added in commit 225e8bf (add option to
> > push only submodules).
> >
> > Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
> > ---
> >
> > Notes:
> >     This feature is already in 'next' but was undocumented. Unless somebody reads
> >     the release notes, there is no way of knowing about it.
>
> Good eyes; the topic bw/push-submodule-only is already in 'master'.
>
> Looks good to me; Brandon?
>
> >
> >  Documentation/git-push.txt | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> > index 8eefabd..1624a35 100644
> > --- a/Documentation/git-push.txt
> > +++ b/Documentation/git-push.txt
> > @@ -272,7 +272,7 @@ origin +master` to force a push to the `master` branch). See the
> >       standard error stream is not directed to a terminal.
> >
> >  --no-recurse-submodules::
> > ---recurse-submodules=check|on-demand|no::
> > +--recurse-submodules=check|on-demand|only|no::
> >       May be used to make sure all submodule commits used by the
> >       revisions to be pushed are available on a remote-tracking branch.
> >       If 'check' is used Git will verify that all submodule commits that
> > @@ -280,11 +280,12 @@ origin +master` to force a push to the `master` branch). See the
> >       remote of the submodule. If any commits are missing the push will
> >       be aborted and exit with non-zero status. If 'on-demand' is used
> >       all submodules that changed in the revisions to be pushed will be
> > -     pushed. If on-demand was not able to push all necessary revisions
> > -     it will also be aborted and exit with non-zero status. A value of
> > -     'no' or using `--no-recurse-submodules` can be used to override the
> > -     push.recurseSubmodules configuration variable when no submodule
> > -     recursion is required.
> > +     pushed. If on-demand was not able to push all necessary revisions it will
> > +     also be aborted and exit with non-zero status. If 'only' is used all
> > +     submodules will be recursively pushed while the superproject is left
> > +     unpushed. A value of 'no' or using `--no-recurse-submodules` can be used
> > +     to override the push.recurseSubmodules configuration variable when no
> > +     submodule recursion is required.
> >
> >  --[no-]verify::
> >       Toggle the pre-push hook (see linkgit:githooks[5]).  The
