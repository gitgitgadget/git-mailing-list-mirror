Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376761F404
	for <e@80x24.org>; Thu,  5 Apr 2018 21:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeDEVd3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 17:33:29 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36210 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeDEVd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 17:33:28 -0400
Received: by mail-qk0-f177.google.com with SMTP id o205so27972026qke.3
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 14:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=aCL2J+xgvQ85e7WL+3Nu2Lk8g/8FxKATfY6LIxVslCo=;
        b=ttx8YQb4nwyHiVP0gc+DkwRuSiUHZAlFCVdvHPZPuUAy6I9mlVbvqXCuDvdl8E0Mbp
         ZzUtOue1HQCXEVUwt1h79SFgyXHByq2XiyMauQX2nzzorejjYfdVSsnhEJO4o8W9Sf1w
         6O7sh9r81v9WwLdZb10Q+mFEVJ85eq5McGqTUxGerInkIidZKL/kfJy/+wDx4dbPUzN8
         ZwQkJJYCQf+LF1QYutF25qp7/XvT0FnZ2V0JEpUetCSRA5LBlRpmTofSTxDFulOkyVSl
         DR7jZfVchdhdhPlgk87KLdmNabjv30N5cyzQSpUUhUoOilj/sZKq7rCCaH24WAiUgCC8
         qENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=aCL2J+xgvQ85e7WL+3Nu2Lk8g/8FxKATfY6LIxVslCo=;
        b=F62SMm+TuQ6z9dYzu5huAedqCCuqQyozGU8VKuvEDB7X9DrSdqqe5hZSt7g3Vo5sdV
         lZ0cZETFdBtG1ld/ushBNOIv+XrqYLyeJtpwNIl4R7r93fz+b/TXKaNoWx1mwgMZK1hm
         CQwQlBmKISvP6nvx6SaREG5wZnPiaBZtty1Q2NXPus4C1ko6tQmQmmEpv5k8Tujq1W9Z
         +dWi321Ev2Z3rX87/dndilrl2SIdz9C1V1VWOrwJkeY0x1rAYX38lI7v9jd+kNpIkcs3
         Dln0wRRejazmGgKFUEBF/HZPQNhJ+lMTU5Kx3f+8YbErN2VAZZOq3I5G/SzqSvWA2D/F
         scvQ==
X-Gm-Message-State: ALQs6tDuQEA9O854DUd3GiGXYBMuP9aDxkQ5mE7Wv/HPt0z2fyD3813x
        w0cceUnyG9XA37TqutQU1PR3WxJHEDYjKHhZ7GE=
X-Google-Smtp-Source: AIpwx49MJLPqNjhNhfqOnj6yQYuD+XKNdsFWNZCfdEbkeDxwl/hV/SAn1mdlLZT0C3+G0849ZNdxjgwMb9QV6sydJ+U=
X-Received: by 10.55.108.69 with SMTP id h66mr32076394qkc.42.1522964007827;
 Thu, 05 Apr 2018 14:33:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Thu, 5 Apr 2018 14:33:27 -0700 (PDT)
In-Reply-To: <CAKk8ispGB2cxCxVpmabf7ASU3bSTLdMPbSQeAdYNom_JL=O0Bw@mail.gmail.com>
References: <CAKk8ispGB2cxCxVpmabf7ASU3bSTLdMPbSQeAdYNom_JL=O0Bw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 5 Apr 2018 17:33:27 -0400
X-Google-Sender-Auth: 3PXXvMMNbqVnudVkYm-_JnXhbks
Message-ID: <CAPig+cT6wq3=0ychBH9+YharVvX8KNFLStdb8wGG33o_Lungyg@mail.gmail.com>
Subject: Re: Errors testing on macOS High Sierra version 10.13.4
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 4, 2018 at 1:06 PM, Wink Saville <wink@saville.com> wrote:
> I built git on a mac osx laptop and got some errors when testing.
> I ran ./ci/run-build-and-tests.sh and three of the tests had failures
> that appear to be associated with character encoding:
> ...
> Of course on travis-ci there are no failures so I dug deeper and found
> that travis-ci is running 10.12.6 (I added a call to system_profier in
> ci/run-build-and-tests.sh) where as I'm running is 10.13.4:
>
> Not sure, but maybe I've got something configured incorrectly.
> Suggestions anyone?

I'm still on 10.12.6 and I don't plan on upgrading, so you may need to
dig into this yourself.

Try narrowing down the problem to the exact command within the test
which is failing or giving unexpected results. From there, it may be
possible to identify some difference between 10.12.6 and 10.13.4 or
between something in your current configuration and that on Travis or
elsewhere.
