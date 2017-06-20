Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE9120282
	for <e@80x24.org>; Tue, 20 Jun 2017 17:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbdFTRUs (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 13:20:48 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34577 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbdFTRUr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 13:20:47 -0400
Received: by mail-pf0-f176.google.com with SMTP id s66so72261659pfs.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5tpjh4ZcJkEGk9L/ZJigQkgYtcCenTbQK05vdl7zjEY=;
        b=BJJfbzbi0eHLOrt6CqqXocyDQsoSy9LgC15LBIBCkfO8on//z0FzuyTV76kFmqaFUO
         xgDW1mm8EFOqNo39S+16owcFHVoaY3z+iXnYFgYZMSG8JdIsvUdRAjNJDQYmB57t723w
         qEdv+ACYgItpa/CwW2yWjLGfb/4U8ObfRvrLcyhqGJS7vEdklzWji265LmJOMbyuHA5n
         +62n05UEIdt43RIoBr9DXeef6+tvQa9ll+BSeUFeo5ljrPGTLx448Zcohb+32cDzSqL0
         i0bnpLCUWCpsz6t1G3YrawsjtIQplaxx3C0Ru+IpwrNGvNe02iohKH1Y6/yZIkh5gQSA
         jToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5tpjh4ZcJkEGk9L/ZJigQkgYtcCenTbQK05vdl7zjEY=;
        b=XRewFSuBuV5CJDfMVnHvrEKrT7t185gDlZ/EHY/ZS+enXh7cGLzjay2QmjXhVutgaG
         WtXx3GQYQ5c6bD7qKdrbeB2p1p+Xpm+mOIVi2nbD37DtDHk5jvPCFKp7DNLV/W7f8r34
         AJqog8bviQp4/0i+JwFv/W/NtHA9KNy8Dwd2QogVUkbJ8Gpsi9IeW6fI0MX9xEc1ahe4
         XJ3X4kzwTPNq7KVH6Y8tfXYAd0G41F1v6CNQOrDK6ipD+lUjChx7Ul8/tFWxTHbnQ/FD
         S2jHOrpxe7rDkFeoLN/qZJ8aoa0wPTchKHYSapWCN1Vh/3FhY3uY0KQ60vvVvMcJ6DPD
         Ajqw==
X-Gm-Message-State: AKS2vOyEcNYVFcELFVKMnoOMBcAKhboNI8pO5/w4Ix9XERjrAR9zw1Vu
        GUhrn3Ex7t0C5R5yX+G2RBlDZ37FZ3VJ
X-Received: by 10.98.49.2 with SMTP id x2mr11468177pfx.48.1497979247096; Tue,
 20 Jun 2017 10:20:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 20 Jun 2017 10:20:46 -0700 (PDT)
In-Reply-To: <20170619215025.10086-1-pc44800@gmail.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
 <20170619215025.10086-1-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Jun 2017 10:20:46 -0700
Message-ID: <CAGZ79kb7XTbJ5wHhRwXKURDU3xj_3mHFFmjxS1G_T2X_BoG=dQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/6] dir: create function count_slashes
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 2:50 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Similar functions exist in apply.c and builtin/show-branch.c for
> counting the number of slashes in a string. Also in the later
> patches, we introduce a third caller for the same. Hence, we unify
> it now by cleaning the existing functions and declaring a common
> function count_slashes in dir.h and implementing it in dir.c to
> remove this code duplication.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> The complete build report of this is available at:
> https://travis-ci.org/pratham-pc/git/builds/
> Branch: All-patch-series
> Build #111

This patch was sent separately a couple days ago, see
the latest "What's cooking in git.git" (Jun 2017, #05; Mon, 19)
https://public-inbox.org/git/xmqqh8zbspm7.fsf@gitster.mtv.corp.google.com/

  * pc/dir-count-slashes (2017-06-12) 1 commit
    (merged to 'next' on 2017-06-19 at 57351a2771)
   + dir: create function count_slashes()

   Three instances of the same helper function have been consolidated
   to one.

   Will merge to 'master'.

so if you pull Junios git and rebase on top of his master branch
this should be already included there. (In that case there is no need
for you to carry this patch. It is just cumbersome for you and might
confuse Junio, which patches exactly to apply)

Thanks,
Stefan
