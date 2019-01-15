Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BD7E1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 13:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfAONvA (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 08:51:00 -0500
Received: from mout.gmx.net ([212.227.17.21]:50255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbfAONvA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 08:51:00 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDn8s-1gTRbD0lpe-00H7Is; Tue, 15
 Jan 2019 14:50:49 +0100
Date:   Tue, 15 Jan 2019 14:50:32 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH 6/7] Git.pm: introduce environment variable
 GIT_TEST_PRETEND_TTY
In-Reply-To: <fd6bab55-871c-4f4d-84e9-98bfe5d54f23@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1901151448570.41@tvgsbejvaqbjf.bet>
References: <pull.103.git.gitgitgadget@gmail.com> <86d85face8ba543fb4a03adbc42dc930ee318f74.1545307756.git.gitgitgadget@gmail.com> <fd6bab55-871c-4f4d-84e9-98bfe5d54f23@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:M14vL7cAgHkiYxbmTBoiShn+2pB2zYgM3y2px/1RX/5xV9iL01n
 Ov8X7YcLOQSt6HgucKRoeutYwUSbQ6FHsH4d2xdQSUb5k7LSFQfMi8HIDmN6kJ5MmUeOQk7
 qyW2lJT5eCTN9ddxxQ3dQZ0Fl76m3g3LKmbVWW2Tuyv1Sn/MfiY3/ScCiWlE+z3kfPZ/s0X
 sPKdwpJuQDuwoP0IBg9KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jx4/zUTlny8=:d0Vrjcjqz9Dr8MIb/qLMt0
 y+nBEw6lBPcMCmTWQ0uCG4ndDWOHXkl+WJZAoxU/XuZyB6Ky9bDumPEzMCmocN8fhsTFZyyym
 p5cGUwdr9TuuWE+uaBZbYqtP+ymC+jU2d2cj6ybeOGapTaHfXMATYGaL6kLhvxFULYlbryqCI
 TUYaBaEDueUbaxdckgHqr+NoRZ9AnJPJeFJ0HXDcy8TlUt7zI6sFXqQKbx71BHz9+jdw1kmjq
 wh9o0/NyUPhWFT8XO4K2lbR3It+caWW+uynTHqBz60JOfGG2kIE8yPWvaaba93l46A19J7TX/
 q+an7fr+4Y0ZHwQNw94kHheSPKmmNOLl7fmGNlxvupQPN5wWXXdjvJmqk9K9HiJXgJXUHUSLn
 1C4qtKrjwpzH7maluFqSLIuCfrVbgFEyHr8ooGEhgptwmaDkffwCFC9oDFDRjIKW1WT98JCd3
 3lwrNe0hFjNMOrkpuGuDGtW7FDnDDHGgYRfnU+TvkE+G2D5kKu1VMAelFBxsMXiwjFxr6XvQo
 c0BQGTUq0eJ0XZgWZ6QKWKyzdslPKpYuAVqRnqzkGbgxa+VEdgmVg972c6WfDIGBl/oGRLCMY
 JjD3ZyfEVf2a7PWv83/vE9/2gbok1y1mNSY0I2L6yToASrSuinMQpAV8RpuSRNusYodPad/Op
 0WW+5nm8KFA84RJmHnUA+pdPlehlcGJsDLVSexe4E31gbhoR2Q1iub4wtWSjUi0JtVJ7VSeX+
 h3eVcUIhvDh/9hcpEa0mHhJ2nAwach/2zABrNS0yDb3zGHQMVulmshnM/vdETPEVK/wScdmxW
 fRUthYYYw4ms93V41kwQU7+BS7bxtZKtQps3gGTQAGGPosqLbvotZd4SEKasg0T/f77Ip3/Vr
 fbUqvUzeyPMFKH4kbGns4YZmvW6k2DyOHTTrpKIP880QyMzh+1rbC2EMOn80l/EcW9hraFScQ
 eUOY9Dl0ILA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 14 Jan 2019, Phillip Wood wrote:

> Hi Salvica/Johannes

Close ;-)

> On 20/12/2018 12:09, Slavica Djukic via GitGitGadget wrote:
> > From: Slavica Djukic <slawica92@hotmail.com>
> > 
> > To enable testing the colored output on Windows, enable TTY
> > by using environment variable GIT_TEST_PRETEND_TTY.
> > 
> > This is the original idea by Johannes Schindelin.
> 
> I normally use GIT_PAGER_IN_USE=1 to force colored output, is there some
> reason that does not work here?

As Slavica found out, you need to set `TERM`, too, for that to work. And
even then, it is more of a "happens to do what we want" rather than a
"this is what we want to happen"...

But I'm fine either way, the color code does not really *need* more
complexity, as it were...

Ciao,
Dscho
