Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3401F4F8
	for <e@80x24.org>; Wed, 21 Sep 2016 09:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754938AbcIUJLe (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 05:11:34 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:33781 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754718AbcIUJLc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 05:11:32 -0400
Received: by mail-it0-f44.google.com with SMTP id x192so30141697itb.0
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oL6qRD9b7z3JyU6iOuBxsFbYglf2zQaDmkojMTXns0c=;
        b=Lm7JrwHor1Wi9fOq2SESONOQFkbkioNdwCb1PDsH4QyFq/DdWnR2w5Qze4aF4sXj5n
         Vjnyg1q6XXbr2QB72Md7j2PhrV+NOV2AXIxtPLeVQGWPay1/WogPM4qZ/WUm1OlsCw1s
         sx4KmSXWBphgvnXr+TQwrWwf2ATfJqr1wu1TM7t0DtalpPEoEkxNJwCUPib3bzsewZUN
         7UG1dtL7fdKJIj1Cjbfo0m6ssi5PbU/U77HyLilC2s/KUK3F/puI1YVVB8WCvHdhAHmz
         Co96VSkHR+FVoIE52OdTwkSYzci0k2LQ6B701saC8q8BSUC0t/Q71S9I2YtkxJ5rHRL8
         AzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oL6qRD9b7z3JyU6iOuBxsFbYglf2zQaDmkojMTXns0c=;
        b=VAnEBxMj/81uAaWF/oXbEaidOlPzeO1aYmdlumSunt6dNKXPAunZ94pPrcjsOAvezH
         E5xcKgLfuCGn6SUAkPLs9AAuLkP4eGwEo+PLlqYQ7dyGIiyKTnS0kswOvwbsxiVgqhY8
         VUdwauUEdCXSisKDHCz8uM+jvprvPIm/rzEJMqJVpsSZYgHZCoOB7Mghgda5OoRJFR+o
         WkbiupU80AYAMs0+CkC5rqaZunca1P9i9rNeEmt0IgJ3q+M2tUEn0iSN8uKc2+ejj1I1
         pbf+7qGCqRmXfDz+UpNUzekuB6+Z36S7u9vl7SE1SVDQyhd18vPuSq1R99MxURrH9/nQ
         1OXw==
X-Gm-Message-State: AE9vXwMUysRz/OkhkIBykoIhZbxFsfuiEmUr5HJ4pWxquVZqJbizzwyuvRNWjWWgrfL6QgPV1ejcctdsfhbRKQ==
X-Received: by 10.36.53.214 with SMTP id k205mr2662642ita.85.1474449091287;
 Wed, 21 Sep 2016 02:11:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Wed, 21 Sep 2016 02:11:00 -0700 (PDT)
In-Reply-To: <xmqqd1jzcvs5.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1jzcvs5.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 21 Sep 2016 16:11:00 +0700
Message-ID: <CACsJy8Dwe1n-YQfNMOyduLksNhAkAEPpBE3S0n==T-D1E0BneA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2016, #05; Mon, 19)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2016 at 6:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/checkout-disambiguation (2016-09-09) 4 commits
>  - fixup! checkout.txt: document a common case that ignores ambiguation rules
>  - checkout: fix ambiguity check in subdir
>  - checkout.txt: document a common case that ignores ambiguation rules
>  - checkout: add some spaces between code and comment
>
>  "git checkout <word>" does not follow the usual disambiguation
>  rules when the <word> can be both a rev and a path, to allow
>  checking out a branch 'foo' in a project that happens to have a
>  file 'foo' in the working tree without having to disambiguate.
>  This was poorly documented and the check was incorrect when the
>  command was run from a subdirectory.
>
>  Waiting for an Ack for fixup!

Oops, I didn't know (I have about 300 unread git mails in my inbox), Ack.
-- 
Duy
