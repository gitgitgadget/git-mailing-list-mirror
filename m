Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4600E1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 21:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755196AbcJEVCV (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 17:02:21 -0400
Received: from mail.javad.com ([54.86.164.124]:48639 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754973AbcJEVCC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 17:02:02 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id A73F560BD1;
        Wed,  5 Oct 2016 21:02:00 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1brtKB-0001pa-0u; Thu, 06 Oct 2016 00:01:59 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] Documentation/git-merge.txt: improve short description in NAME
References: <cover.1475678515.git.sorganov@gmail.com>
        <a33dd3ec3da0dc2dad72ed85edd29ff01f898831.1475678515.git.sorganov@gmail.com>
        <xmqqa8eiptt2.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 06 Oct 2016 00:01:59 +0300
In-Reply-To: <xmqqa8eiptt2.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 05 Oct 2016 10:52:25 -0700")
Message-ID: <87a8eiqzlk.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> sorganov@gmail.com writes:
>
>> From: Sergey Organov <sorganov@gmail.com>
>>
>> Old description not only raised the question of why the tool is called
>> git-merge rather than git-join, but "join histories" also sounds like
>> very simple operation, something like what "git-merge -s ours" does.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  Documentation/git-merge.txt | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
>> index 216d2f4..cc0329d 100644
>> --- a/Documentation/git-merge.txt
>> +++ b/Documentation/git-merge.txt
>> @@ -3,7 +3,8 @@ git-merge(1)
>>  
>>  NAME
>>  ----
>> -git-merge - Join two or more development histories together
>> +
>> +git-merge - Merge one or more branches to the current branch
>
> This patch, evaluated by itself, looks like a regression in that it
> tries to explain "merge" by using verb "merge", making it fuzzier to
> those who do not yet know what a "merge" is.  That was why it tried
> to explain "merge" as an operation to join histories.

My thought was that "merge", the operation, is so well-known term that
it could well go into the NAME section without explanation.

Besides:

$ man merge
NAME
       merge - three-way file merge
[...]

Uses the same pattern.

>
> However, the next one, 5/6, resurrects the "join history" in the
> description part to help them, so the damage is not so severe when
> we take them together.

Damage? In SCM world we can track the issue back to:

$ man -k rcsmerge
rcsmerge (1)         - merge RCS revisions

-- Sergey
