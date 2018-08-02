Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 744061F597
	for <e@80x24.org>; Thu,  2 Aug 2018 21:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbeHBXZT (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 19:25:19 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44289 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeHBXZT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 19:25:19 -0400
Received: by mail-yb0-f195.google.com with SMTP id l16-v6so1876840ybk.11
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NWJ9c3we+rP90lkIDfI0o/DBiulqFixUiGyYKZ4CXGo=;
        b=Y/m4LngUWC/ruX4CDMJB+ttK+5ArQI/9+0Sz00aV/rsFp9XgfL3gTt5QX5tAJmihsf
         kRxletECnA0LTX4JOBRkWdd5dTuTdnf0jMBQF0zWTcym0A/OkQWmi28zFWzzNbNVxjDA
         DZ4QoKQRQMGupS7x6F4+/mIbq3H1lP8EPhnd2Q+X+ssa7SlXCW8Z3e9m1oT2MdSMQ2qt
         QPMUXZC/ZR503b4U9J4OjxwlUJgLzmYIt6DiQelRS80Vd6Dw2fFnnDxQQhlqwOFbfZEM
         hLLr55gqPQPE4JiGYgD30Ons7+pAZ1HlxT61Hf4x3badjO+lpSZ0+m3p22HGVIXizwrx
         NXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NWJ9c3we+rP90lkIDfI0o/DBiulqFixUiGyYKZ4CXGo=;
        b=PYH0ACpMGm2732SBTj+MUaqY0U/I/4YxTbCNjBx4GgRTKDENkDFhahBSUx5LEFJA6X
         ziaYF2ag3VcioSkhtfXAqsb3rQK86etd/zp37COfGGWrxlRJoGXmKMrehbJn6JIhSUKt
         1Rzm0rYI0UQz5uC4dD0K9Kf4ER05N7ybsqS6X1/RFptEY2K9MylM3A2f/I5Pl5x9rYtR
         /IurWObJeWISmjxKDo6SLuyUWzouD17XsutVJyT6E5aT3XTgNe80DBpPkgBBo4X+AlSW
         r+BEDpN2DWg6izr0oiHZRlFl1M+F68J0oEduZ5F6KXR6mnpfYGs8lMWlPm96Tk35prjz
         4nAg==
X-Gm-Message-State: AOUpUlFVbsdudaEBKYyxczaMVYt+Z9TbbSJD2GBuNA2Mra4zL1RVSiyb
        cCUQkAaBzJFI0/heI3/tRojFWT9QuH+UyyjzGtcbENHHAcCZjg==
X-Google-Smtp-Source: AAOMgpcamJLY8OA18dhK3tPlF0Xr6Dx9ZPYAzuG6vAWEsMG5P0GQuWvOy6vvY9yd/brRl7Tp3AWOQ64fOGS9FmkYcCw=
X-Received: by 2002:a25:3624:: with SMTP id d36-v6mr719068yba.292.1533245540597;
 Thu, 02 Aug 2018 14:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <87o9emtuf6.fsf@evledraar.gmail.com> <20180802205044.23631-1-avarab@gmail.com>
In-Reply-To: <20180802205044.23631-1-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 14:32:08 -0700
Message-ID: <CAGZ79kaS_YazchNG+N=gpwnewe+oSdwbdYusFMWpWygbrSqUQQ@mail.gmail.com>
Subject: Re: [PATCH] sha1dc: update from upstream
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        aixtools@felt.demon.nl,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Daniel Shumow <shumow@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 1:51 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:

> diff --git a/sha1collisiondetection b/sha1collisiondetection
> index 19d97bf5af..232357eb2e 160000
> --- a/sha1collisiondetection
> +++ b/sha1collisiondetection
> @@ -1 +1 @@
> -Subproject commit 19d97bf5af05312267c2e874ee6bcf584d9e9681
> +Subproject commit 232357eb2ea0397388254a4b188333a227bf5b10

Offtopic:
I wonder if we want to extend diffs a little here and similar to a diffstat
that is not technically needed, but rather aiding the reviewers eyes.
So maybe we could add a concise shortlog, e.g. after this line:

19d97bf5..232357eb (2 dots indicating it is a fast forward instead of 3 dot=
s)
3 commits from "Merge pull request #37 from avar/fixup-pull-request-34"
to "Merge pull request #45 from avar/aix-big-endian-detection"
