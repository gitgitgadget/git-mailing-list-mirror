Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8E91FD09
	for <e@80x24.org>; Mon, 29 May 2017 01:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbdE2BgM (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 21:36:12 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38211 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE2BgL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 21:36:11 -0400
Received: by mail-it0-f49.google.com with SMTP id r63so20088399itc.1
        for <git@vger.kernel.org>; Sun, 28 May 2017 18:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3AOUfhgdQLDC+uw6IL4/guiBUIXsQewNIyRkgLjfe8w=;
        b=I7XIILcA6u/YvmNjHqVUo1/BwAlZiuag3hVoGaiOqHHOlp1MhLtuL01Nc7b6/NCY8U
         VmdaHxS44kMxpQCsyjlg+hSf9mG5ZQSOHE5JRHtJIPCnVKhom4u8w4/TAyQtaGbruBdP
         czmcU4iN/oMCUCZ4Q26M2NeUOdvUlhyJO8P+q3ovSs5onmFK/+zyuuJiLtTv1fhLXU4u
         PwPhIbSbMBpjEIio7NKbtLed3rtHRDt6BvKOz4sl17IIRm6SGa+1hRqAolaWtpIOzERP
         /FPsUdlxUGlmoZTICpN6WHY2AQ8t0fiPzOTNk7D16pevA70RzLAmK2oQMVC4xE7JTfFv
         K6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3AOUfhgdQLDC+uw6IL4/guiBUIXsQewNIyRkgLjfe8w=;
        b=ivFOxU48q1MQkg07hYAPAyoTg8OdaVBa7sJPXyu36zn738yBKV50EmjkytKbHrgbYs
         TZ+RCPQ7HKzNkOm6FeAa3Kp1CvsBDlGZtXtpWEE/WuW3Oqv3IFY5FmbrWHNvi1ehfdEp
         LrmPt1wKPw4jqepEuI32oCjThjiX4jQ0zMSQUpTcTBBhQiYouFX2ryvAUJoTVgjzjm50
         dIQw+0Xk+GrFpEO4UcyG/zjWB4/lYN+VAf/Yj4CvXNBnLDi8IV3zWNAfMTqoYSM4qPkB
         d7crHSVmeu8vW/eFQTFBXfpStSx5knQxPTjLLpJO+vX0AS4mFtsApczJv+LkaJjxu4go
         Tb6g==
X-Gm-Message-State: AODbwcALZTRMLzOtkTdcQpznSPiJ1auzPhyFh12/RkB2dWew/6Gxh2+3
        uDyfvEu+02elry+cqPO+SMYauaQOyw==
X-Received: by 10.36.66.67 with SMTP id i64mr28094151itb.22.1496021770757;
 Sun, 28 May 2017 18:36:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Sun, 28 May 2017 18:35:30 -0700 (PDT)
In-Reply-To: <20170526183702.jrjkykhldz74pquq@sigill.intra.peff.net>
References: <20170526173654.4238-1-asheiduk@gmail.com> <20170526183702.jrjkykhldz74pquq@sigill.intra.peff.net>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Sun, 28 May 2017 21:35:30 -0400
Message-ID: <CAJZjrdVjeeHUN_biza-MA9iqP5Y5CO3DkLaGG-Bq1w5oo5tW_g@mail.gmail.com>
Subject: Re: [PATCH] doc: filter-branch does not require re-export of vars
To:     Jeff King <peff@peff.net>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 2:37 PM, Jeff King <peff@peff.net> wrote:
>
> On Fri, May 26, 2017 at 07:36:54PM +0200, Andreas Heiduk wrote:
>
> > The function `set_ident` in `filter-branch` exported the variables
> > GIT_(AUTHOR|COMMITTER)_(NAME|EMAIL|DATE) at least since 6f6826c52b in 2007.
> > Therefore the filter scripts don't need to re-eport them again.
>
> Some old shells keep separate values for the internal and exporter
> versions of variables. I.e., this:
>
>   foo=one
>   export foo
>   foo=two
>
> would continue to export $foo as "one", even though it is "two" inside
> the script.
>
> However, I think POSIX mandates the behavior you'd expect. And the only
> shell I know that misbehaves in this way is Solaris /bin/sh, which we
> have already declared too broken to support.

Off-topic, but where is this explicitly documented?

> According to
>
>   https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Limitations-of-Builtins.html#export
>
> it sounds like there are some other antique shells which may do the
> same (it doesn't cover this case explicitly, but the "coexist" cases it
> mentions are likely to behave in this way).
>
> At this point, I'd be inclined to remove the text as you suggest and
> either make a small note at the bottom of the page, or just omit it
> entirely and assume that anybody on an old non-POSIX shell can fend for
> themselves.
>
> -Peff
