Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56961F576
	for <e@80x24.org>; Tue,  6 Feb 2018 09:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeBFJsr (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 04:48:47 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:36198 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbeBFJsl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 04:48:41 -0500
Received: by mail-ua0-f175.google.com with SMTP id i15so776621uak.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 01:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sqZoGNklUDDIpKRgU8Z8qBemsE7APvjmFug/CcZrxao=;
        b=c4RQEau2fZe+Y9h7H0LaF6HvwBOhzfEJNaa4zI/3YRfjCaPjcgk38Eq73xqJ0zOrpp
         oSO2EYQO67obMY7V6FNoz/EyfSsQHCJCaMqSWw1rL7T1f5BDppbI/GRxb3wB/QxqZynj
         eGz9np02tov16yuYGYeYox2SojvcH1TReV9CAqubG5clKm5i5HxcpNuKP1FU/4VVtqkx
         Hz3uHWLosSUcn1dkgp8PnR/vU4wXJ4yXNvz3ufhi8tukTDkMVGjnvBBu3dY+HJzU94LL
         GhfQifKqElhbnvcBXvP4BAdOXsiilsYMdD2VuLWNBgqFMItR2LfvgYfdlWZ7EqOkhweZ
         GbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sqZoGNklUDDIpKRgU8Z8qBemsE7APvjmFug/CcZrxao=;
        b=IS4iEeqGfh73KIV3Wha/oEuS7R+eaAz8weo2yTz9VVgofWgXl9TdfawWPVZoIBEsE/
         ti0uogx16B208+OzcYvMdugpPRHUo3z/jWQBnsBjwfHibcELwh97TW+lKTANJB+ymlZc
         E5GolgeUgXjGh/uZP0pL5TdTJu3UsNoMdxtXhYUIc5XJOtwhRyHGTVuo3dW/buVrqCbt
         4qpGp4IYev5ILReClvWOIWpEE41E1eZP9O61kVyUn4ae0zeEV4epaGbeuAZeI0hgWUw1
         FVRxH9nGlD4oyLo22DZDwOdAFKBUvOnaSQGakcQE53Gh8QNk4MJFa502oXfaeN7n5tNd
         AAiQ==
X-Gm-Message-State: APf1xPBXUAxmwJOJQvLZ+Gah7cvgyp/mPVZGt/NvOvGvDfhOJEFw6ELo
        vae2JZNLVTr2X1AK+YsLA3T9dj/ORg9Rah1FVjGWXJxGx+4=
X-Google-Smtp-Source: AH8x2244a4CW0mhTDiU4/CT+VIrbsZ3JA+XX5zRNhAe9HZOfdK0i/aoGnB487ZfZZ8oj2C9E3bEMm/ypSYL6PQOP4Cw=
X-Received: by 10.176.85.132 with SMTP id v4mr1671958uaa.145.1517910520324;
 Tue, 06 Feb 2018 01:48:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.130 with HTTP; Tue, 6 Feb 2018 01:48:39 -0800 (PST)
In-Reply-To: <CAOKXNqBSqEP7aikjM1GE=p7jWBsN13Xy3qVL-on7RnrUrwi+bg@mail.gmail.com>
References: <CAOKXNqBSqEP7aikjM1GE=p7jWBsN13Xy3qVL-on7RnrUrwi+bg@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 6 Feb 2018 01:48:39 -0800
Message-ID: <CAGyf7-Fy_APBx8aK2_L5nQN5NfLSxh+qy12Sd8QmLh3LP4KRkQ@mail.gmail.com>
Subject: Re: repository history?
To:     Zsolt SZALAI <zs.szalai@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 1:41 AM, Zsolt SZALAI <zs.szalai@gmail.com> wrote:
> Hi,
>
> I wonder if there is a feature with which the history of the
> repository can be listed?
> i am interested in especially the usecases of pull and push, i.e. to
> query when the a branch was refreshed with remote changes and which
> commits were pulled, things like that.
> Is this possible?

Have you looked at the "git reflog"[1] command? That can show the old
and new SHAs when a ref changes, and you can use "git log" to
determine which commits were added. That said, it's most useful for
fetch/pull; push information won't be as easily derived from your
local reflogs.

[1] https://git-scm.com/docs/git-reflog

Hope this helps!
Bryan
