Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4F420958
	for <e@80x24.org>; Wed, 29 Mar 2017 20:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbdC2UDi (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 16:03:38 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34453 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753639AbdC2UCu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 16:02:50 -0400
Received: by mail-wr0-f174.google.com with SMTP id l43so31632254wre.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gal-ro.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=jWtSQkbe2YuYZ1n0kjKaScduaEbBsvlW+hl6qH8MNz4=;
        b=bAXKWhGJQ01z8OR+vkdQsAFcMPkTywVCVrx8QSyho9Hiw1rMQ1Rrchvs7fpvJ/yUKW
         ct4OjMG9Ie+KHINSkhjrzw46R5nkM4PbIwHQB1pfl894rblZxW7JysfKTj4xK8AIx4r5
         yZyqGOktuMi5S2r0+ueNucDG3HSk6Pikgm/Jc3lGWx4Ou1VMkc7Q/rEszsnVMkpiIxzd
         HKqoZhTdcCVEXgiy8at3jey5b6P2HVc76sDELvfXNAYCJyoUTN6kg+4trUl8F9MT0Yit
         5fB2rDnnTNLzbTVz8dBiFnlYMhVlvAkhoT/s/F4zomE4byn9UMita9CAoTHfMhr4k8zh
         7xCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=jWtSQkbe2YuYZ1n0kjKaScduaEbBsvlW+hl6qH8MNz4=;
        b=nLr6xVOr8bsCE0/QXDlOHX65VSVCK+KlM68pMj6hHl99zcabTrJUNmtB9DPVbYNrrR
         2mZC0yfL7jwomE7n4Qi/RM1U3AvhR60/5mVO+XEPRYAmJO6bwBOWgQ/bpscusVZZSJwR
         6eoSjRGkWpc/uwTyJcD7KwBB/camxfKbUV2zEPfSjskfVfDH+qQNIYqKshDDWMBdaOpf
         MXTX3eQrDB2ORkYoO3qe/1q3cdncZ+wtjx556+LbvP9yJcLIQwQgOqmgfzyP9q4YZv8U
         379ApBAHY1Kt1ae7EDyQOqjMnU5IzWsZOGq34QXOyRz4ECpH+B9s+dYBe2JBgGnV6B4K
         oNSQ==
X-Gm-Message-State: AFeK/H3OX1zr2KjFc90cFTVcjJ1zp9NVv4wSjO/SWBczTZjvkRh7x7EB6lm/rIlKeUW8j3DI0rpVmu9MYJ1iRw==
X-Received: by 10.223.172.55 with SMTP id v52mr2238171wrc.131.1490817767829;
 Wed, 29 Mar 2017 13:02:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.107.213 with HTTP; Wed, 29 Mar 2017 13:02:47 -0700 (PDT)
X-Originating-IP: [77.177.136.91]
In-Reply-To: <CAMX8fZXqTfKQXxV_pZEieN=1ap8ocVnnwZUvpGuw5rWo5_Yhfg@mail.gmail.com>
References: <CAMX8fZU-HeKzd8VYh8R=U8f8V-px+4V==M3CJSS677K0ErwPtA@mail.gmail.com>
 <CAGZ79kY1g-4c+GXZy3p-q=MsBY94esxsfs2=OPuhOH_o5oGc_Q@mail.gmail.com>
 <20170320221429.qefqowtwe2ptvgdg@genre.crustytoothpaste.net> <CAMX8fZXqTfKQXxV_pZEieN=1ap8ocVnnwZUvpGuw5rWo5_Yhfg@mail.gmail.com>
From:   Alex Hoffman <spec@gal.ro>
Date:   Wed, 29 Mar 2017 22:02:47 +0200
X-Google-Sender-Auth: u5k9wVrrB0Om3A3JZ5VWjMw5Eu4
Message-ID: <CAMX8fZXS4k5chezESM4pcaSfhG6WZ4xKxsWB0fpm4h-PQGjXwQ@mail.gmail.com>
Subject: Re: [PATCH] Correct compile errors when DEBUG_BISECT=1 after
 supporting other hash algorithms
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, Alex Hoffman <spec@gal.ro>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any news about this patch?

2017-03-21 22:24 GMT+01:00 Alex Hoffman <spec@gal.ro>:
> Hi, Brian,
>
> We definitely prefer the wrapper function oid_to_hex() to
> sha1_to_hex(). Thanks for feedback.
> Below is the updated patch:
>
> ---
>  bisect.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 30808cadf..7b65acbcd 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -131,7 +131,7 @@ static void show_list(const char *debug, int
> counted, int nr,
>                 unsigned flags = commit->object.flags;
>                 enum object_type type;
>                 unsigned long size;
> -               char *buf = read_sha1_file(commit->object.sha1, &type, &size);
> +               char *buf = read_sha1_file(commit->object.oid.hash,
> &type, &size);
>                 const char *subject_start;
>                 int subject_len;
>
> @@ -143,10 +143,10 @@ static void show_list(const char *debug, int
> counted, int nr,
>                         fprintf(stderr, "%3d", weight(p));
>                 else
>                         fprintf(stderr, "---");
> -               fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.sha1));
> +               fprintf(stderr, " %.*s", 8, oid_to_hex(&commit->object.oid));
>                 for (pp = commit->parents; pp; pp = pp->next)
>                         fprintf(stderr, " %.*s", 8,
> -                               sha1_to_hex(pp->item->object.sha1));
> +                                       oid_to_hex(&pp->item->object.oid));
>
>                 subject_len = find_commit_subject(buf, &subject_start);
>                 if (subject_len)
> --
> 2.12.0.400.g54ad2d445.dirty
