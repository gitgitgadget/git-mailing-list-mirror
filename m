Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1B541F576
	for <e@80x24.org>; Sun, 28 Jan 2018 09:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbeA1Jkj (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 04:40:39 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:43918 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeA1Jkh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 04:40:37 -0500
Received: by mail-oi0-f46.google.com with SMTP id 4so3037248ois.10
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 01:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RAgnG1/mSU9bRGLQTSskLZi4SGI1zhS5/kYzmt1OzOg=;
        b=Sn9dXPt7B4ofg7UWOOtBFEkMtmrOhDPJn4+B2ofLYR30qSNwWwhJ+PpXB+YRaju4LI
         x08us9qJf9BXcuOrshEDz73wNlTCuJ0i7IcY3SaxbeO93Hatq0qck0LL5xSfGMQlvpoA
         nF/kV1fq+S42ZJjFBhdTUSbxy0SZw4usIH+L1i59Jtobk0xIlTGcVWRLqNG3LjQixjlA
         GEGLVT/v1ja2mVyb76pO6nucy3vNX9JuOR0qm6DFQPm/C574OXZZUcQ5c5dLWdBlqqPt
         22Rzs33sFE3gu0mbk3qz4U8D9I0CUlsKpvxoi/qc+Yx0ckW6MHUGtNIx+HnSlFPKzKAA
         pu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RAgnG1/mSU9bRGLQTSskLZi4SGI1zhS5/kYzmt1OzOg=;
        b=EeVU8E4xXodrCQE/h745TOQfSafiPuo6cYQ15aoyV/noT1y0TGElC67x7NDQ9isLXK
         SnkMRWRRUQSa7BRcvC3NPlSizB3AcSJ+GV2gOGrBKQ8fb+eCAyPzNVJhZof5QZyJjbZy
         z/9w9fdm31bZZcIF8i74g5s1LXwMfOA9fPQOhRpIVPWxQUWXfh2CI+vK33SWmazia4ks
         BNr6q7FgZg7Qd3wMg/RLhHflRW7zz926UnG5zGyxJsX3sa3yYRgKv/+ZjjDqlyLKXk+s
         H+/2F3lQYm/Q/L07dp7hClGjkpfAdgw3AFkDvyjnTiYwRdk3aQdgam+pZM3k+lKfWGIi
         mMDg==
X-Gm-Message-State: AKwxytfb8q1AbE3ZDrup7jxTwLOYxJqpJmv7uYC+XUIWTCPUUN1rGP+t
        mqweyHpV0RQDk3+O2ONGxri0ZIp20r1DIGpzr4E=
X-Google-Smtp-Source: AH8x225ANqfZ0vto/0RBiai6w99eE+nBQ0DpEC4agdIN5h69vE+CzyzMuTjQaxmBy/a2F1kkHehMPbrvwzxgoh19a34=
X-Received: by 10.202.177.136 with SMTP id a130mr14081782oif.252.1517132436747;
 Sun, 28 Jan 2018 01:40:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Sun, 28 Jan 2018 01:40:06 -0800 (PST)
In-Reply-To: <CAPig+cSP0UiEBXSCi7Ua099eOdpMk8R=JtAjPuUavRF4z0R0Vg@mail.gmail.com>
References: <54fd6a226955dc427bb25d5be37b4b0a.squirrel@mail.jessiehernandez.com>
 <CAPig+cSP0UiEBXSCi7Ua099eOdpMk8R=JtAjPuUavRF4z0R0Vg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 28 Jan 2018 16:40:06 +0700
Message-ID: <CACsJy8D03LkoT38Xrz0xDUk=Uf=9O0XKrLG0vZMtBxowo9ibNA@mail.gmail.com>
Subject: Re: Creating sparse checkout in a new linked git worktree
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@jessiehernandez.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 28, 2018 at 2:25 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jan 24, 2018 at 11:11 AM, Jessie Hernandez
> <git@jessiehernandez.com> wrote:
>> I am trying to get a sparse checkout in a linked worktree but cannot get
>> it working. I have tried the following
>>
>> * git worktree add /some/new/path/new-branch --no-checkout
>> * git config core.sparseCheckout true
>> * <add the directory I would like to checkout out to
>> $GIT_DIR/info/sparse-checkout>
>> * cd  /some/new/path/new-branch
>> * git read-tree -mu sparse-checkout
>>
>> But I still end up with a fully populated worktree.
>> Is there something I am missing or doing wrong?
>
> The sparse-checkout file is specific to each worktree, which allows
> you to control "sparsity" on a worktree by worktree basis. Therefore,
> you should create $GIT_DIR/worktrees/<id>/info/sparse-checkout instead
> (where <id> is "new-branch" in your example).

Nit. Do

    $EDITOR `git rev-parse --git-path info/sparse-checkout`

if you're already in the right worktree so you don't have to find out
about <id> or the full path.

I wanted to add "git checkout --edit-sparse" for some time. Using it
in multiple worktrees may be a good push for me to eventually do it.
-- 
Duy
