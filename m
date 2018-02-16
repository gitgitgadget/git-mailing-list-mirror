Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0341F404
	for <e@80x24.org>; Fri, 16 Feb 2018 14:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034570AbeBPOz4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 09:55:56 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:34403 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033471AbeBPOzz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 09:55:55 -0500
Received: by mail-io0-f173.google.com with SMTP id e7so4388583ioj.1
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 06:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=X0FLCSnY51ajRhnTxpJdQbDnx/wEalqwcAXuo53DORU=;
        b=KeUZs3zyIDiu6k552nFnfP6myA5emkZQbrS766z9wzMzav/24jddBKnRuuT2Sj5vTU
         NWaqKH/jCEJ7vcEvONUA29woy25s/SWOtI7+nBghtK2mdIH2S6OdYMWynF29osImrtIl
         7UUX/guMCHkXJ+le5iBOII3l1gkm2dsa0qIyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=X0FLCSnY51ajRhnTxpJdQbDnx/wEalqwcAXuo53DORU=;
        b=GF/fz1QzpUk8V5D1rF9aM0Memfy+iMG1GILgtn8lZ4yP7TKF7AYGckjA/YEm290nng
         tJQJPIp2ViGhHRkq2YPlopM8rcmuMrpg67wATmDKx7IZneD3/z+qffvxUN2NEVqYV87Y
         jYhrMxsRO5KUrCr8c20+Cv0b9eiH8tqp5lQW5H/2H4iACpR7vYQtWtLLbk8ettSVkJQX
         3/flRKcKJTRWSwUfEY+t0PYrO5sVq15Bk94u4VrYtsdYTdqrfflowzaM2oPOLEI9XG0/
         s7FGuY+ZSd8YU5tBj4SCr3fmC5l1uKCdURCqKWArAII7J/cKdcJVnnn225+9YRNFXLHd
         Z/9Q==
X-Gm-Message-State: APf1xPBPzeQJFOj4Ot8k1Wgkgy9cBOtwTaik1SO8xmFNN0jswWMFCaoU
        HTuWGpZgRF1ZqgDDWSWOTTjDM2KChVXMOj6U52SOPw==
X-Google-Smtp-Source: AH8x224PPOUl+w1Qakze/1GOZoad9WwV1v2jzj2Li4H0H01FX83LDe0JztFy+GIeSvRaU+rrXb8cN5ZnAo9QclF8L/0=
X-Received: by 10.107.166.140 with SMTP id p134mr8281777ioe.272.1518792954828;
 Fri, 16 Feb 2018 06:55:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.58.86 with HTTP; Fri, 16 Feb 2018 06:55:13 -0800 (PST)
In-Reply-To: <01020161890f4388-f6427c9d-2be6-4628-afc9-bfaeb58b1ebe-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4388-f6427c9d-2be6-4628-afc9-bfaeb58b1ebe-000000@eu-west-1.amazonses.com>
From:   Adam Dinwoodie <git@dinwoodie.org>
Date:   Fri, 16 Feb 2018 14:55:13 +0000
X-Google-Sender-Auth: IjX6M8-w4YJgdXS5MN0s07nYerI
Message-ID: <CA+kUOamJowkxp0xAPf5FA+wBkiOjQeYzW1sKMwcatQBBA1qWpw@mail.gmail.com>
Subject: Re: [PATCH v3 22/23] cat-file: tests for new atoms added
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12 February 2018 at 08:08, Olga Telezhnaya wrote:
> Add some tests for new formatting atoms from ref-filter.
> Some of new atoms are supported automatically,
> some of them are expanded into empty string
> (because they are useless for some types of objects),
> some of them could be supported later in other patches.

This commit appears to be introducing failures in t1006 on Cygwin.
Specifically, tests 15, 36, 58 and 89, all titled "Check %(refname)
gives empty output", are failing on the pu branch at 21937aad4, and
git bisect identifies this commit, 3c1571744 ("cat-file: tests for new
atoms added", 2018-02-12), as the culprit.

I'm afraid I'm not going to have the time to investigate the failure
any further in the immediate future, but I wanted to report it
promptly in case you / someone else can see what's going wrong.

Adam
