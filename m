Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A8421F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 22:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfACWJy (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 17:09:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43580 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfACWJx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 17:09:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so34943519wrs.10
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 14:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fBUDxvN2UTib/pKT9ifB1cLEilyeSC0oHEx4VU5xyfQ=;
        b=DDjZELksDwhvfBhqyVDqavOQ5tYWQq/9c1wLn4mqDg1MfveVFDG6nKL3YzJofgjF8K
         zEwbMrbP8AJ4LZUXTop1yKs6ds7PDX2DHfJV41qFogPX8xV1vYUzrT2MXKT7FymiimS0
         nDskB2U657Y+dmi7fiTrzt/cxNn6EiLrES+Dt1rieokTLxZ8izi1LRir1alZiQ0eHlqo
         X6a3TN0Hyrcd5L77c7lwHw4+sVRj4Z+EmmxreZQyGxbYNmlhnV85I3A2ItphDoWUg9Kr
         BLo0XLPNy5km0lWkFURn8uzVcwIsDoAp2dEAJSXDx458k8xAv/EV1vW5wRNg5UmvOAEL
         XB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fBUDxvN2UTib/pKT9ifB1cLEilyeSC0oHEx4VU5xyfQ=;
        b=YQQqJARo+jMJUFoloVfLWVSj9tdEzSu9tj/+6gbrsi6C9/I6/j3baFyBa6MttTcXtW
         nDa0dbla1zYEsfZi8qlXn6aVHjn6/ANE/RPXOQbR1vpYPbfrAccO2+Sj7IPaVkp6aBOE
         Jun5y6uy0Wo2TIuzcL3LM02IkPrUyKpQEft7I1KrnWq00rjYcnwyXgS8nwvnShQdGhDU
         3yDDpk58ksnej5sLgVGk8V/H4BKdqWOuX9ycZJx+oXuxbYq2Ev4+VDAzlAcdTwBOzl74
         lzWAo4Vu/EdpGR/SERb0ytGJgtz4HhAnQhhi4UNxDZ+Uk2nml9P8zwFAKOco7aIZwsIA
         8+eA==
X-Gm-Message-State: AJcUukcqw4tzFhnXJ5M80uhfEjMXgaanz/kuAS8GKyUC4qen7A5FfItG
        LSCWfoib+fwSfPP/A31d3x4=
X-Google-Smtp-Source: ALg8bN6cHY7eNibRK+G1l+ECv3mpfp7k3toLzA6DjU3sN8W5YjDWT7O5iMGivrDfVW4Fq15rIkBfWg==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr46181865wru.245.1546553390670;
        Thu, 03 Jan 2019 14:09:50 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t12sm52738831wrr.65.2019.01.03.14.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 14:09:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Eric Sunshine'" <sunshine@sunshineco.us>,
        <randall.s.becker@rogers.com>, "'Git List'" <git@vger.kernel.org>,
        "'Randall S. Becker'" <randall.becker@nexbridge.ca>
Subject: Re: [Patch v5 3/4] git-compat-util.h: add FLOSS headers for HPE NonStop
References: <20190103210351.13920-1-randall.s.becker@rogers.com>
        <20190103210351.13920-4-randall.s.becker@rogers.com>
        <CAPig+cSdheCx-Ucnmg5eSXyNhyGPFF3L6N_Nc5uXQdc8Ytx2DA@mail.gmail.com>
        <007a01d4a3b0$8ae10000$a0a30000$@nexbridge.com>
Date:   Thu, 03 Jan 2019 14:09:49 -0800
In-Reply-To: <007a01d4a3b0$8ae10000$a0a30000$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 3 Jan 2019 17:06:08 -0500")
Message-ID: <xmqqk1jlfl5e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On January 3, 2019 16:41, Eric Sunshine wrote:
>> On Thu, Jan 3, 2019 at 4:04 PM <randall.s.becker@rogers.com> wrote:
>> > The HPE NonStop (a.k.a. __TANDEM) platform cannot build git without
>> > using the FLOSS package supplied by HPE. The convenient location for
>> > including the relevant headers is in this file.
>> >
>> > The NSIG define is also not defined on __TANDEM, so we define it here
>> > as 100 if it is not defined only for __TANDEM builds.
>> >
>> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> > ---
>> > diff --git a/git-compat-util.h b/git-compat-util.h @@ -397,6 +397,17
>> > @@ static inline char *git_find_last_dir_sep(const char *path)
>> > +#ifdef __TANDEM
>> > +#include <floss.h(floss_execl,floss_execlp,floss_execv,floss_execvp)>
>> > +#include <floss.h(floss_getpwuid)>
>> > +#ifndef NSIG
>> > +/* NonStop NSE and NSX do not provide NSIG. SIGGUARDIAN(99) is the
>> highest
>> > +   known, by detective work using kill -l as a list is all signals
>> > +   instead of signal.h where it should be. */
>> 
>> Style nit: With two minor exceptions, all other multi-line comments in this file
>> are formatted as:
>> 
>> /*
>>  * Multi-line
>>  * comment.
>>  */
>
> Doh! I just missed that one. I'll fix this on the next round, if that's ok.

Again, I've queued with a tweak already, i.e. no need to reroll only
to fix this one.

Thanks, both.
