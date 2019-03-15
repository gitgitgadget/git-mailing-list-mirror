Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4CF20248
	for <e@80x24.org>; Fri, 15 Mar 2019 12:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfCOM2p (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 08:28:45 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:34164 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfCOM2p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 08:28:45 -0400
Received: by mail-io1-f42.google.com with SMTP id n11so8190734ioh.1
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AX0AnztH2O/Y87YPdmYZjt+N8wKFB35vs6SbLyAJ9fk=;
        b=iGZlJ7rhmP0eJp2CSCTzZnSaunN4BVcVmbSptxornJbc5X8cZkJ75u5OeXWzX8fD0S
         yCPEkhAI6hVfd9yQjgRp/v66eisvdXAj4LzotsZFyCheBVY0WU17e+VXtb1dQr1AFeVR
         2nfNO9IAYTJJleGn/CPFb1jHgfREgZNl63MfceCXtFoUkG+POp2AMbm4kh1DjrabWUmK
         CWmoB6i7xEoYcriODfFsX+Q/CBVoHfRwvVtqLGavwwusCfe4e3iezbIABtsUN7C3lDho
         t/7mV/25UZ8Ug7D6jmAhAKc8QyUm0b6bNxNP7y1XXE7jUdVQLN0eEhQVzPHnKT3wPxuC
         390Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AX0AnztH2O/Y87YPdmYZjt+N8wKFB35vs6SbLyAJ9fk=;
        b=Kja9T5PjXJPLdmRWvXaKOPGtwjtAbeFeXHP7uEIv07ORW8MwHdcIZvibuOY6cY4lA4
         grdsikPw7LsJLYI3gMbY8uUaZff+beTHsSDZJorpbJ6oXrHMZsVaywiz145Bq8sbAWs6
         PO74uPxDGOw5AtHfJQlcKQzGTWXtU33vKhPou1FJeGRoXE/8egxpLqNhEQ8+zbD2pRR9
         L8ePFlzT0LVCvx59i1k5/yiNeMHrwoNZXengdoNl0rtitMDYUBfEFgB6HUdDkFi179uC
         P+ATgdoE4L0OtsH1m9+fPjd0fooajLuypbmDZ3QRg9ZiPgvkgawXrnAxpVp8yzP4nTsr
         Lj2A==
X-Gm-Message-State: APjAAAUW8ruOiTsduyNDVGg8eU/dvRoe9xvnL5nJS44EOzoYhX2j1cY5
        zb22fhUA1HZSJJT4/cLP5dMzSjIQ8DDuGLcJ3hOn3g==
X-Google-Smtp-Source: APXvYqypWER/q1x7WQV+Vz4wXH9uHsbRJH6kfKtxHQHMtqZ0+0G2twAkZHKivfOhESqHQg96HoDPJ9p5Abb43gG2+JU=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr1751442ioa.282.1552652924536;
 Fri, 15 Mar 2019 05:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1903150809070.26709@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1903150809070.26709@localhost.localdomain>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 15 Mar 2019 19:28:18 +0700
Message-ID: <CACsJy8DVRJ4DG6PEkFuzytOQJ7RX6GMaHd4BRQTR9N7Y9V6fqQ@mail.gmail.com>
Subject: Re: "git clone --shallow-exclude ...", fatal: the remote end hung up unexpectedly
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 15, 2019 at 7:17 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>
>   probably doing something idiotic but i'm enumerating variations of
> shallow cloning, and tried the following:
>
> $ git clone --shallow-exclude=master https://github.com/django/django.git
> Cloning into 'django'...
> fatal: the remote end hung up unexpectedly
> $
>
>   it is entirely reproducible, and some googling suggests that this
> represents an error at the *other* end, which in some weird way does
> not support that clone option. that seems strange ... should this
> option work? am i using it incorrectly?
>
>   wait, hang on ... i just picked one of django's topic branches at
> random, and this did succeed:

Yeah i think when you request shallow clone, by default it only gets
one branch (see --single-branch, often 'master'). So when you specify
--shallow-exclude you essentially say 'give me master branch but
exclude everything from master'.

I should probably make it print a friendlier message than simply
terminateing like that (it's still a guess, I haven't tried it out)

> $ git clone --shallow-exclude=stable/2.0.x https://github.com/django/django.git
> Cloning into 'django'...
> remote: Enumerating objects: 33112, done.
> remote: Counting objects: 100% (33112/33112), done.
> ... etc etc ...
> $
>
> but all this gave me was the master branch. i clearly don't understand
> what this option is supposed to do.

You're saying 'give me master branch, exclude everything that is
reachable from stable/2.0.x'. If there's nothing in common between
master and this branch, you get full 'master' branch. Otherwise you
get a shallow 'master' branch.

This option is meant to give you another way to cut the history.
Instead of saying 'give me X latest commits' with --shallow, you could
say 'give me commits since this cut point' and the cut point is often
a tag, on the same branch. Using an unrelated bracnh or tag could give
some surprising result.
-- 
Duy
