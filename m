Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE33C2095E
	for <e@80x24.org>; Fri, 24 Mar 2017 10:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756859AbdCXKZN convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 24 Mar 2017 06:25:13 -0400
Received: from mail5.fer.hr ([161.53.72.235]:28910 "EHLO mail.fer.hr"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750952AbdCXKY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 06:24:56 -0400
Received: from POSTAR.fer.hr (2001:b68:16:250::72:237) by MAIL5.fer.hr
 (2001:b68:16:250::72:235) with Microsoft SMTP Server (TLS) id 14.3.319.2;
 Fri, 24 Mar 2017 11:23:58 +0100
Received: from mail-lf0-f50.google.com (209.85.215.50) by POSTAR.fer.hr
 (161.53.72.237) with Microsoft SMTP Server (TLS) id 14.3.319.2; Fri, 24 Mar
 2017 11:23:58 +0100
Received: by mail-lf0-f50.google.com with SMTP id y193so3921871lfd.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 03:23:58 -0700 (PDT)
X-Gm-Message-State: AFeK/H0J2cfrO7QIUOFU5YZOPhGg0q+B6YtRIeQRkA2Ww2nFUD7DmLx1Pb2YBGMyyITER7/L8ZYkHsW5Z7nNmg==
X-Received: by 10.25.56.1 with SMTP id f1mr4088891lfa.83.1490351037393; Fri,
 24 Mar 2017 03:23:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.19.69 with HTTP; Fri, 24 Mar 2017 03:23:16 -0700 (PDT)
In-Reply-To: <42d1bc3de3bc488497928b4335f1dc41@MAIL.fer.hr>
References: <CAEPqvoxM9_Ku-1YgwNiqearUBaaYbAJcehuSwZYNNfJLQNH1_g@mail.gmail.com>
 <8a1179dfbb7743b6b8c23570306120b7@MAIL.fer.hr> <CAEPqvozCvFqOTNPw0c1ErKoOd+Mn1WCyJr9hj6CXiWWtL93Tqw@mail.gmail.com>
 <70bd7cfd05ae459dac94625bb78c26c3@MAIL.fer.hr> <CAEPqvoz8s=CVLABuXx-zOzryrXwr_cb39G2TYJvvFXRYzpCBFQ@mail.gmail.com>
 <42d1bc3de3bc488497928b4335f1dc41@MAIL.fer.hr>
From:   =?UTF-8?B?SnVyYWogT3LFoXVsacSH?= <juraj.orsulic@fer.hr>
Date:   Fri, 24 Mar 2017 11:23:16 +0100
X-Gmail-Original-Message-ID: <CAEPqvow38g-X0nCLwMsMW4T+uu0ouDUQNmOGZp6BG0yjwR6pTQ@mail.gmail.com>
Message-ID: <CAEPqvow38g-X0nCLwMsMW4T+uu0ouDUQNmOGZp6BG0yjwR6pTQ@mail.gmail.com>
Subject: Re: [git-gui] Amending doesn't preserve timestamp
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [209.85.215.50]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Igor! Thanks on for thoroughly searching the mailing list and on
your suggestions. I hope that someone will come up with a fix that
both preserves the author details and date correctly.

Regards,
Juraj


On Thu, Mar 23, 2017 at 11:54 PM, Igor Djordjevic
<igor.d.djordjevic@gmail.com> wrote:
> Hi Juraj,
>
> On 23/03/2017 15:26, Juraj Oršulić wrote:
>> Hello Igor (and others), I have something else to report about the
>> commit amend functionality in git-gui, and I think it could be
>> related to my original question. It seems that git-gui messes up
>> international signs on amending.
>>
>> E.g. I use git gui to make a commit, and all is OK:
>>
>> commit ef24b133dda6c18b8ef01b1a38f9e049d87f2021
>> Author: Juraj Oršulić <juraj.orsulic@fer.hr>
>>
>> I open git gui again, click "Amend Last Commit", press "Commit", and I
>> get this in git log:
>>
>> commit 6e09ff9edcef863d92f02cf86e0307c27171aec0
>> Author: Juraj OrÅ¡uliÄ<U+0087> <juraj.orsulic@fer.hr>
>>
>>
>> Does anyone have any idea what could be the cause?
>>
>> I tested this on Ubuntu 16.04 and HEAD vearsion of git-gui on
>> http://repo.or.cz/git-gui.git, currently 0.21.0.5.g5ab72.
>
> Yes, I can confirm this.
>
> git version 2.12.1.windows.1
> git-gui version 0.21.GITGUI
> Tcl/Tk version 8.6.6
>
> That said, it seems there are quite some topics about it, like [1],
> [2], [3] and [4], but the most interesting one could be [5], having
> some kind of a "workaround" at the end as well.
>
> I`ve tried replacing the "commit.tcl" file as proposed, and it seems
> to work correctly -- just please do note that it actually reverts the
> file in question to an older version, maybe (re)introducing other
> bugs while fixing this specific one, so it could be something you may
> want to investigate into a bit more before actually using it for good.
>
> P.S. It might be a good idea to start a new topic in situations like
> this (send out a new e-mail instead of a reply), keeping unrelated
> discussions separated and helping interested parties spotting the new
> topic more easily.
>
> Regards,
> Buga
>
> [1] https://public-inbox.org/git/588ac268-0a1b-6787-e6a1-4164e7e9a784@b-i-t.de/T/#ea05ebbde162f9c230a2cc4f7099363aed68768f6
> [2] https://public-inbox.org/git/52E1627956F20E458D872C5961027EDC654FE17C@SGDS00759.zf-lenksysteme.net/T/#m0baea8c76e79f25bf92ca0deabe38efec2ee168d
> [3] https://public-inbox.org/git/50913C58.2000200@drmicha.warpmail.net/T/#m72664106ad3070235ea2628b61fc6203fbb5563e
> [4] https://public-inbox.org/git/20071212091744.GA5377@pvv.org/T/#m8490dd348389b4eea82eb1bdaab69227c946de19
> [5] https://github.com/git-for-windows/git/issues/761
