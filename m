Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11ECE1F461
	for <e@80x24.org>; Tue, 23 Jul 2019 01:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfGWBNp (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 21:13:45 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:43824 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfGWBNp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 21:13:45 -0400
Received: by mail-io1-f54.google.com with SMTP id k20so78203942ios.10
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 18:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SilM8RvjDPhbcaX/3F6OLE6owQtPrKbOUtFac0MSz7Y=;
        b=TrMuhERV9mtGWcHgpIppA3LZRkY5xTpjLH8xDK5bRnXhY9OYV+CkuNoa6tiWN2uROs
         Yi6wVe4UeGhj+X09feVZN8mhtm0w2JVbGRK0eng3MI77svaUa8XmtTpe9Qiy6q7fGWw+
         damZfmzhKhWahs3ivaxsSwKKbEjc1phl94ZWERwzM1zXWLTI87qLruNyWaeVHIH+20it
         AyQLZHJKBAYNjpoJRlQQcSnJ+1/b9Vxl+kVpTN4Ci+Q8ZxG4Cr3xGX2KY+lFRRcpZawf
         R0GTgAA9Tc5QFYQOt2CiDmnMpynQm1ngOoz1B0axMhu9gb2AIU/A4fqHP8+xpjRiscjq
         b/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SilM8RvjDPhbcaX/3F6OLE6owQtPrKbOUtFac0MSz7Y=;
        b=EZOcnDnV6ptZ+5iVXMFOSjjo7PRb5TSyoR6LPfbU7/KICQo6q+aF5zhoEulptg3SSS
         rwRBktcPEyiRHUiWwvvoIh6Bv868AGne73+2LgPZgTTne+YyeGZQ/Com5wlE+c169svM
         QyjSVk8dPWEVLtSH7Cepl9dzBzHMeLfEUS4rRt14XFhuoa3vopyVKrla2j4YVu/bl2YS
         Cj1mzptLsC8o7QHljEaAIfQgMKFpwhdRDbssRuRMqY0UTK7xGaN+GsNWoMpSl3BZfhXm
         o97+ODpCa7WIwCCNH+weJKbDVUk3TKXmmo6Jqa79r8bMU8Knpe+cj0Yr5tfFOjyceoP1
         4msg==
X-Gm-Message-State: APjAAAU+PkDdarW2QMfhBRRiqzGyEdwiT064/uW2d3Z8WTPL80BDmyh2
        6+JznEjhYp1S6Tb1y6q1Vgma8a/INHvPikY+LFUPKA6bP3E=
X-Google-Smtp-Source: APXvYqyz68fvTCU0j1bKAojrK58yl8lqnOqGWedE53uCOfIRoTbRMQcdcuWeVJoYdVt+AbPR4mlyp9rHIZdUZ4ah5cw=
X-Received: by 2002:a5d:9613:: with SMTP id w19mr30837529iol.140.1563844424262;
 Mon, 22 Jul 2019 18:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
In-Reply-To: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 22 Jul 2019 22:13:33 -0300
Message-ID: <CAHd-oW42zTcbeCC=eAmZ16B4MF4+jrOaUwHtO969f6jcoiSGDA@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

Unfortunately, not quite much to report this week :( I'm attending
DebConf until July 28th but I'm trying to conciliate that with the
work on my project. You can see my brief report of last week here:
https://matheustavares.gitlab.io/posts/week-9-an-rfc-on-parallel-inflation

As always, every comment is highly appreciated.

Thanks,
Matheus
