Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BAD01FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbcHWReH (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:34:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34206 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbcHWReG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:34:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so19045587wma.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jkoFfinL5zbTKpYEHslKUJrkDaaPi8Ts5qLvb6EECLI=;
        b=BKfxC4Eimk+kI9lR9GigourtZ9SF2Z40LctaX8OJSK+chYoozTp2USpaVy+rQwlLK6
         uoH7gYWgwM1vFJMMD/0WLCKLuVT23x9WcLY1PUV9vtXsv0pBefCxa/ZxQ3lmB3sqnPZp
         OS08BBMh72gdnk+43GSmR2COKLYOXXBBFIZt0yexmzC8xSaRgMuFly+jwLjg7fdSLkYW
         42ewfllVr4Bb0K+QFE7vBRKKxhUtGLoxWruH/IjkaEKzGfqiwIQe4f+QErK1FruW94do
         d4207K6kUabjuaCbLeJipsMdfRC7kkOb8yZsfYvhApNEIgoto7TXTHTuNmQ13O+BljLR
         lrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jkoFfinL5zbTKpYEHslKUJrkDaaPi8Ts5qLvb6EECLI=;
        b=dBSr4uisIcHzNgaRTj2oQxmysDlmg4wdZm/fHcNQO5kcm+cRSJEFRK0BSKxJCgATB3
         1eb2QmXeqM/E8dnZ5odY1GtnmT4o8jwzkUGgSCixvyUGfE8YHf8tDM3GvQhTd8XbDrcM
         Uc8dql4viZ33LsztYL6HbUmRwSaSoYSh8Lp8u2uwnIoZWln7gsY7w0FSA74Ng/85PRzY
         YSntlyl8vmEoygBoiYNx260atRwoFUVeCD5b3DXdaZgayi4ftsUvu87eUGbvfKIow8QF
         J5cB/NqJx+a1aZZGN/j78vrT3Qa4x3zC6rtJKGeXPgudHxgSLb/BN0ntWxchhmwHnrN9
         01aw==
X-Gm-Message-State: AEkooutRlQyYXHG5Jtjg5Q71hM9knXTAqYTIlZTd/2X4HrI+9efL4lMK/zFhd/OeaDkuAw4EJ+19hyJeDxOYqg==
X-Received: by 10.28.197.129 with SMTP id v123mr20340390wmf.70.1471973644860;
 Tue, 23 Aug 2016 10:34:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.165.199 with HTTP; Tue, 23 Aug 2016 10:33:44 -0700 (PDT)
In-Reply-To: <xmqqpoozwgm5.fsf@gitster.mtv.corp.google.com>
References: <CAN7QDoJ-gQ9XUkCrTT6YDN+aUjNrAJWaG+WxbUvu32DJG-OZDg@mail.gmail.com>
 <20160822185709.izdfbkbsmeip5u7c@sigill.intra.peff.net> <xmqqpoozwgm5.fsf@gitster.mtv.corp.google.com>
From:   David Glasser <glasser@davidglasser.net>
Date:   Tue, 23 Aug 2016 10:33:44 -0700
X-Google-Sender-Auth: FmRUeBxwmSmsQuCqRQU44nw3N9o
Message-ID: <CAN7QDoJ3dv1MYjKGXgrC46K+xnUv5=PCrfqgSrJQbQ3kjBu6+A@mail.gmail.com>
Subject: Re: git-config(1) should mention `git -c`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 10:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> That seems like the most sensible place, as that is where we should
>> cover the order of reading and precedence. Perhaps FILES should be
>> renamed to SOURCES or something (though I do not recall if we are
>> restricted to "usual" manpage section names or not).
>>
>> Arguably this is not about git-config the program at all, but the
>> general concept of "configuration for git", because the precedence rules
>> apply equally to all of the git programs that read config.
>
> True, but that argument leads us to say git(1) is the best place ;-)
>
> If the user wants to know "how does the configuration values get
> read?", and wishes not having to go around fishing for the
> information in multiple places (and I think that is a reasonable
> thing to wish for), I think adding it to the FILES section of
> git-config(1) is a better option than inventing a separate
> gitconfig(7), which would still require the user to consult two
> places.

Great, I sent a patch in a new thread. I hope I formatted it
correctly; haven't sent a patch via email in a while.



-- 
glasser@davidglasser.net | langtonlabs.org | flickr.com/photos/glasser/
