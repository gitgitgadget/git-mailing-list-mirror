Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF9F81F461
	for <e@80x24.org>; Thu,  4 Jul 2019 10:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfGDKke (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 06:40:34 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:10373 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfGDKkd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 06:40:33 -0400
Received: from [192.168.1.22] ([89.243.190.203])
        by smtp.talktalk.net with SMTP
        id izAFh6cf7nuQZizAFhluWX; Thu, 04 Jul 2019 11:40:31 +0100
X-Originating-IP: [89.243.190.203]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=eLyEXkeXgyqjrUSteAL3aw==:117
 a=eLyEXkeXgyqjrUSteAL3aw==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=N57GPqcwrc3o7O2WbGwA:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH] make slash-rules more readable
To:     "Dr. Adam Nielsen" <admin@in-ici.net>, git@vger.kernel.org
References: <20190604173446.2664-1-admin@in-ici.net>
 <bd722415-1547-8db5-f88a-c35c8b48d8be@in-ici.net>
 <13f99ce6-f856-6554-5c14-1b1838d697d0@iee.org>
 <d1d2ebec-a94a-0092-4a6d-8ae32db1573b@in-ici.net>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <b33e42c2-96a7-88d8-03b1-2da317dfa692@iee.org>
Date:   Thu, 4 Jul 2019 11:40:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d1d2ebec-a94a-0092-4a6d-8ae32db1573b@in-ici.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfKnn0NHUMtNtRBqGtrH/5DAFfUyPahBuFF8XL8Do27EZpWloKofaBAzm9J4rL8U5LMe6d+Ijd1/J45qgF/Y5n53/tpYbcr5UzNssWaomsizuW0vkdnFm
 ZY7ROd+VYak+Iz8E5EJjdR9261TnQ9m4mA1knogoHVR1ITA6QSHE5K3xdP8XNMneJh2+UNBjGFoaMEP0pJF617/sd9KqcgI/ym0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/06/2019 18:10, Dr. Adam Nielsen wrote:
>
> On 25.06.19 13:31, Philip Oakley wrote:
>> only one minor point...
>
> >>> + - For example, a pattern `doc/frotz/` matches `doc/frotz` 
> directory,
> >>> +   but not `a/doc/frotz` directory; however `frotz/` matches `frotz`
> >
> > her I misread this as:  "but not a `doc/frotz` directory;"
> > i.e. the leading 'a' is too easy to skim over as is part of the
> > sentence's prose, so maybe change to a 'baz' lead directory (bar 
> already
> > having been used below).
>
> Yes we could change that.
>
>> Have you tried it out on any StackOverflow replies to see if those 
>> that inhabit that zone find it helpful?
>> Philip
> I answered one person who had a hard time reading the docs at SO, but 
> he didn't respond and the last time he was online was 2018, so I 
> didn't made the effort to edit my answer with the current version.
>
> -
>
> What are the next steps? If there are no more responses, does it imply 
> that everyone agrees with this patch? Can we publish it online?
>
If all the issues are cleared then I believe it is a case of providing a 
clean reroll (maybe identical to previous..) to Junio and the list to 
confirm that all issues have been resolved and it is ready for 
pu->next->master in the normal way, which should then show up in his 
'What's cooking' emails.
