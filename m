Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3DC1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 20:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbcJEUtg (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 16:49:36 -0400
Received: from mail.javad.com ([54.86.164.124]:37863 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750935AbcJEUtg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 16:49:36 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Oct 2016 16:49:36 EDT
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 87D0160BD1;
        Wed,  5 Oct 2016 20:41:52 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1brt0g-0001iT-Na; Wed, 05 Oct 2016 23:41:50 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] git-merge: clarify "usage" by adding "-m <msg>"
References: <cover.1475678515.git.sorganov@gmail.com>
        <773a11751c91c31a05c967ade902b0c8279aab56.1475678515.git.sorganov@gmail.com>
        <xmqqint6pu3b.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 05 Oct 2016 23:41:50 +0300
In-Reply-To: <xmqqint6pu3b.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 05 Oct 2016 10:46:16 -0700")
Message-ID: <87k2dmr0j5.fsf@javad.com>
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
>> "-m <msg>" is one of essential distinctions between obsolete
>> invocation form and the recent one. Add it to the "usage" returned by
>> 'git merge -h' for more clarity.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  builtin/merge.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index a8b57c7..0e367ba 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -43,7 +43,7 @@ struct strategy {
>>  };
>>  
>>  static const char * const builtin_merge_usage[] = {
>> -	N_("git merge [<options>] [<commit>...]"),
>> +	N_("git merge [<options>] [-m <msg>] [<commit>...]"),
>>  	N_("git merge [<options>] <msg> HEAD <commit>"),
>>  	N_("git merge --abort"),
>>  	NULL
>
> While this is not wrong per-se, as the deprecated form will go away
> soon, I hope you do not mind if I had to drop this one from the
> series to avoid merge conflicts to 'pu' (I do not know how bad the
> conflict would be yet; I am just reviewing in my MUA).

Yeah, sure. I was not aware obsolete form description is to go away
soon.
