Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A15520987
	for <e@80x24.org>; Fri,  7 Oct 2016 18:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754680AbcJGSeS (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 14:34:18 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33322 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753430AbcJGSeR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 14:34:17 -0400
Received: by mail-qt0-f178.google.com with SMTP id s49so25071474qta.0
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ii/FL1c/yQykP56TCAEbJgN8twYcd0Dgi038LzURYBo=;
        b=UL4HNSI7ZL2zylCYiDb6MRFxWB/OKx7+jegbOvt8eiVHE7igo5LweLjbZegMsj97pw
         TcnznOO/0Bp/e3SQu8wftED3N6Cfz6I8ipT+RNUjl1Y6+l/+PO57hCAhesvNi2tJbG8+
         pnB6pS1b2sAJQJFam9/X//QYn58knIkUVkbKCS5kG0SlEIYcBZLVJXuJpoADwRDliIVD
         vky4aQadl1O38c8W80cASp1vFM5orkFRWyoXxXbp0jRElukf2Bxs17a2sCLiTPJ+Embp
         Pw3/kVLCkHbCk9/nl2neX2bCxff25tqfQxvZT08SJpx8XcxgtBlMiymjrddrY8p44k8m
         QUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ii/FL1c/yQykP56TCAEbJgN8twYcd0Dgi038LzURYBo=;
        b=KYMguXnuFMLlgTix7M/K+bMrp5xIUowme+A1Plj03/ycVb+tatqXweqvUf4haqVASu
         EchreaapdTFQ25tWMggJFaVQt3UlW11R48dTwUHNOAf0ksA3EAD4kltra+cWJm0b9Ezh
         scIvzUamYR49CnEkc1Qb6lEj2Qv+KfSGQCL8AXKSMxvrEggo0Lasq91MNiv4dqqoOjcO
         N5oUB7BHqkqlqzg0hcDunqPo8YXxV73cJch7t1n5KQD7IjYBSyLdaxguB07Q0VgxSm5E
         Rz4EsbMnVe87fRpglj08L+hOaZYQ9XFuiI40WNIm2Ap8frMGkm/rRYWkrnWkA0YXROQs
         MWsA==
X-Gm-Message-State: AA6/9Rm8kHcZXVrZgtpr3y1q8s7VfqYjMv8bqdXDDrr4G5qji/DVvlasfc7RpnSt9Nj4+mYOzzAWXQsO8O7MjZqX
X-Received: by 10.200.34.6 with SMTP id o6mr8493769qto.88.1475865250892; Fri,
 07 Oct 2016 11:34:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Fri, 7 Oct 2016 11:34:10 -0700 (PDT)
In-Reply-To: <20161007181851.15063-1-bmwill@google.com>
References: <1475185723-36871-1-git-send-email-bmwill@google.com> <20161007181851.15063-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Oct 2016 11:34:10 -0700
Message-ID: <CAGZ79kacgsPg-dzx7JRyhA2bq9JMb2Cyg9PjWbnKi9ZMTPw7RQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] recursive support for ls-files
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2016 at 11:18 AM, Brandon Williams <bmwill@google.com> wrote:
> Few minor fixes pointed out Stefan

Nit: This is not very informative, so you could provide an "interdiff"
to the last patch, (see https://github.com/trast/tbdiff for a
sophisticated tool,
I usually do a git diff origin/sb/<what-junio-queued>)
That helps reviewers as they do not need to review it all again, but
they may remember what they annotated and see how you addressed it.

Thanks,
Stefan
