Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA051F609
	for <e@80x24.org>; Wed, 28 Nov 2018 19:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeK2Gbj (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 01:31:39 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:36995 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeK2Gbj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 01:31:39 -0500
Received: by mail-ed1-f52.google.com with SMTP id h15so23095647edb.4
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 11:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ys9r2v0LVKNnFaYNBIeood3jLX48zHP2Xu6LUlbUeVY=;
        b=gNlCu2zjo3flWwNQqnb/LxRxN0y184ej011RgDz3JVAZkLmmtBu9zBXdVEd6y2a0jZ
         fLB/cCacgEIpsTF2T44f+dTP+6meBVRvpLlppjLBspGshbsTRnDL2nF4aSJOTnMR2F3J
         COSPb4AaFJu9qcciybHubxnx5jgSvo5uuubO0694TJvcS3/Cz96nhXYobG3mUH/E9Iec
         isn4IS85E/9Ih8W75/8N2XFN1bvfQE8KBnHXLzOi9dTwhHVX1WHjfHWBauOKyvroRKd6
         5c8pCQst8KdPm8AGxUOA+pvFKz61KNTUFVANnacYHNVUxhIefIlgNkXG29eGtXylHK1b
         sM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ys9r2v0LVKNnFaYNBIeood3jLX48zHP2Xu6LUlbUeVY=;
        b=XnTOJKDj9oVm/+8+b6EFXIyzwk4iJHgUGI42BGs43pf262ZD2zuPkBhZfIOvAGc3Eo
         HVjXcDd9a9IoYwT0CYZA2enN17ugKThwSZ2DgzV5ul3jZSi8/FXDXbz60ba4SVfcsciF
         bZ0ssHt1slq0ukFk+5B4iuvDNJB4U5OcJ2EdtxzDGTPqL5KrhvfbEroyZEruwShqP264
         CwvnjUiPFAhrkIqmczE2jwnGtxgMKf3IcY/1qOzuGZqV+Ce0sjURpZWuYL8VJGmx9Sa+
         +Lj2M6E+Dkh13ZsOLmFFLeUikJSVyhlUTqPiRIEDmfl171ptAjfRGKfYzHRnEh2D5URi
         Secw==
X-Gm-Message-State: AA+aEWb1TN4pycnO51FJoxpsYnY+mOGbZpqt2eD1q5N/r+F6b4GlGgBF
        NGtG0ExTOZs/zp5VHMd7Db4cn+qYeMBWY3M3HXFe4rzfoMqyhQ==
X-Google-Smtp-Source: AFSGD/XyAc/8nIps3GXkV1vfFPxIo2cUPkuf5lYgImE68lc3eRRk499BvtlB3RWDWK4w84zCY6MpcL8qsztFXY20a4g=
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17-v6mr1248824ejb.70.1543433334314;
 Wed, 28 Nov 2018 11:28:54 -0800 (PST)
MIME-Version: 1.0
References: <CAABTFJPpmThrrwP6pb5gZ82fb8yKteLpDcXTCQS8p_7WZ0Ne5Q@mail.gmail.com>
In-Reply-To: <CAABTFJPpmThrrwP6pb5gZ82fb8yKteLpDcXTCQS8p_7WZ0Ne5Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Nov 2018 11:28:43 -0800
Message-ID: <CAGZ79kZtrj-Gg8P-xJmn8TYjgXuUmj8pJUXU+Vf89F0tKHuYBg@mail.gmail.com>
Subject: Re: [bug report] git-gui child windows are blank
To:     kenn@eissq.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 6:13 AM Kenn Sebesta <kenn@eissq.com> wrote:
>
> v2.19.2, installed from brew on macOS Mojave 14.2.1.
>
> `git-gui` is my much beloved go-to tool for everything git.
> Unfortunately, on my new Macbook Air it seems to have a bug. When I
> first load the program, the parent window populates normally with the
> stage/unstaged and diff panes. However, when I click Push, the child
> window is completely blank. The frame is there, but there is no
> content.
>
> This same behavior is seen if I do a `git gui blame`, where the
> primary blame window opens normally but all the children windows are
> empty.
>
> I have googled but was unsuccessful in finding a solution. Is this a
> known issue?

Looking through the mailing list archive, this
seemed to be one of the last relevant messges
https://public-inbox.org/git/20180724065120.7664-1-sunshine@sunshineco.com/

>
>
> --Kenn
