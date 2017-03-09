Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B358202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 17:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbdCIRss (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 12:48:48 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35813 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932542AbdCIRsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 12:48:46 -0500
Received: by mail-pf0-f172.google.com with SMTP id j5so31335311pfb.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 09:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BQ65YmXrbFz1tIZPZq+pFpeAxxSnn6qpbl862QzFncs=;
        b=SAnpSuAJfCS9JFvan3CLfalk4P8dsqGaXnlcG7q8irueIHa7rk4rFmWRPDPoNPYx5o
         8arxanRaFMX9xWf2MPOMoHCyUG9ob7n3wFUiH8Qj2iMF2DhXugn0JKWJ6DSbrAIPCj7W
         U2SQKyr+NX9QayPAO/L8mdwzR07ii3Q9wEhmzfNCYu3ehOFnvGuYVGjRjdyfSigmJsX6
         KMsdLPhizGIb7BdLuw2PVqXlLfskBtSFC+pp5Ay0e/LAAVsrb8Kn3nKs12lXwLgATGKj
         tXWOFstPJ0rHwXEvF5OWb22SAgveAdYXYzcyK1n0pnaiPsVD4sHwVuH0D97HWbltRGDt
         BQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BQ65YmXrbFz1tIZPZq+pFpeAxxSnn6qpbl862QzFncs=;
        b=Ct3ftWIV6nXFxgoeJsSnnb5Q9wkCuj8JRrrs024T+grB9cfTIoU4RWH6BLDPz1PQei
         gltqp1mFo8DyPA4tXlgsQHHtgJpXEF37Xw9D4M5PemQIfE3SQrK9Sx+O9gTuX2gfseek
         gQmTTESgD64yLQ5710F9OEMFspEetqCzB38hNkl28ONkHD9sOXXzj+VtGJHNtsJK6GfH
         UMu54MJE1D5cG6yvh3nBg/vmpyKqiklr+8K1MyNyU4hvoeSvnMBq4TIaKqcEaBZa4DSX
         7yxVcOwT2bV2KBvCS0ijRPEtJwPOm47l+N1Hl+ArmlAY7kPC3KcbS60O97HfgM/6o4WR
         z4Cg==
X-Gm-Message-State: AMke39mDwA8iAVQ2e5SotaoqHNXlY4dBr1MKLAEZNhEk1dgERbz7dUHEJaucHgFlME1u2TQCyLlR6bd0gPTXMX0r
X-Received: by 10.99.178.9 with SMTP id x9mr14844584pge.48.1489081632861; Thu,
 09 Mar 2017 09:47:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Thu, 9 Mar 2017 09:47:12 -0800 (PST)
In-Reply-To: <0102015ab11ee091-f9f11bb5-559a-4c92-b5f6-9f7755e8f4b9-000000@eu-west-1.amazonses.com>
References: <0102015ab11e8237-01e52ffe-882f-4589-8886-2c0b231ac3c6-000000@eu-west-1.amazonses.com>
 <0102015ab11ee091-f9f11bb5-559a-4c92-b5f6-9f7755e8f4b9-000000@eu-west-1.amazonses.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Mar 2017 09:47:12 -0800
Message-ID: <CAGZ79kYUkQ4u9zX=qXL_+ip74mi3DgbzGiJNxybrVYbr3m1U=A@mail.gmail.com>
Subject: Re: [PATCH GSoC] Allow "-" as a short-hand for "@{-1}" in branch deletions
To:     Shuyang Shi <shuyang790@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Welcome to the Git community!

On Wed, Mar 8, 2017 at 7:31 PM, Shuyang Shi <shuyang790@gmail.com> wrote:
> The "-" shorthand that stands for "the branch we were previously on",
> like we did for "git merge -" sometime after we introduced "git checkout -".
> Now I am introducing this shorthand to branch delete, i.e.
> "git branch -d -".
>
> More reference:
>   https://public-inbox.org/git/7vppuewl6h.fsf@alter.siamese.dyndns.org/

Following that link:

> But there is a very commonly accepted long tradition for "-" to mean
> "read from the standard input", so we cannot reuse it to mean "the
> branch I was previously on" for every command without first making
> sure the command will never want to use "-" for the other common
> purpose.

This contradicts the introduction of "git branch -d -" to mean to delete
the last branch, but rather could mean "read from stdin which branches
to delete"? It would be nice if you could clarify in your commit message
which of both this is and how this fits into the big picture of "design
cleanliness".

>
> And this has been tested:
>
>         Ivan:git Ivan$ (cd t; prove --timer --jobs 1 ./t3200-branch.sh)
>         [00:21:26] ./t3200-branch.sh .. ok    12293 ms ( 0.04 usr  0.01 sys +
>         5.97 cusr  2.52 csys =  8.54 CPU)
>         [00:21:39]
>         All tests successful.
>         Files=1, Tests=113, 13 wallclock secs ( 0.07 usr  0.02 sys +
>         5.97 cusr  2.52 csys =  8.58 CPU)
>         Result: PASS

Thanks for being cautious when developing on Git. However this part
of the email would end up as part of the commit message. And as we expect
all commits that land eventually to not break tests, this information is better
put at a more non-permanent place, such as below the '---' line (where there is
also the built stat. For example see [1] how to have different message parts
(one permanent section and some chatter that is relevant for the process
at the moment)

Also for testing, the tests only ensure that the old behavior does not break;
but we'd want to make sure the new functionality doesn't break in the
future either,
which can be done best by writing a test as well for this functionality.

[1] https://public-inbox.org/git/xmqqvarj1kix.fsf_-_@gitster.mtv.corp.google.com/
and as a commit:
https://github.com/gitster/git/commit/83218867fbf6d27c78efe3cfba01790b2f1d15d4

> https://github.com/git/git/pull/337

Oh I see, you're using submitgit to communicate the patch to the mailing list.
I am not sure if it supports splitting up the message as I eluded to above.
IIRC some people use submitgit for the patch and then use a webmailer
(e.g. gmail) to send followup messages such as successful tests or what changed
to prior versions.

Thanks,
Stefan
