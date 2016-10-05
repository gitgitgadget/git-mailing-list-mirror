Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E2C1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 21:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbcJEVeb (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 17:34:31 -0400
Received: from mail.javad.com ([54.86.164.124]:52860 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbcJEVeb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 17:34:31 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id E216160BD1;
        Wed,  5 Oct 2016 21:34:29 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1brtpc-0001tg-4U; Thu, 06 Oct 2016 00:34:28 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] Documentation/git-merge.txt: get rid of irrelevant references to git-pull
References: <cover.1475678515.git.sorganov@gmail.com>
        <b91ef5e97c60a85cce1a13f88a19218fd0f05655.1475678515.git.sorganov@gmail.com>
        <xmqqzimioc7s.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 06 Oct 2016 00:34:28 +0300
In-Reply-To: <xmqqzimioc7s.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 05 Oct 2016 11:57:43 -0700")
Message-ID: <87shsapjiz.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> sorganov@gmail.com writes:

[...]

>> @@ -138,14 +133,15 @@ will exit early with the message "Already up-to-date."
>>  FAST-FORWARD MERGE
>>  ------------------
>>  
>> -Often the current branch head is an ancestor of the named commit.
>> +Often the current branch head is an ancestor of the named commit.  In
>> +this case, a new commit is not needed to store the combined history;
>> +instead, the `HEAD` (along with the index) is updated to point at the
>> +named commit, without creating an extra merge commit.
>> +
>>  This is the most common case especially when invoked from 'git
>>  pull': you are tracking an upstream repository, you have committed
>>  no local changes, and now you want to update to a newer upstream
>> -revision.  In this case, a new commit is not needed to store the
>> -combined history; instead, the `HEAD` (along with the index) is
>> -updated to point at the named commit, without creating an extra
>> -merge commit.
>> +revision.
>
> I am not sure if the post-image of this hunk is better than the
> original.

That's what I've tried to explain in the description of the patch:

"No awareness of git-pull is required to understand git-merge operation,
so leave reference to git-pull only where it actually makes sense, in
the description of fast-forward merges, and only as clarification of
when this merging behaviour is mostly useful."

So I believe this change is inline with the rest of the patch. The
reference to git-pull (if it remains) should be a side-note, not part of
explanation of operation.

-- Sergey
