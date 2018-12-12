Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SUBJ_ALL_CAPS,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D7120A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 22:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeLLWfX (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 17:35:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35441 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbeLLWfX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 17:35:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so427554edx.2
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 14:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39jQvt/ttGOCYPFqPVY+BXmV4K/eYQzcCWIqyCyUwYw=;
        b=NQVKLKfW5RuvRvH3Ys8pE4tP0mtP/1Kj3dzaR+AvSXrAPEPQDp+SNEMaF1estMghi0
         uonW4tPcYXeN5JhvtKSwTBXtsas8k357BeMV9AP3a9YZMIFwj5hxpsRT2NzWEMD7NeUo
         IatUPNfb2w8EBcm5fGqK+s29nK4Tt8byheeqgOwAaICkWYHAcKCjipLFLE8XAWiiQs4t
         Q4NOpBJgz6DEU9iEBesVyOo9DowIIN+rivvCu0M5/sfLzhXxypq2Zu4eZh4DevDGVE/6
         IbgaKHqiYDXiy7rcvihqXaYVvJqmdGH0pzozIiLzZWr948rKu3Qas7PBVlzWuiXjdgUF
         fsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39jQvt/ttGOCYPFqPVY+BXmV4K/eYQzcCWIqyCyUwYw=;
        b=JeNaPTg3Qk87mJyGeGaD9xQYI0XA/V/f5OwMzEnUHINQFfYT5EajZi1ZmguSNjbuuu
         X35VZdV713vnXe3mrZXjgPn+UhYrpsUinZH1h8w+/8B2XXCyl6CuTYnPaDW0RAezmnpY
         hmfXIgcrWw7xHhVDGF8ZZn9yiAyIDF0El1kJPyLfEHUbIADZtWF0AerfDM+IEhtSten8
         zO/O+AKsxofqsZ4lxNYIz5BoYGMIkfB4VirPCzjBmM+KGBxZcA8K20EpZepNRnTr6DS2
         7oehAospjbcOcuv6nhCoorq7rlVROUsSAlvaTrNEd56lAAd92ME4o0htMRfmM4Oim8P4
         QqGA==
X-Gm-Message-State: AA+aEWY0/LH3YPoSRw+hfr+kLdEt4U7moR0pDkOKp7FP4tlF3QMyqsXT
        l17bn9wt6DrOVXgV9e/in16SOjZvCPTJi7SNdMKvk1V669h3vA==
X-Google-Smtp-Source: AFSGD/XaIrmexEOoCuMSWdQ27saLb9DGoCPZwFlM07ZHheCcr74jbcMgVzZbZetRRBM5o/O019K6zxDCp3b3wFP2MZ0=
X-Received: by 2002:a50:8343:: with SMTP id 61mr20780775edh.154.1544654121528;
 Wed, 12 Dec 2018 14:35:21 -0800 (PST)
MIME-Version: 1.0
References: <20181207235425.128568-1-sbeller@google.com> <xmqqefas8ss4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqefas8ss4.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Dec 2018 14:35:10 -0800
Message-ID: <CAGZ79kbPQx4Z0FHioQWxUYoJOKU0TxZXgxEDPFE7XQCMxtRqaw@mail.gmail.com>
Subject: Re: [PATCH 0/4]
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 7, 2018 at 9:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > A couple days before the 2.19 release we had a bug report about
> > broken submodules[1] and reverted[2] the commits leading up to them.
> >
> > The behavior of said bug fixed itself by taking a different approach[3],
> > specifically by a weaker enforcement of having `core.worktree` set in a
> > submodule [4].
> >
> > The revert [2] was overly broad as we neared the release, such that we wanted
> > to rather keep the known buggy behavior of always having `core.worktree` set,
> > rather than figuring out how to fix the new bug of having 'git submodule update'
> > not working in old style repository setups.
> >
> > This series re-introduces those reverted patches, with no changes in code,
> > but with drastically changed commit messages, as those focus on why it is safe
> > to re-introduce them instead of explaining the desire for the change.
>
> The above was a bit too cryptic for me to grok, so let me try
> rephrasing to see if I got them all correctly.
>
>  - three-patch series leading to 984cd77ddb were meant to fix some
>    bug, but the series itself was buggy and caused problems; we got
>    rid of them

yes.

>  - the problem 984cd77ddb wanted to fix was fixed differently

e98317508c02*

>    without reintroducing the problem three-patch series introduced.
>    That fix is already with us since 4d6d6ef1fc.

yes.

>  - now these three changes that were problematic in the past is
>    resent without any update (other than that it has one preparatory
>    patch to add tests).

One of the three changes was problematic, (e98317508c02),
the other two are good (in company of the third).

But those two were not good on their own, which is why we
reverted all three at once.

Now that we have a different approach for the third,
we could re-introduce the two.
(4fa4f90ccd8, 984cd77ddbf0)

We do that, but with precaution (an extra test);
additional careful reading found a typo, hence
we have "a third" patch, but that is totally different
than what above was referred to "one of three".


> Is that what is going on?  Obviously I am not getting "the other"
> benefit we wanted to gain out of these three patches (because the
> above description fails to explain what that is), other than to fix
> the issue that was fixed by 4d6d6ef1fc.

The other benefit refers to
7e25437d35 (Merge branch 'sb/submodule-core-worktree', 2018-07-18)
which was reverted as a whole.
It's goal was to handle core.worktree appropriately.

(Instead of having it there all the time, only have it when
a working tree is present)

> Sorry for being puzzled...

This means I need to revamp the commit messages and
cover letter altogether.

Stefan
