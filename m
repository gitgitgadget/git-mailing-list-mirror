Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F93021841
	for <e@80x24.org>; Mon, 30 Apr 2018 11:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeD3Lac (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 07:30:32 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:53290 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeD3Lab (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 07:30:31 -0400
Received: by mail-it0-f51.google.com with SMTP id f65-v6so5364297itd.3
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 04:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=HskT+RuB5LtrKDD5U3TKyD1jfQRVZ8ZUrCpUDCa07DA=;
        b=sxLAIAQJ+yEjkghZvptHWX2X7PwuHwwt6l28NmGDZyjiVBobRJR97JFsjWudGHs0lz
         HhpIDC1bb+3gZ9ruX8Z2rHnDpVjswIcCesGcfkOvximbjSR+bMs3lseB5EJ7y4mYHbGn
         5sLky0rf3oJyYrZKirNU25qfu6/e8zXnq4QYgzAURi2kSGZ7qvEux6CJZ8JuXjcLR1MN
         oXxZt0K0WhfYCNkKrHGjUc8l/9wJTq0FH5uTImaRMn/tapj3prKo/mLZG73ZwvVm+e6V
         us0kaWB5dV+hsUlaDc70H2lkuEFnt83U3bNyn+YifCIjsQ/KNoBaMU/KzX0Hz8Crxg2l
         WYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=HskT+RuB5LtrKDD5U3TKyD1jfQRVZ8ZUrCpUDCa07DA=;
        b=NkkBdWt+hmfv/svafXrZ5uYYZh14hIRocOnYTtI22Ev5gSPpnZvVeOhPNjpQ753SmL
         zNKIzsVtLtKzn1OFRtmvI3I88r9Exr1joXiUgEiJBFvExWRD7+8Nhgai+bi0J++d07fT
         KXstEnpuuWIu/6jcvyqrvcKl/KJeySqehHNM5E4jPCUHKIFj3ZFuihPvLJtX4fcwBkxa
         CYVe1R55fXpM2EF+kTgboGXLF6lTSDEp1SU8+3HhmUoovjoOwH46swpNpbh206u7pqhy
         kUzfIPNOQU5yL6uUt5ntzhTf2EaQO+LnXV2G6y55+h0vjUOSH1hUWhj9Bjd3FLfEVHoL
         zqRg==
X-Gm-Message-State: ALQs6tBs4O6wVZPqEP0WdJPU5Jugfb9LuhDR0ina+mops2wgNnViBM6w
        gxqDQ+RvnbJSHg1OOFV5N+4VjeR7eKWd5QPy8pE=
X-Google-Smtp-Source: AB8JxZpY0GQt6Ze18Dy3PRFllKfzx6GaN4ARFlt4FJdKMPRnj2RM+dRPGJjjpQt89HsNyvQX8FvQV07eOE3N0q/rCuA=
X-Received: by 2002:a24:7ac7:: with SMTP id a190-v6mr12232194itc.151.1525087830498;
 Mon, 30 Apr 2018 04:30:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7c91:0:0:0:0:0 with HTTP; Mon, 30 Apr 2018 04:30:30
 -0700 (PDT)
In-Reply-To: <CAEp-SHXo2fnyUSMDqJnfOkh_R21R2FjFUtQ14u9s6-tV039tHg@mail.gmail.com>
References: <CAEp-SHXo2fnyUSMDqJnfOkh_R21R2FjFUtQ14u9s6-tV039tHg@mail.gmail.com>
From:   Casey Fitzpatrick <kcghost@gmail.com>
Date:   Mon, 30 Apr 2018 07:30:30 -0400
Message-ID: <CAEp-SHXXwtgDb=bzTmT88aPQ267ANLCN6S3teC4hjHYDL9NQ3Q@mail.gmail.com>
Subject: Re: git-submodule is missing --dissociate option
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It also seems to be missing "--progress", and I imagine others.
Perhaps submodule add/update should be reworked to automatically
accept all the options that clone would?

On Mon, Apr 30, 2018 at 4:29 AM, Casey Fitzpatrick <kcghost@gmail.com> wrote:
> This seems to be a hole in the git feature set. I believe it is fairly
> easily worked around, but it would be best to provide the option for
> ease of use (and maybe performance?).
>
> git clone has both a --reference feature and a --dissociate option,
> with dissociate allowing for a reference to *only* speed up network
> transfers rather than have the resulting clone rely upon the reference
> always being there (creates an independent repo).
> But git submodule only allows for --reference, so there isn't a an
> option to make a speedy independent submodule clone in one shot:
> https://git-scm.com/docs/git-submodule
> I checked the latest online documentation (currently at 2.16.3) and
> the documentation in the latest sources (almost 2.18):
> https://github.com/git/git/blob/next/Documentation/git-submodule.txt
>
> As far as I am aware this can be worked around with 'git repack -a'
> and manual removal of the objects/info/alternates file afterward.
> Though I don't know if this results in a less speedy clone than
> dissociate would.
