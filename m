Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959051F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 21:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932141AbcJEVDO (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 17:03:14 -0400
Received: from mail.javad.com ([54.86.164.124]:35112 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752815AbcJEVDO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 17:03:14 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id CBEB960BD1;
        Wed,  5 Oct 2016 21:03:12 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1brtLK-0001ps-WC; Thu, 06 Oct 2016 00:03:11 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] Documentation/git-merge.txt: remove list of options from SYNOPSIS
References: <cover.1475678515.git.sorganov@gmail.com>
        <fa4e150ab54f9a01b4b7ca496dfe514d5e106ff6.1475678515.git.sorganov@gmail.com>
        <xmqqeg3upu0m.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 06 Oct 2016 00:03:10 +0300
In-Reply-To: <xmqqeg3upu0m.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 05 Oct 2016 10:47:53 -0700")
Message-ID: <8760p6qzjl.fsf@javad.com>
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
>> This partial list of option is confusing as it lacks a lot of
>> available options. It also clutters the SYNOPSIS making differences
>> between forms of invocation less clear.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  Documentation/git-merge.txt | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
>> index b758d55..90342eb 100644
>> --- a/Documentation/git-merge.txt
>> +++ b/Documentation/git-merge.txt
>> @@ -9,10 +9,7 @@ git-merge - Join two or more development histories together
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
>> -	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
>> -	[--[no-]allow-unrelated-histories]
>> -	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
>> +'git merge' [options] [-m <msg>] [<commit>...]
>>  'git merge' <msg> HEAD <commit>...
>>  'git merge' --abort
>
> Same comment as 1/6; as we'd hopefully be removing the deprecated
> form soonish, it would probably make sense to leave only two, i.e.
>
> 	git merge [options] [<commit>...]
> 	git merge --abort
>
> in synposis.

Same "yes" as in 1/6, obviously.

-- Sergey
