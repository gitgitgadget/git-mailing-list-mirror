Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 001302023D
	for <e@80x24.org>; Wed, 22 Feb 2017 09:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754402AbdBVJuY (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 04:50:24 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34319 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdBVJuV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 04:50:21 -0500
Received: by mail-vk0-f41.google.com with SMTP id r136so3202285vke.1
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 01:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ri8IIxwmGZGphinNjV0g3xh8c+YDILTxr3N95bCrUII=;
        b=NmPO9QJ+xWwMkvj6sh6ZhLqb6ozRhYva3a4eEQ4QlBUieyZt5zFxi00DQa3Av/z7vw
         SEZdl3gRf0xKV0DbIVfc1vjybdP4bxCo9UsCkK5Xyrk2Jf4a0NjHfKFb9c+stxV74REU
         VTv/zgZn7k/bCQJAt7a/fsDj7WgbfbT48+3HXWsHzb5JbaKgJ+X0RtE7OG6u4wbuo2w2
         dNdglvMLNhPxOtffhAOxl62qGCIJNi9nxDn9PQqseA36L1eKuzssCsqIzX8yfxfVmpms
         g6FmmYkRvK5J73cobeAzQwQLYav9MZqmWeJR+jAYf1fXfGEiemx5Ekyyef31s43m9oBW
         Sk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ri8IIxwmGZGphinNjV0g3xh8c+YDILTxr3N95bCrUII=;
        b=rk2TufM6bUc2bUwUSQVYDlh3+37QvDL+Wye5QUnK8jwElezIoWZ6NjsKxSiRm9wHRb
         eSvQTw5AZO96e4tKVNeG+7WGNkVIsqWr6BNspi1fZIu0U2b3h8ZvmhtVJjh8mNc1VYJo
         y4mf0xKKZgUz6P77W/xzzYzFuBHG31R2Pcwl1UnsY6R70GnZxoLPA+4/Y/u5eOWJsAor
         lNZHpGQCiMtmKDl482CVbe4PjXPeXzGJ5+ai/H8ZvxKjhWdIjOmq1p1vaIIit7LgMyES
         +G0Kg99pxu5PFqwk4hXiyLGege8CjgsEXkljnnHNzGIsYtfrHzezrd8WuDaEAWxzbr9e
         SvCQ==
X-Gm-Message-State: AMke39mi0/um1WtRIDonoI/hKfgS0U8UTavWb6bY0HCtNkeYql4C+DbJYuNDu4aSoWDNEPM/OmGR9S75KR9V3A==
X-Received: by 10.31.218.68 with SMTP id r65mr14649926vkg.27.1487757020204;
 Wed, 22 Feb 2017 01:50:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.46.149 with HTTP; Wed, 22 Feb 2017 01:50:19 -0800 (PST)
In-Reply-To: <44fd4dce451fb0783de02c0a8c4a14aa.squirrel@mail.jessiehernandez.com>
References: <44fd4dce451fb0783de02c0a8c4a14aa.squirrel@mail.jessiehernandez.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 22 Feb 2017 10:50:19 +0100
Message-ID: <CAKPyHN3f0NwMt1aXx6keSrhaiqRqH6s_xQFdKv5rZ+pL7fmXFw@mail.gmail.com>
Subject: Re: [RFC][Git GUI] Make Commit message field in git GUI re sizable.
To:     Jessie Hernandez <jessie@jessiehernandez.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HI,

the reason why it is fixed, is because commit messages should be
wrapped at 76 characters to be used in mails. So it helps you with the
wrapping.

Bert


On Wed, Feb 22, 2017 at 10:27 AM, Jessie Hernandez
<jessie@jessiehernandez.com> wrote:
> Hi all,
>
> I have been using git for a few years now and really like the software.
> I have a small annoyance and was wondering if I could get the communities
> view on this.
>
> When using git GUI I find it handy to be able to re-size the "Unstaged
> Changes" and the "Staged Changed" fields.
>
> I would like the same thing for the "Commit Message" field, or to have it
> re-size with the git GUI window.
>
> I can re-size the "Commit Message" vertically when making the "Modified"
> panel smaller.
>
> Does this make sense?
> I would be happy to get into more detail if that is necessary or if
> something is not clear.
>
> Thank you.
>
> -----------------
> Jessie Hernandez
>
>
