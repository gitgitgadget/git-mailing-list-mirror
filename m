Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10DBC1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 13:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfIZNMa (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 09:12:30 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:36948 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfIZNMa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 09:12:30 -0400
Received: by mail-ed1-f51.google.com with SMTP id r4so1958929edy.4
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 06:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2OH86WSpO7BepY9IYCdqoVI2cOumq0K4GlF0RmE4Apg=;
        b=qvdehZXmSwldev3XvbqryvMCUN2SITS3PgM0dUlx9wQt8C3/llGny0LbwZRUlPJyav
         EAIycJ//JuA9FkhQLEAXLHAk43B6HXH+aJtJ+t3w245i48rjuuB7X7YSJ94FVewI56hK
         ygq2N0KxlBqxvPL+jaOadtKYUv+g4CxFxwwqJ0zrnpvOgPWdAU+DGtVCqLrYb92DRv3U
         LFQFVCCwsMFFKsHC0hPBewZ2pj7Kc48hsgyuNQL/5rEr132LUZpozhD/1Rohk5aShvd2
         svSJssM5zCmwdEXPYlVaDbcjCV//9Fjm3qFA2TTeQJgRPjsmA3ahi1bjBgi8Udan0/pu
         DPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2OH86WSpO7BepY9IYCdqoVI2cOumq0K4GlF0RmE4Apg=;
        b=G5l+sqQj4msgqwBuZou7oHXGqEmocb3LKv5HoPlqNxNzAffJyKJd2E5txiHkGtAJa1
         7F31MwSvwXdLeCOPVrk2MPJAsvioFIw1t/9jOJomh9eG7EHwbhmrFGGB0Ow6OxyiFEUN
         bJmFDrKYN7jqBuhdOyBi7+8kUVGLizrKhqFDoaUWG5wJYPyw1fwdX1REjvgsDLWpk7l+
         JM4dAvmEgwDqb3tKxtSwD8yxgWO74KyjmdtNjpOW/dEFU/+ZKsmHCsVQr6kil7n2clUk
         O5RF2pwm7xTOjTgA8+CAcwbu0vGmdo8vBr9TihZSkNwwqVaHsVgJ7sLsC/UjpDdIQgvH
         eWRA==
X-Gm-Message-State: APjAAAWNHHOFNlzZcj/pOfA4qhIfAEucxorfSsLbkRreG7hGGf/5G7eD
        Bg1D/WbtClYvJ7niRNDHG6xtxYH4DetdLDreYDA=
X-Google-Smtp-Source: APXvYqyx32Fmj+eORwCB7Tk5RG5A0SnWLsjUH71jM0GhhunWAhyuK1VrxW2gGVWORlzIMR0ZmnU68EJtIJ6T/DGVTNI=
X-Received: by 2002:a50:908c:: with SMTP id c12mr3598620eda.45.1569503546870;
 Thu, 26 Sep 2019 06:12:26 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 26 Sep 2019 15:12:15 +0200
Message-ID: <CAP8UFD0gQU4JKneKc6HLxT6NutzZrxDVqWKDSeOx1ZYDfMkWRw@mail.gmail.com>
Subject: Number of Outreachy interns and co-mentors
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff and everyone,

On https://www.outreachy.org/apply/project-selection/#git it looks
like we will only have 1 intern as the title of our section is "Git -
1 intern". I wonder if it's because only funding for 1 intern has been
secured or if there is another reason.

Also I am not sure how people can register that they are ok to
co-mentor one of the project, but it looks like the person who
registered a project can invite co-mentors. So I think it would be
nice if people, who would be ok to co-mentor, could tell which
projects they would be ok to co-mentor, so that we all know and that
they can be invited to co-mentor on the site.

It would be great if we could have 2 (co-)mentors per project and it
would likely help getting funding for all the interns.

Thanks,
Christian.
