Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A6A1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 09:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfAOJ1i (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 04:27:38 -0500
Received: from mail-it1-f180.google.com ([209.85.166.180]:50658 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbfAOJ1i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 04:27:38 -0500
Received: by mail-it1-f180.google.com with SMTP id z7so4033833iti.0
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 01:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBhWFFUcYzTKaw7uqkocQ7xyxSQmyJrq+nWjpinz/m0=;
        b=sFOQjGyytVH3e2ozoZXYnnmxD4YMRbjon0FxTJ+cJcUFujcBldCpU0E9MIQj8Yy5i0
         6FUoWkU6fG7am1O6CcIBWhO5Ka1mDo385utpXvke2QVkgWRDAC16Q1f7b5Cm564XlFzk
         5FIDU/la6ILetGh+RmfDmp28NJ09q/B60kIpxLoz4eOynG8XOO0a9mdEFw5ueQmurvJf
         O0a+MvVw3Va2WAxYY25I7o0Dg1En5SCd436fnjjEDlmxAExTayp/ECr718VCBMcd4EN2
         YHfXuF1jXjvy7Sy+lDD5Ky7cKn5WgOTiONCmUXAHcYl2nu8/DBQBGBajSgiJYKSXxy+M
         Rwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBhWFFUcYzTKaw7uqkocQ7xyxSQmyJrq+nWjpinz/m0=;
        b=paHiFzyAstL7LSKq4l/gj+GNgaBvjSM/tOsTDv1QavdiJyNJb/pMQzZ+C0luO4WQNo
         m6LucWp/pdHeYUcY5Q+GaLcgc7oUOYOkWw/bGaHFVgPfDnx7GTIZNLbN9iAqDwdfuOaL
         J8Bepmz3Jk9WeEGxXXTeMwY+ra4FD0wapwMqqamALY7eyGIi82TG/zVYr1vMvBIlrPEo
         OzKN5sb9gjuUqIexKgI5OwdQ8y62rMKhjvj71q35eYoTD1hTEKYnl8egBaH6iIn6+6zV
         Llnm6TkbMPp+L8pQrhWX50nK2wvA1P0WbdNZzWTbiuRYOyj0CU/PipO2z4vSyG7qfCE6
         X1ag==
X-Gm-Message-State: AJcUukdCP1tzn6vSZOiPhSmhO+sGv2KjSkLvsgTC4vKiPUR74abe+62L
        lvIMox3+OzE3x9qLhCZ9qYSizirKWxhFcTKRuQ4=
X-Google-Smtp-Source: ALg8bN5wZfFuQSqGhzYEwaoZ69nD79vmiquEpe65Xpb/0EdIK4yL6jpaapdlxqbjzuw9tjUBMAMFBDFo8YPTw/kN77M=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr1940701ith.123.1547544456629;
 Tue, 15 Jan 2019 01:27:36 -0800 (PST)
MIME-Version: 1.0
References: <CALZbgSQti+t2dA4nm+DCDGxQjsvNJy3UDdqAya16v+Mv5O4Xdw@mail.gmail.com>
 <xmqqzhs3uldb.fsf@gitster-ct.c.googlers.com> <20190114213852.GD162110@google.com>
In-Reply-To: <20190114213852.GD162110@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 15 Jan 2019 16:27:10 +0700
Message-ID: <CACsJy8BdsXYMy6S-8xmCtPzg6wWXb_AJLyfhCG1f6jxPu0LJDQ@mail.gmail.com>
Subject: Re: Gitignore documentation
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Maris Razvan <razvan.alex.maris@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 15, 2019 at 4:38 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Junio C Hamano wrote:
>
> >                                  Patterns with slash is anchored at
> > one directory, and that directory is the one that has per-directory
> > .gitignore file.  Patterns without slash (including a pattern that
> > ends with but otherwise has no other slash) are supposed to match at
> > every level below the directory that the pattern is defined in.
>
> I had a sense of deja vu, and found
> https://public-inbox.org/git/20111107080926.GC30486@elie.hsd1.il.comcast.net/
>
> Any idea what happened there?  Would it be useful for me to rebase
> and revive that series?

I don't remember what happened either. But yeah it's always good to
improve this text.
-- 
Duy
