Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D14D1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 18:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfAIShN (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 13:37:13 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:44597 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfAIShM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 13:37:12 -0500
Received: by mail-wr1-f44.google.com with SMTP id z5so8675432wrt.11
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 10:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/Vy20cJkIEay4Cq/5u6PA+EV3UzdDFDPDHzd+6aIok=;
        b=XqE7BVBP98FhIzJkh6MW/MYysWBp1ivHISBYoRya8I3AwN/u70G+IBLUxpIjR1LZsG
         OWJ98i4uS6zkNU2lyxcYS/oRNSSpt/wEo9LmvxrPmI4yB+VgwTqrkMiWLw1fXQoiC4lA
         qaIPXPvNTQ8lrdOtiTGnb2s4zpwhblPxk3x3oYdIfvp/zmRBq/W1u0cfOAek2FcCcH3M
         rDs8j7jpRTeEeBcp7LpvQuzaD0s+GaUnVpYsYJDEZObaJu32CUm2ntSxF6lhKcLRcZIc
         rrubBQlWJ5c8GtEbnr0z1Nd489fKNhj0N+7nWZ59tR+unn31Bnk2/0l1RjkguLddMWcw
         dPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/Vy20cJkIEay4Cq/5u6PA+EV3UzdDFDPDHzd+6aIok=;
        b=Es4UnnEegGqvDtQQttaUoTqsAkpWc913X8uLi+eCZE1DuTcAkLCjRdHaWbWr5jHxLE
         k9vAWxhMJ01hVU50pHqlkrppA1HwzaCo7uInuJ0+W0gOCz/kU7d/KT5n7+OplBozPYcw
         pY4IzHbSqNcNE47pp7ekMzvb3gEinUD4YTGkCYW/8JqBsgKtuip5Q2aquTSUwqe//CXn
         dFcUmCMaeZjr9Szd5GTabIn9Fq3WS+zLUEVGEQVl2hikjlalBX8u5qm9PljIGhev1rSa
         Ad01U2RZil10qM8Ji/JXDp254QfmxPyVVWrL48Mu3+4hUchYCcSReDgbSe1IilCfbY2I
         tUVA==
X-Gm-Message-State: AJcUukffcqDdYVmRBxVEsLdPBa6Yygf5xaGOO0YBKNm+vNe2o1td8Cwk
        EvjY00RCUG9ELinKYtbAERKvw1lGa4edix+ApzRoIA6343g=
X-Google-Smtp-Source: ALg8bN6rAvhnsjumeAMrSm4abMXRI4ZKJUd30pva5BaNCdCKsTLeGP+BpwkCMGggGs8KoIjNlmgj4Lf6j8r+KFtYUXs=
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr5982470wro.35.1547059030690;
 Wed, 09 Jan 2019 10:37:10 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEBmh4LdN-XFS9y9YKrDMzV_7+QpDzBA2uv9Xi80PgR5NTQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901091922300.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901091922300.41@tvgsbejvaqbjf.bet>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Wed, 9 Jan 2019 10:36:59 -0800
Message-ID: <CA+dzEBn_-=77ZzfOaS8nVnQkf4rh0Y6TbEknZe6c02cwktrTJg@mail.gmail.com>
Subject: Re: git add --intent-to-add + git stash "Cannot save the current
 worktree state"
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 9, 2019 at 10:25 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Anthony,
>
> On Thu, 3 Jan 2019, Anthony Sottile wrote:
>
> > Minimal reproduction
> >
> > ```
> > git init t
> > git -C t commit --allow-empty -m 'initial commit'
> > touch t/a
> > git -C t add --intent-to-add a
> > git -C t stash
> > ```
> >
> > ```
> > + git init t
> > Initialized empty Git repository in /private/tmp/t/t/.git/
> > + git -C t commit --allow-empty -m 'initial commit'
> > [master (root-commit) 858132e] initial commit
> > + touch t/a
> > + git -C t add --intent-to-add a
> > + git -C t stash
> > error: Entry 'a' not uptodate. Cannot merge.
> > Cannot save the current worktree state
> > ```
>
> Apparently it is even worse. On Windows, this reportedly resulted in a
> segmentation fault:
>
> https://github.com/git-for-windows/git/issues/2006
>
> Could you cherry-pick the fix of
> https://github.com/git-for-windows/git/pull/2008 and see whether it fixes
> your use case, too?
>
> Ciao,
> Johannes
>
> P.S.: Obviously, if this PR fixes the issue, the corresponding change
> should be squashed into the appropriate commit in ps/stash-in-c.

I don't see a `stash.c` in ecbdaf0899161c067986e9d9d564586d4b045d62 --
the patch doesn't appear to apply

`stash` appears to be implemented as `git-stash.sh`

Anthony
