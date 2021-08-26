Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A681C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 11:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7562960FDA
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 11:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245023AbhH0LlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 07:41:04 -0400
Received: from shark2.2a.pl ([213.77.90.2]:65010 "EHLO shark.2a.pl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233376AbhH0LlD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 07:41:03 -0400
Received: from wrasse.2a.pl (wrasse.2a.pl [213.77.90.7])
        by shark.2a.pl (Postfix) with ESMTP id 6DC281750881;
        Thu, 26 Aug 2021 22:52:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 2a.pl
Received: from shark.2a.pl ([213.77.90.2])
        by wrasse.2a.pl (wrasse.2a.pl [213.77.90.7]) (amavisd-new, port 10024)
        with ESMTP id vgqTNWRvy8Vm; Thu, 26 Aug 2021 22:52:38 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.8.1.26])
        by shark.2a.pl (Postfix) with ESMTPSA id D4AB21750882;
        Thu, 26 Aug 2021 22:52:38 +0200 (CEST)
From:   Krzysztof =?utf-8?B?xbtlbGVjaG93c2tp?= <giecrilj@stegny.2a.pl>
To:     Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Subject: Re: git log --encoding=HTML is not supported
Date:   Thu, 26 Aug 2021 22:52:36 +0200
Message-ID: <3883941.fE8Og5qy2N@localhost.localdomain>
In-Reply-To: <xmqq5yvsgqt7.fsf@gitster.g>
References: <9896630.2IqcCWsCYL@localhost.localdomain> <CAGyf7-FhLQKQyCOishyrZHg0J+jk6=aszE3hMoH=L0j+0+TP7Q@mail.gmail.com> <xmqq5yvsgqt7.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dnia czwartek, 26 sierpnia 2021 17:37:40 CEST Junio C Hamano pisze:
>         git log --html \
>                 --format='<tr><td>%h</td><td>%s</td>...</tr>'

I would like to be able to say:
 { git config i18n.logOutputEscape HTML; }

What do you think?

Chris




