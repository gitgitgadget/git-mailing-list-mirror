Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 870A71FAF4
	for <e@80x24.org>; Sat,  4 Feb 2017 11:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbdBDLgj (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 06:36:39 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34479 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754040AbdBDLgi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 06:36:38 -0500
Received: by mail-pg0-f68.google.com with SMTP id v184so4339999pgv.1
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 03:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lO5xvRvgcx6pFIN0g5SZBsMImelV3+b9b4Sxwlahbf8=;
        b=OzPFg3WnopWpoLJayKNcx7wH6pYO5lGtkSRcFcVuiwUc5TEU74M4nV5oyECJnYQptg
         tsGPByW+DGAcn4hP4cpoWeehTS+vQE8gHo0KJsNZtaZREWQW6kRnmkk5LArPVDELLwjy
         yxPSB53vM7MYcS8iw4WFduuw81MZCGd9it96FpJMA0/3L2qjKSs+7H8PAajiyTaSRkXk
         KV11OqifTrInt2QmGsllvARmMgZdUuGqkZK65zfmC4wjlTA5VL6lxIgVTEW0LiPSUXJV
         nHB8gToRKayqGH7bIq35oF2X81l2gAgusw822nkfOHsM1k8fp0AEp974xiO/ahiOtOkB
         LepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lO5xvRvgcx6pFIN0g5SZBsMImelV3+b9b4Sxwlahbf8=;
        b=WP0bWZNYGEE5A8W1V3Z7gHukBxGECcgSL6/+8fetow4zLBVyYtnJUm0cQMdsbdxuQv
         ePpYdQqxQVAZZz0tHRwWBprD+HncKtuM9pCkOgZsCuan03r/lZno5LMr1mzXpSZY3Z1/
         vsmgnskrHW039xtMCJiThH3K7WRMuWed7eYNuqIWEDUbIvIMHmARuY/SBEoXzVHS0Qdx
         hbRth94rzJUm4bWL/TwjPB1X4PYqd6A70So4UtPRs6WNkhuHYBY7YsP7+Ia9AlkmVo4C
         0b20ScoCrLIdTdnXV8iyb0fczfaNysxLMSw71nY0xRJc/WheraRCSmwhlbkdHR5DYKbh
         4f0Q==
X-Gm-Message-State: AIkVDXJtqsyCMfAEg9kdQCvUjimvNst+RBJUnCCeUyN1D2mWhbs0+X7GxcGY2+jjUCdxdA==
X-Received: by 10.99.95.216 with SMTP id t207mr2129602pgb.0.1486208197273;
        Sat, 04 Feb 2017 03:36:37 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id c11sm74493823pfe.68.2017.02.04.03.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Feb 2017 03:36:36 -0800 (PST)
Date:   Sat, 4 Feb 2017 11:36:34 +0000
From:   siddharth <kannan.siddharth12@gmail.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] parse-remote: Remove reference to unused op_prep
Message-ID: <20170204113634.GA27520@ubuntu-512mb-blr1-01.localdomain>
References: <1486195204-26901-1-git-send-email-kannan.siddharth12@gmail.com>
 <CAFZEwPPyJBD0a+Jkr7EBCurFzvHLvZY9r_SFWS2wyW7QmmP4pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFZEwPPyJBD0a+Jkr7EBCurFzvHLvZY9r_SFWS2wyW7QmmP4pg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 04, 2017 at 04:55:45PM +0530, Pranit Bauva wrote:
> Hey SIddharth,
> 
> > Subject: parse-remote: Remove reference to unused op_prep
>                                          ^
> 
> Minor nit: after the colon, we generally don't use the word starting
> with an uppercase letter which I think can be figured out when you run
> `git log -p git-parse-remote.sh`

Oh, I am really sorry to have missed this. I will fix this and send a
third version of this patch.
> 
> On Sat, Feb 4, 2017 at 1:30 PM, Siddharth Kannan
> <kannan.siddharth12@gmail.com> wrote:
> > The error_on_missing_default_upstream helper function learned to
> > take op_prep argument with 15a147e618 ("rebase: use @{upstream}
> > if no upstream specified", 2011-02-09), but as of 045fac5845
> > ("i18n: git-parse-remote.sh: mark strings for translation",
> >  2016-04-19), the argument is no longer used.  Remove it.
> >
> > Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
> > ---
> > Thanks a lot, Pranit and Junio for your reviews on the first version of this
> > patch. I have changed the messages accordingly.
> >
> >  contrib/examples/git-pull.sh | 2 +-
> >  git-parse-remote.sh          | 3 +--
> >  git-rebase.sh                | 2 +-
> >  3 files changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/contrib/examples/git-pull.sh b/contrib/examples/git-pull.sh
> > index 6b3a03f..1d51dc3 100755
> > --- a/contrib/examples/git-pull.sh
> > +++ b/contrib/examples/git-pull.sh
> > @@ -267,7 +267,7 @@ error_on_no_merge_candidates () {
> >                 echo "for your current branch, you must specify a branch on the command line."
> >         elif [ -z "$curr_branch" -o -z "$upstream" ]; then
> >                 . git-parse-remote
> > -               error_on_missing_default_upstream "pull" $op_type $op_prep \
> > +               error_on_missing_default_upstream "pull" $op_type \
> >                         "git pull <remote> <branch>"
> >         else
> >                 echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
> 
> I guess I suggested you to not change the file in contrib/ in my
> earlier email[1] and to which Junio agreed too[2]. Is there any
> confusion?

Oh, you want me to completely remove the contrib/examples/ change
because that's the old shell implementation. Got it, I just checked 
the log for that file and realised that it hasn't been changed 
in a long time.

> 
> > diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> > index d3c3998..9698a05 100644
> > --- a/git-parse-remote.sh
> > +++ b/git-parse-remote.sh
> > @@ -56,8 +56,7 @@ get_remote_merge_branch () {
> >  error_on_missing_default_upstream () {
> >         cmd="$1"
> >         op_type="$2"
> > -       op_prep="$3" # FIXME: op_prep is no longer used
> > -       example="$4"
> > +       example="$3"
> >         branch_name=$(git symbolic-ref -q HEAD)
> >         display_branch_name="${branch_name#refs/heads/}"
> >         # If there's only one remote, use that in the suggestion
> > diff --git a/git-rebase.sh b/git-rebase.sh
> > index 04f6e44..b89f960 100755
> > --- a/git-rebase.sh
> > +++ b/git-rebase.sh
> > @@ -448,7 +448,7 @@ then
> >                 then
> >                         . git-parse-remote
> >                         error_on_missing_default_upstream "rebase" "rebase" \
> > -                               "against" "git rebase $(gettext '<branch>')"
> > +                               "git rebase $(gettext '<branch>')"
> >                 fi
> >
> >                 test "$fork_point" = auto && fork_point=t
> > --
> > 2.1.4
> >
> 
> [1]: http://public-inbox.org/git/CAFZEwPMGTzVuLMSzm8wiNxvia4AV0T79C1ZTfcuO4=Bydz_zQA@mail.gmail.com/
> [2]: http://public-inbox.org/git/xmqqd1ey8rul.fsf@gitster.mtv.corp.google.com/
