Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1123A20193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942769AbcJ0WbB (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:31:01 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35910 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933403AbcJ0WbA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:31:00 -0400
Received: by mail-qk0-f170.google.com with SMTP id o68so65840410qkf.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B1mGYLOhbuH/4shXJT4JzQaVUarH7I0Rgs7AU2uDaoU=;
        b=i0gfATByuJphvEkFqpTLG5cQ73C+hWp4+IGJC0/WvzyDehBMLUU1CYe8WKqNl5q9om
         eu0j/9nfXdW2jEqLfJ4eHAhVipfgiONf935o962mxYyB64QXoQGe+iHFxtWuKTu/OHcF
         taM/uSBOUXBTvSP6cn+WBNSCC9opYC1JzGkYds6R8o0b/arjaJZvRwaWRbiDwxdt0HNA
         LZBzvZ0EXIIEN+ppphiScGQx38ggXXergxDIcwlfz0L50D8mQ6IygIExu0lBX6LmeRwl
         KZBMJxET86/hVTL7Nb4LyDNw+NH1P5vV8dtJy3WjllAmN90j6aovWHSmNnpwdIMWo048
         AcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B1mGYLOhbuH/4shXJT4JzQaVUarH7I0Rgs7AU2uDaoU=;
        b=HPEb+D4UjJP9y3m7XSl76hXDWQA/ySGrVgbTO4LXUwNw6O+DBGiHi6PZsu46AxYPmw
         21Y4rkW10MLkT7sbrMoSm7jv9BQVQoTXSX10rhkyZXwFuMvhpMOX9HlF9q/RzE00Gz+K
         uO9wIr57Zb2QcXMGaFovEWF2CwQ5GCo1hhVI4e5j9IQI4ZXWW2xbTPHWJLZ7JJzZK6jI
         nGogaW/XvbGutLTQfRghGIxXyVuVQ4UPQk47iGO1GbfgUVMnmVLMhrnVBlODuBJhrIus
         j+p0CgaHInftfYdqrAJ07f8kzj5oRiQEQtfW4gz/pb+njwbUUrx2NtLO9DRbHOf+iiC4
         MC4Q==
X-Gm-Message-State: ABUngve1aLRhfcSI6jvhGNlWxr4pnEL1u1AKA0frmhEkH5exq3ll8lOvSkVgAZmHyT8EH35GI7ETCOMr8UGBh+7s
X-Received: by 10.55.45.193 with SMTP id t184mr7340716qkh.58.1477607459326;
 Thu, 27 Oct 2016 15:30:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 27 Oct 2016 15:30:58 -0700 (PDT)
In-Reply-To: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com>
References: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Oct 2016 15:30:58 -0700
Message-ID: <CAGZ79ka7BvaW2pkjeXe68yKHFq6JsH__x2cXoe6U4tRmZ0rY1A@mail.gmail.com>
Subject: Re: feature request
To:     John Rood <mr.john.rood@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 2:55 PM, John Rood <mr.john.rood@gmail.com> wrote:
> Users should be able to configure Git to not send them into a Vim editor.
>
> When users pull commits, and a new commit needs to be created for a
> merge, Git's current way of determining a commit message is to send
> the user into a Vim window so that they can write a message. There are
> 2 reasons why this might not be the ideal way to prompt for a commit
> message.
>
> 1. Many users are used to writing concise one-line commit messages and
> would not expect to save a commit message in a multi-line file. Some
> users will wonder why they are in a text editor or which file they are
> editing. Others may not, in fact, realize at all that a text editor is
> what they are in.

Look at the -m option of git commit,

git commit -a -m "look a commit with no editor, and a precise one line message"

I do not advocate this use though, as I think commit messages should be
more wordy.

>
> 2. Many users are not familiar with Vim, and do not understand how to
> modify, save, and exit. It is not very considerate to require a user
> to learn Vim in order to finish a commit that they are in the middle
> of.

That is true, but vi is like the most available editor as a relict
from ancient times;
as you are on Windows, maybe notepad is the best on that platform.

Maybe file a bug/issue at https://github.com/git-for-windows to change
the default?

>
> The existing behavior should be optional, and there should be two new options:
>
> 1. Use a simple inline prompt for a commit message (in the same way
> Git might prompt for a username).
>
> 2. Automatically assign names for commits in the form of "Merged x into y".
