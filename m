Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A9811F87F
	for <e@80x24.org>; Fri, 23 Nov 2018 02:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392869AbeKWMm7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 07:42:59 -0500
Received: from mail-it1-f180.google.com ([209.85.166.180]:55017 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387473AbeKWMm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 07:42:59 -0500
Received: by mail-it1-f180.google.com with SMTP id a205-v6so16429102itd.4
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 18:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fEFaURG+UeZMxHgssC87/MvcypfFQKxPmpYtiOrTgwg=;
        b=qMWwQ9PV4Kyi4kKrhgXBMDAAdnplCSpHOjSmJqakrkVcL3BB+YEpFwwwhYkeKUIV45
         jDsb5GnzNu26Fevtlc3ek59CHYpLBjNmY2wQm8O1zCH5bnZegR8VOtvgcZd8OrLI/lkF
         xbZNXmY8MW1Vsm7yVtRwrnZ2mW0tQ5TbintK/Cffvkd6i/I3Q3VFwapj9xhzViueMzJy
         m3Mag/+N5MUsQlhC+/SYPtSZrATdccNjwdsv3+fJd22wgmnRlFhGhkwTgFU4yiF90loi
         KhlwvFpB6epcKF45uelgl4MuTMmvVUJkoACf5qeUAl4b7BBqE2SyETXLRfbp/KLLMGD2
         uWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fEFaURG+UeZMxHgssC87/MvcypfFQKxPmpYtiOrTgwg=;
        b=r7daHH94HtA8C8sk1yR5uYhiE9NRP5QNkS6qlufMmxPBvHK2+mZ1neLW1YVibs3ABI
         yxD1kOW6sjwMqcze4At90toaGCfJOVv0NXyjr9Tif9ET2ZdbvH+9yQTixKPbFi6vwBGC
         v05XQqf4u+c+20ewR9U5jga0wIwgtoemUIrVzu61iMw07rU2wX262foIcwZNKRG6JviV
         C/DimJymk4gON2+4lHU5VudJVwhHiA42jmFztL3hM14W4LuaE4ieGxWcOIa352WlDXWl
         CAGFPSWVSKeWRiKytsHVSQi6VhsGiHOjUcNCv6zrAhYhxqaheLHtWxUu2G+e2ryV7xl9
         8seA==
X-Gm-Message-State: AA+aEWbdnUmiC76QA0fUJ/Z45pSIsXcmB7rallZIog9Y0sJVCtkZXLSx
        PjnvsqeeuEiSVC4CzaqZtUpWDlwwGNRrFVlyMFM=
X-Google-Smtp-Source: AFSGD/U0y8vw47JczDWighhYzQiz4J0ecswFTlc9Sio3Jp/Qxu6cwcRAZKII6uSYmGMGBxfNmUMFeoy6FkOXzYVfpiE=
X-Received: by 2002:a02:1dc8:: with SMTP id 191mr9403091jaj.55.1542938449144;
 Thu, 22 Nov 2018 18:00:49 -0800 (PST)
MIME-Version: 1.0
References: <FTG.5ClN.5saZnXxVpgT.1Rzay9@seznam.cz>
In-Reply-To: <FTG.5ClN.5saZnXxVpgT.1Rzay9@seznam.cz>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Fri, 23 Nov 2018 13:00:13 +1100
Message-ID: <CAH5451mb894U4GGWRkax2XPr7GGQYmMezHvJM5BCyqR=BETL=w@mail.gmail.com>
Subject: Re: How to propagate critical fixs from master to develope branch.
To:     georg.black@seznam.cz
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi GB,

On Fri, 23 Nov 2018 at 04:23, Mgr Georg Black <georg.black@seznam.cz> wrote=
:
>
> Hello everyone.I red git manual but I can't figure out how to propagate c=
ritical change from master branch to long live develop branch. I red chapte=
r about rebasing that I think could solve it but at the end of this chapter=
 is written that it's not recommended for pubic repositories. I don't know =
how to do it without merging develop branch to master.
> I'll appreciate list of orders very much. :-)
> Thanks for any info or link.
> GB

A lot of what to do comes down to how you and your team work, and your
ongoing maintenance needs are.

The two methods I've seen used are to either cherry-pick the critical
change on top of whichever branches need it, or to build the change
from the oldest branch point that has the error, and then merging
those changes up to any maintained branches.

The cherry-pick method is quick and dirty, and doesn't require much
messing about.

The 'hotfix branch' method requires a bit more work to set up, but can
make it easier to see where the change is coming from and where it has
been applied. This fits in with the 'git flow' development methodology
(but doesn't require it).

A pretty good discussion of these ideas can be found at
https://stackoverflow.com/questions/7175869/managing-hotfixes-when-develop-=
branch-is-very-different-from-master

Regards,

Andrew Ardill
