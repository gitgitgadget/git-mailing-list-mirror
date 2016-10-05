Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08ED1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 20:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbcJEUyg (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 16:54:36 -0400
Received: from mail.javad.com ([54.86.164.124]:49863 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750935AbcJEUyg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 16:54:36 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 0CAE5633DB;
        Wed,  5 Oct 2016 20:44:46 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1brt3U-0001in-JJ; Wed, 05 Oct 2016 23:44:44 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 4/6] Documentation/git-merge.txt: improve short description in NAME
References: <cover.1475678515.git.sorganov@gmail.com>
        <a33dd3ec3da0dc2dad72ed85edd29ff01f898831.1475678515.git.sorganov@gmail.com>
        <20161005175512.aruzndaow3g2jmt7@sigill.intra.peff.net>
Date:   Wed, 05 Oct 2016 23:44:44 +0300
In-Reply-To: <20161005175512.aruzndaow3g2jmt7@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 5 Oct 2016 13:55:13 -0400")
Message-ID: <87fuoar0eb.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Oct 05, 2016 at 05:46:22PM +0300, sorganov@gmail.com wrote:
>
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
> I wonder if we should be more clear that you don't have to merge a
> branch; you can merge any commit. I do agree that the original was
> unnecessarily general. And I think "the current branch" is accurate
> (technically it can be to a detached HEAD, but that is pedantry that
> doesn't need to make it into the synopsis).
>
> So maybe "Merge one or more commits into the current branch".  I guess
> that is a bit vague, too. It is really "commit tips" or "lines of
> development" that we are merging. Bringing them in of course brings in
> many commits, but the "or more" there is meant to hint at multi-parent
> merges.
>
> So perhaps "one or more branches", while not completely accurate, is the
> best we can do. I dunno.

You've basically repeated my entire line of thinking that lead to the
patch.

-- Sergey.
