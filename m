Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E51A1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 15:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755778AbeDTP1m (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 11:27:42 -0400
Received: from mail.efficios.com ([167.114.142.138]:43436 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755550AbeDTP1l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 11:27:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A7C731B3351;
        Fri, 20 Apr 2018 11:27:40 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail02.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2zqTzeC86-BZ; Fri, 20 Apr 2018 11:27:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DA4931B3349;
        Fri, 20 Apr 2018 11:27:39 -0400 (EDT)
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail02.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Jut39y1aGT25; Fri, 20 Apr 2018 11:27:39 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C5B661B333A;
        Fri, 20 Apr 2018 11:27:39 -0400 (EDT)
Date:   Fri, 20 Apr 2018 11:27:39 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>
Message-ID: <666133236.13971.1524238059705.JavaMail.zimbra@efficios.com>
In-Reply-To: <xmqqtvs6d9r6.fsf@gitster-ct.c.googlers.com>
References: <20180418140503.GD27475@bombadil.infradead.org> <87tvs8e174.fsf@evledraar.gmail.com> <xmqqr2ncgqhl.fsf@gitster-ct.c.googlers.com> <20180419121024.GD5556@bombadil.infradead.org> <646938104.13100.1524141300699.JavaMail.zimbra@efficios.com> <xmqqtvs6d9r6.fsf@gitster-ct.c.googlers.com>
Subject: Re: [PATCH] git-send-email: Cc more people
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: git-send-email: Cc more people
Thread-Index: ZMhmR9Y+h2WJT8zHhXLME5brukc84Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

----- On Apr 19, 2018, at 8:03 PM, Junio C Hamano gitster@pobox.com wrote:

> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> 
>>>> I'd further say that these new CC-sources should be disabled by
>>>> default and made opt-in to avoid surprising existing users.
>>> 
>>> But I disagree with this.  The current behaviour is surprising to
>>> existing users, to the point where people are writing their own scripts
>>> to replace git send-email (which seems crazy to me).
>>
>> We could perhaps go with a whitelist approach. The four
>> main match I would be tempted to add are: Acked-by, Reported-by,
>> Reviewed-by, and Tested-by.
> 
> A tool that suddenly starts sending e-mails to more addresses
> without letting the end-users know when and why the change in
> behaviour happened is a source of irritated "somebody made a stupid
> change to git-send-email without telling us that caused unwanted
> e-mails sent to unexpected places and embarrassed me" bug reports.
> I do agree with a whitelist approach from that point of view, and in
> the initial rollout of the feature, that whitelist should be limited
> to what we already send out.
> 
> The users who learn about this new feature can opt into whitelisting
> the common 4 above before we enable them by default.  FWIW, I
> personally think these will be a sensible default (in addition to
> what we already Cc).  I however prefer an approach to introduce
> these more gradually.

Sure, introducing changes like this needs to be done gradually.

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
