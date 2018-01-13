Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0431F406
	for <e@80x24.org>; Sat, 13 Jan 2018 02:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965407AbeAMCvx (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 21:51:53 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34057 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965368AbeAMCvw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 21:51:52 -0500
Received: by mail-wm0-f54.google.com with SMTP id 81so4724593wmb.1
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 18:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QB22WK56DOz+h6q7d+rTVJuTZL4nTKbxzMvyQpsuHMs=;
        b=Ks2uCv2KCd1yZqBshG4Jk3MX9alEYa/8qMzb6WNF0z99VS0tLUK4fNSl/SJa1hqaxM
         XSxEhg8uQ7PIO+/vH2Wm7esLGUAYSR0Y2/Buy4UgcC0cSVHRtnRttczaNd/5N94WOES8
         kVCKldfWobn7gVfxvlYc1kU67/K5Z1SShiDVfQFiHZsyjeN0P6v8Lpq5ePrhwIVZ4lu/
         GlMTdF38MiASmynT3xjz6d0eEV7gBs3/Mxj/ykV9ADRF/pr+zZIHg/Ru1s41oe96nSAb
         V2MQpO1Kdvi9MKYMOD++f3YHt1i699CHY/WS4DzqDfCzCZGiLmltC/iAPQUmNS0msEs0
         hzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QB22WK56DOz+h6q7d+rTVJuTZL4nTKbxzMvyQpsuHMs=;
        b=pOoHoZsEoWuQHSkJxp/mXSszvlWEqB4CNwhc/ZitvJV1OO3dOXJ02AspqDwkQot3l1
         pcFg3L5fdjQZOn+mD/IqzAL98e2msfBYoC0ev0zPT5uZnnTP6V9Km55LN5vJXmRYv9Dn
         H1a7fzAnqVVZnYYJXsPFpkjZxyzDuR6p/L2wgIbdeq9CUG2dTfw5/2AlnVgITt9MWZ7U
         Yoz93dMIOVXmw4xdfRG843BWc2MQfkjHP8ErFsusP/A9WRNkPzsPhqfQsuPgNW8gXnqe
         iVtd/Uha1oYdtwRyJ5fKqM501B+BmR8/c/NpehfLDVvEfLVHP/zy6IP2uLspvUK5EsgT
         T0sA==
X-Gm-Message-State: AKwxytc+cibAC9QYBkdAChCXlB3B+0r8DZFVPR6USXD/j1r0PmvSSivb
        t/YkyE3eui/V/eGgtMACXTOG59P8YmoskWDzRRh05Q==
X-Google-Smtp-Source: ACJfBoucRy3QHiBA8rMmhPPoOY3KTF2xAoqSmbUUj+HLdJKD0evBqSZS2gAXniDyLzV5urfygBW9q/Vkx2IrvvFggnA=
X-Received: by 10.28.132.207 with SMTP id g198mr5284337wmd.118.1515811911480;
 Fri, 12 Jan 2018 18:51:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.107.150 with HTTP; Fri, 12 Jan 2018 18:51:51 -0800 (PST)
In-Reply-To: <xmqqy3l2ves2.fsf@gitster.mtv.corp.google.com>
References: <004b01d38bdd$7a11da60$6e358f20$@nexbridge.com>
 <xmqqd12ewx1v.fsf@gitster.mtv.corp.google.com> <008f01d38bfa$7eba9bc0$7c2fd340$@nexbridge.com>
 <xmqqy3l2ves2.fsf@gitster.mtv.corp.google.com>
From:   Tanay Abhra <tanayabh@gmail.com>
Date:   Fri, 12 Jan 2018 20:51:51 -0600
Message-ID: <CAEc54XAP0jFuD4J_XUZOuHEBZ+6PceEQbpm7HJEtRt4NS7Lf2A@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc2 - breakages in t1308 and 1404
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 5:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
>
> > Sadly, fixing the "except" thing causes the test to break now.
>
> That is exactly what I wanted to say.  If you want to "fix" it,
> you'd need to figure out what the author of the "except" thing
> wanted to test, adjust the args given to test-config (it cannot be
> the same as the test-config invocation of the previous test), and
> then fix the typo s/except/expect/.  Changing the typo alone *will*
> of course make the test fail, because then the file with the
> corrected name, i.e. "expect", has bogus lines that does not match
> how the current invocation of "test-config" command is expected to
> output.


Hi Guys,

I was the original author of the test, I am sorry about the typo.

I will submit a patch fixing the test. The fix can be checked at
https://github.com/git/git/pull/451.

'configset_get_value' will be changed to 'configset_get_value_multi'
since the test expects a list of values instead of a single value.

Thanks,
Tanay Abhra
