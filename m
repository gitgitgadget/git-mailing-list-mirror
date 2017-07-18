Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D8F20356
	for <e@80x24.org>; Tue, 18 Jul 2017 17:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbdGRRlX (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 13:41:23 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35326 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbdGRRlW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 13:41:22 -0400
Received: by mail-pf0-f173.google.com with SMTP id e199so14656131pfh.2
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mkdgBJxGC4L7sP5cf1uyuzmN4FYsSI6iijmEOA04OhY=;
        b=LJ3FlPqS1O8+YOmV+aDHCaPb2lmfSazarv8NUx1ot2+JsT+3FYBENNI48R6RTZxQ3W
         vs/JnUgQc6oEnQGmbjG7iMIMJrXl22w34yqxZLmZ7B9wS87rLdTNei71yb85HyEDrnMv
         a/L424nJiv9Xzav7w642ehCQRkoAw6ShlEE1pI8rU9NwIj6h0IutgDGSIOEv0vnlQ81x
         ThPOzn+4DW7sWpmugbpgGs0IKg/ilcXwwyX522UewMySMDUHifLhR1X+JDX1/gmJU1Kv
         dyxBOA4Wc1Kz0uXxUZ47ikl6XxovTtHVCbOl/zt0X504L5SB37pcm0ucWymUeV54TrKO
         P0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mkdgBJxGC4L7sP5cf1uyuzmN4FYsSI6iijmEOA04OhY=;
        b=auQGkW+n3HP6K7Cox5t4M8JVJfTAwZ339EPSCYKjqb7sLg1txRLxy2lKdKIxytXV2D
         DffV+nLHj/mX8QtzjcgbgUxk5XDkVjPAHTbWiCBD7oMsqv5avPLb2d7QMtedzOZW1JBo
         NHN0o8toW7HXHOACPOEzFtGW2EnRznJVSgiBs6bZC5DFM23w2opuu92pVWd0hQH6hTWM
         ZuRW7mVcPKDhrua0q0mK0hAERNcPTDIb2MoV1O/PPWCxPXkB9OWh0hm8FMIQAUHzA4pj
         JVwFOF6bSvKeyGeWkteIV3h6rUgn7nkS1nNMGG4AyN0BBKyUGPsn9XfNPNvsXQ9LVYEz
         BFUg==
X-Gm-Message-State: AIVw110ELa9iKvy45q9QnZU/SfsDod1SyiCr0sDWCqIjLboazzcTahpz
        KHC4WRidDLAThu3BzIJBZ9sObAnAMR25
X-Received: by 10.99.54.9 with SMTP id d9mr2879974pga.195.1500399682306; Tue,
 18 Jul 2017 10:41:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Tue, 18 Jul 2017 10:41:21 -0700 (PDT)
In-Reply-To: <xmqqa841fylf.fsf@gitster.mtv.corp.google.com>
References: <596ddaa620821_77f83e7330107c4@ss1435.mail> <CAGZ79kaPFDMn2K0f529-Crzv+vhU3XUMsSM6w3QV4RXKBv5s_g@mail.gmail.com>
 <xmqqa841fylf.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Jul 2017 10:41:21 -0700
Message-ID: <CAGZ79kYohev8BdBEL9qnfmZ6quMwZPDRqZ44qCKV_wMwR=Etiw@mail.gmail.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
To:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 18, 2017 at 10:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I looked at this report for a while. My current understanding:
>> * its detection was triggered by including rs/move-array,
>>   f331ab9d4c (use MOVE_ARRAY, 2017-07-15)
>> * But it is harmless, because the scan logic does not understand
>>   how ALLOC_GROW works. It assumes that
>>   done_pbase_paths_alloc can be larger
>>   than done_pbase_paths_num + 1, while done_pbase_paths
>>   is NULL, such that the memory allocation is not triggered.
>>   If that were the case, then we have 2 subsequent dereferences
>>   of a NULL pointer right after that. But by inspecting the use
>>   of _alloc and _num the initial assumption does not seem possible.
>
> Yes, it does appear that way.  ALLOC_GROW() calls REALLOC_ARRAY()
> which safely can realloc NULL to specified size via xrealloc().
>
> I'd be more worried about segfault we seem to be getting only on
> Windows from this:
>
>     git -C parent grep -e "(1|2)d(3|4)" --recurse-submodules HEAD^ > actual
>
> in https://travis-ci.org/git/git/jobs/254654195 by the way.

Thanks for bringing that to my attention, (I do not follow the travis builds
as closely, as there is no yelling email in my inbox).

Windows builds on travis seem to be flaky.
(sometimes they do not start), but there are also
successful builds, including the -rc0, which may indicate
bw/grep-recurse-submodules may be faulty on Windows.
