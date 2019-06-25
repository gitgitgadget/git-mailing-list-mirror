Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54141F461
	for <e@80x24.org>; Tue, 25 Jun 2019 09:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfFYJxt (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 05:53:49 -0400
Received: from forward501o.mail.yandex.net ([37.140.190.203]:43478 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729742AbfFYJxs (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Jun 2019 05:53:48 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 05:53:46 EDT
Received: from mxback1j.mail.yandex.net (mxback1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10a])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id ED9AB1E80B32;
        Tue, 25 Jun 2019 12:45:43 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id TJnXUGDuMv-jg80OK9u;
        Tue, 25 Jun 2019 12:45:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1561455942;
        bh=TTvE/Ly6URKL7066sOrpnvHAawGnRcaMwQFKiqhC8ao=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=wE6TuSbtk2OWuf3nPZajCGuYQDGJOuNGTU8FUhjw9VvMGrUbWlGRI2BmDm6NrITmF
         F8jLAJ45LY/Js/ldRK6xTXL2pSTpTp5uiuaUwEZ2cw7lqr2E8eJ31H8/68I4uZWQ7e
         RsEodjLE3iQk0zOPbOStxY/y8KAAhFs+rd44fwTA=
Authentication-Results: mxback1j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-a1efad875d04.qloud-c.yandex.net with HTTP;
        Tue, 25 Jun 2019 12:45:42 +0300
From:   Andrey <ahippo@yandex.ru>
Envelope-From: ahippo@yandex.com
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>
In-Reply-To: <xmqqmui6j4mk.fsf@gitster-ct.c.googlers.com>
References: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
                <1748011561196810@sas2-7b909973f402.qloud-c.yandex.net> <xmqqmui6j4mk.fsf@gitster-ct.c.googlers.com>
Subject: Re: What's cooking in git.git (Jun 2019, #05; Wed, 19)
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 25 Jun 2019 05:45:42 -0400
Message-Id: <8406251561455942@sas2-a1efad875d04.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



24.06.2019, 13:05, "Junio C Hamano" <gitster@pobox.com>:
> Andrey <ahippo@yandex.ru> writes:
>
>>  20.06.2019, 00:35, "Junio C Hamano" <gitster@pobox.com>:
>>>  * am/p4-branches-excludes (2019-04-02) 8 commits
>>>   - git-p4: respect excluded paths when detecting branches
>>>   - git-p4: add failing test for "git-p4: respect excluded paths when detecting branches"
>>>   - git-p4: don't exclude other files with same prefix
>>>   - git-p4: add failing test for "don't exclude other files with same prefix"
>>>   - git-p4: don't groom exclude path list on every commit
>>>   - git-p4: match branches case insensitively if configured
>>>   - git-p4: add failing test for "git-p4: match branches case insensitively if configured"
>>>   - git-p4: detect/prevent infinite loop in gitCommitByP4Change()
>>>
>>>   "git p4" update.
>>>
>>>   Is this ready for 'next'?
>>
>>  Junio,
>>
>>  I haven't got any new feedback on the patch series in the past 2.5 months.
>>  From my point of view, these are ready for next.
>
> Thanks. When I ask "Is this ready", I am asking for opinion(s) from
> third-party, not self nomination ;-)

Ah, ok, sorry. :)
I just haven't seen any related comments to any of your previous "What's cooking" emails,
so thought I should send a keepalive email just in case.

> Let's merge it down to 'next' and to 'master' anyway.
Thank you!
That'll be great!

-- 
Andrey.

