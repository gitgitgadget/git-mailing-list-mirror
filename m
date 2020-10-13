Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A10DC433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E819A251C0
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgJMPbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 11:31:44 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59989 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgJMPbo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 11:31:44 -0400
X-Originating-IP: 103.82.80.152
Received: from localhost (unknown [103.82.80.152])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 986331BF20C;
        Tue, 13 Oct 2020 15:31:40 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     ch <cr@onlinehome.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH] gitk: to run in a bare repository
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
        <20200123163151.GC6837@szeder.dev>
        <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
        <xmqqpnfa3sj1.fsf@gitster-ct.c.googlers.com>
        <xmqqk15i3rp7.fsf_-_@gitster-ct.c.googlers.com>
        <20200123192707.GA110440@coredump.intra.peff.net>
        <8be28321-3108-4846-ac6a-d5c7977774dc@onlinehome.de>
        <CAPig+cT1drHWic4bm=NPMd4RnGuLe-WwUJ-82nHkze_ZOoYerg@mail.gmail.com>
        <96216301-e831-3fd0-8bd8-8d0d752c580c@onlinehome.de>
Date:   Tue, 13 Oct 2020 21:01:38 +0530
In-Reply-To: <96216301-e831-3fd0-8bd8-8d0d752c580c@onlinehome.de> (ch's
        message of "Tue, 13 Oct 2020 16:25:10 +0200")
Message-ID: <87blh66t2d.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13 2020, ch wrote:

Hi,

Please avoid top posting.

> Sounds good. Thanks for the heads-up!
>
> Will the release also include a fix for git-gui (which exhibits
> similar behavior as gitk; see [0])?
>
> -ch
>
> [0] https://lore.kernel.org/git/3c1a3e23-cf52-48cc-e9b6-f80642ca67ac@onlinehome.de/

I'm seeing this patch for the first time. It was never formally
submitted to me. So as of now I have not queued it for the next release.
I'll take a look at the problem and see if the patch is the correct fix
and integrate it before the 2.29 release. But I don't have a lot of free
time so no promises.

>
> On 11.10.2020 07:08, Eric Sunshine wrote:
>> On Mon, Mar 30, 2020 at 11:21 AM ch <cr@onlinehome.de> wrote:
>>> On Thu, Jan 23, 2020 at 11:20:36AM -0800, Junio C Hamano wrote:
>>>   > Subject: [PATCH] gitk: be prepared to be run in a bare repository
>>>
>>> Sorry for bumping this thread but what's the integration status of the patch?
>>> The issue still seems to be present in v2.26.0.windows.1.
>> Junio just recently pulled commits into git.git from Paul's gitk
>> repository which contain this fix, and it looks like it will make it
>> into the Git 2.29.0 release.
>> 
>

-- 
Regards,
Pratyush Yadav
