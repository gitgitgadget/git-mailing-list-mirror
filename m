Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E319B1F405
	for <e@80x24.org>; Sat, 29 Dec 2018 09:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeL2JKM (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 04:10:12 -0500
Received: from mail.javad.com ([54.86.164.124]:44735 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbeL2JKM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 04:10:12 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 46EB03EA6F;
        Sat, 29 Dec 2018 09:10:11 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=pTHgU6SY;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1546074611;
        bh=1NlCyjEv+PTaG1S/l98sPBs3imBaQHqNyVL75CK/08E=; l=491;
        h=Received:From:To:Subject;
        b=pTHgU6SYJJy7UnGD63qZaUyoWjQFsdGGlqdEk0alVx1R11jrOHX+KBtionE9wsfpy
         fLJpTObO9B2x7LmgFZG0JWYkJ/w9gRshYst59gevl3jGO3XYRB1+tMKpy5yhQ3OA8F
         PJ081fmw5LMLzjrbs3H/kJeIVhIdu1RYRNJVZDGs=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1gdAdF-00007C-JA; Sat, 29 Dec 2018 12:10:09 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Allow 'cherry-pick -m 1' for non-merge commits
References: <xmqq5zvwesvz.fsf@gitster-ct.c.googlers.com>
        <cover.1544762343.git.sorganov@gmail.com> <87tvj1ok4k.fsf@javad.com>
        <xmqqr2e1mmuu.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 29 Dec 2018 12:10:09 +0300
In-Reply-To: <xmqqr2e1mmuu.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 26 Dec 2018 14:52:07 -0800")
Message-ID: <87sgygem1a.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com>, Sergey Organov
> <sorganov@gmail.com> writes:
>
>> Hi Junio,
>>
>> What's the status of these patches?
>
> The status of these patches is "Just updated on the list", as far as
> I am concerned, and its cover letter would have described what's
> improved relative to the previous round better than whatever answer
> I could give here ;-)

Yeah, I need to be more thorough, thanks!

-- Sergey
