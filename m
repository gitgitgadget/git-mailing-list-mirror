Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87BB02027C
	for <e@80x24.org>; Fri,  2 Jun 2017 16:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbdFBQig (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 12:38:36 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:35725 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdFBQie (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 12:38:34 -0400
Received: by mail-it0-f53.google.com with SMTP id m62so11425561itc.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 09:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UKJgZ6ExpxbuN9K8kRpr1UDo271w+zHuIhGUTK9esec=;
        b=lvSlZgS+VjzWyYBoaaFghXuatSCv7zxZFvuwbAPycHptDMX42BoBH3m5kODYWeI6sf
         p1liyspfozaCo46MPO8PQsSu4+NfnfAw+rM31XZcsQj6RIVxZGLWmQ/O8h9j9XU1bCaJ
         xL6AKAWBzJWcZP6D+b+MKLE5lCeVf7ccq33Cte1ykpeiMs/AcwI+nqAm3rn1USb8of72
         9ehVPBAuPI+FG9OuBqKwciDAqXkKDHZTze3+6sF+UKOTXk1o4w6r+NKTHUCcJUFHOZ9u
         sUIiqt1msQieBvRtPRkvWO4iZDpT0yb8Paswi1M9ip9srvQsIxHwed+nWdKYvh/TKhRe
         OlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UKJgZ6ExpxbuN9K8kRpr1UDo271w+zHuIhGUTK9esec=;
        b=NiQMc4s8xZUbxJSf55WWXgNGh2yWyu9UC5pRJL9Z6EHZQSJiXLIS82ZJ83UOfX/W0c
         PeFDic5xAKsa5xwS8KYTHTR7KrWtYZ1SEVgzneuzB6jSZ98B4zVdybZIpjn/MhvK7RnA
         QQ/TWSlM2q9eEzlg6tSDQ/pLBk4jqejeBtiLBlp1ZyAfTkBVMbS8r3O9RArqQRqjfAoM
         xvB5u+timXhHik9GgFHWoLqcJj3w2+muorq6l+PS7KjzY8+ELLND6IBjR4GdGWKKBoiM
         vCrPwV0IHTYHCXXaEGCCQCMQVVOzLglMYZfZJ2Xju7FanKVqv16dQ6NVba6tX4xklIe6
         BW5g==
X-Gm-Message-State: AODbwcA/SA6CkK0UrYFdj/ydblI9ac0zVG088DQUn0hiRsdMNhC/oqyu
        kQYmEYZGr19Fuyz/FzF0JkYDiIkVOOaGjDI=
X-Received: by 10.107.178.215 with SMTP id b206mr5146403iof.50.1496421513140;
 Fri, 02 Jun 2017 09:38:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 2 Jun 2017 09:38:12 -0700 (PDT)
In-Reply-To: <953845c2-4326-608a-c342-2d2141da561c@gortan.org>
References: <953845c2-4326-608a-c342-2d2141da561c@gortan.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 2 Jun 2017 18:38:12 +0200
Message-ID: <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com>
Subject: Re: git-gui ignores core.hooksPath
To:     Philipp Gortan <philipp@gortan.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2017 at 3:41 PM, Philipp Gortan <philipp@gortan.org> wrote:
> Hi git devs,
>
> First off, thanks for your awesome work!
>
> I've been unhappy for quite a while that I had to configure the hooks
> manually for each of my repos - until I found out recently that there is
> the core.hooksPath config variable that (when set globally) allows me to
> specify a hooks directory to be used for all my repositories.
>
> Now I was happy - for a few minutes, until I tested this feature in
> git-gui, and realized that it doesn't work there.
>
> This seems to be caused by "proc githook_read", which says "set pchook
> [gitdir hooks $hook_name]" instead of querying "git config
> core.hooksPath" first - cf
> https://github.com/git/git/blob/2cc2e70264e0fcba04f9ef791d144bbc8b501206/git-gui/git-gui.sh#L627
>
> Would be great if this could get fixed...

Hi. I added core.hooksPath, glad to see it's useful to other people.

This indeed is something that should be fixed, but git-gui development
is managed outside of git.git, it's just occasionally pulled in. I'm
not what the best place to contact is, but I've CC'd
Philip Oakley who's been making recent commits to git-gui.git at
http://repo.or.cz/git-gui.git/
