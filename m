Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006DD2021E
	for <e@80x24.org>; Thu,  3 Nov 2016 17:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758957AbcKCRBk (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 13:01:40 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:33354 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758559AbcKCRBj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 13:01:39 -0400
Received: by mail-ua0-f170.google.com with SMTP id 20so44756908uak.0
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=OZAtlUZME4uuxacCh8/Dpp+ZY7D/+XzC+qgX2NImhWw=;
        b=d/UnBna8zj+d+FhbaIfY95ztU6F+Ih9pNeAvc3HUCO4LeLpyMzlg8GeTwA6WO81cjA
         NYrYtPAnnUmNpNCTxRjAfDYZFCqW3+SoaIt/84pBy6WXPWxenOPRtmYMJv6JT28dxMZU
         LvQObza27XII1EaM+jcapkyz44nRj5YU8knLbLqbw65NpY2UIyJ3WORlbh7Gowhcok6m
         GAo8P2I4SPzk0AnFQ7VvvN1KZZflLj2LX5JCzx+GS+J45hAwrdlNvQKYc/1U1WOFwiUq
         Pz8eW8UkDPrW6PFyGzSph2gb4UXw5gS6ygEZkLXzKlIaQZo/y3/94U4vAvk5jsU6T9iy
         u/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=OZAtlUZME4uuxacCh8/Dpp+ZY7D/+XzC+qgX2NImhWw=;
        b=jA44CQKkzJy8rjEZIxhPj8IAdiquIqFAQK3pxMx478cMJH+q5FHakpHqCvGbwXvXIh
         QQAuiVuIIV6BVMjrfMDs9kXD9by1oQcjIUv4nQ5Q7HVQYbHvRAGP0TIL4Qu/Ge9CRPHo
         eFfcCV4UFrGvYYdYKx3fbM7MOyIzY6TuTkRx9FRdQkHEQxf3pIzWRvB9cvUVn2mwQyU2
         5dYE+H0z/Yq9h140YkCI5BijHkax6WaEMYERRsq6hwI1gPZwxE1oRXAuslcKhXg27mJQ
         di85GXWccDOylRl8OgFi5EaUL3ggGUB8E+KJcLbMXbDc284wyFCogb+aSRXDeGZaGTVe
         SqSQ==
X-Gm-Message-State: ABUngvfv9LZbgrxn8OCdWRK0OoBkptOmUsUUlJWhEyuDc0xIPqqq3nlA2o4uuSJAqzXrZ8R3PGfTLloxBwxwBA==
X-Received: by 10.176.0.52 with SMTP id 49mr7960060uai.9.1478192498227; Thu,
 03 Nov 2016 10:01:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.47.133 with HTTP; Thu, 3 Nov 2016 10:01:17 -0700 (PDT)
In-Reply-To: <CAJtFkWsUL=9K=VGTDejE+4RR3HJevk+2aRAhUyf8-mDrqi5MRg@mail.gmail.com>
References: <CAJtFkWsUL=9K=VGTDejE+4RR3HJevk+2aRAhUyf8-mDrqi5MRg@mail.gmail.com>
From:   Stefan Monov <logixoul@gmail.com>
Date:   Thu, 3 Nov 2016 19:01:17 +0200
Message-ID: <CAJtFkWu1qf3xFg1-B-xVONOmqQZfJhe4+qAb4E3H2A5-st_2dw@mail.gmail.com>
Subject: Re: `git stash apply` deleted a random dir from my working copy
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Actually, I just tried restoring my dir with `git pull origin
clipping`, but that didn't restore it. So, besides the question "why
did it get deleted", I'd like to ask "how do I restore it?", as well.

On Thu, Nov 3, 2016 at 6:06 PM, Stefan Monov <logixoul@gmail.com> wrote:
> Hi.
>
> I just tried `git stash save` for the first time. It worked fine. Then
> I tried `git stash apply` and while my uncommitted changes were
> restored, another effect was that a random dir from the root of my
> working copy was deleted. I don't know why it chose that exact dir,
> there's lots of other dirs like it in the root.
>
> `git stash save` output and shortened `git stash apply` output are attached.
>
> Note: The dir that got deleted was a committed and pushed dir. It had
> no uncommitted local changes.
>
> It's not a huge problem, because there was no data loss - I can pull
> the deleted data back from the repo. But I'd still like to know why
> this problem happened.
>
> TIA, Stefan Monov
