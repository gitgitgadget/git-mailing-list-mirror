Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112B22034E
	for <e@80x24.org>; Wed, 20 Jul 2016 15:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbcGTP6H (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 11:58:07 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35175 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbcGTP6F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 11:58:05 -0400
Received: by mail-yw0-f173.google.com with SMTP id j12so42168802ywb.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 08:58:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BoR0HIXNoisdLWGZCTeckCaS0ZgJ79xlSCsYS+g/Nxs=;
        b=xLREJAIA0IkYRILt1s8Ei8/rDSjFbLGr3gL1/K5h5PVStGPlORLij02ilslV0/U7sB
         gLO1N9exhzZ5T3RNx8RX05k45RllKHhl2RwUxStfPKb/2n+WHcqmJpGzomZwgpg8ALx4
         kCJnAZfdyBtuD7zuAEIoFm0+ums8rdF52o+Oy+EcibcttJED9lOgn8s6y9V9N9GreYlD
         2l57kv03750k5L/+4ryMema8V1t0fcXdlhPgq3Dw3oXHjiUxFmrXUCf8M/OcxyNJTjQN
         9TwNe3GGQjcjUdVolOUZk/TsDNj7RHz8fiqUmKnCJ8ozOSAwPKdhq/3xTehaNNbAEabp
         oeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BoR0HIXNoisdLWGZCTeckCaS0ZgJ79xlSCsYS+g/Nxs=;
        b=VDonAc5TLkwr2Ek6CAgeK6+DkgLXjh+9iwVjOYqC1dEaSwv/KVaUsjxVjDPtGVD7gz
         D+eI4+nfc3/XotWLvsBmpp6862xAEyNX4+LUDO1wRCQtT00gUfUIkLUxMx7QW5vZxUGH
         /+JjcCQBAn2om71+pqMXwl9fPc2s/MIAHuK5NxgRw20WJkG06oKCQKl/MEh9uuqWjxAu
         hg2ot5g43cC0wdgOgxu0IP6jor1JZOPxoNkOfaHG4K1i2yGAhuv/tXkWDQUcH/ij0Z7i
         9EnD7ecroVjLs+44thHfH8aAvgjAeiJ27Tvqce3wv5Y4w2QpzoMqD0Fij81NOo+AEC4e
         r0GQ==
X-Gm-Message-State: ALyK8tIHC6x1M9x/Fl45fC8CrGwQDtmwRkVvZapjguYJU58m3dtVnL0clTrapj8i07TRwDSS0eqdjhnWN+JtPA==
X-Received: by 10.37.94.137 with SMTP id s131mr20248767ybb.53.1469030283779;
 Wed, 20 Jul 2016 08:58:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Wed, 20 Jul 2016 08:58:03 -0700 (PDT)
In-Reply-To: <xmqqk2ghdysg.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2ghdysg.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Wed, 20 Jul 2016 21:28:03 +0530
Message-ID: <CAFZEwPM7bBV5PxOqA9Zvrq-4M1F83NVXORRKje_fqG74ofUWLQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2016, #06; Tue, 19)
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Wed, Jul 20, 2016 at 4:24 AM, Junio C Hamano <gitster@pobox.com> wrote:

> * pb/bisect (2016-07-12) 9 commits
>  - bisect--helper: `bisect_write` shell function in C
>  - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
>  - bisect--helper: `bisect_reset` shell function in C
>  - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
>  - t6030: explicitly test for bisection cleanup
>  - bisect--helper: `bisect_clean_state` shell function in C
>  - bisect--helper: `write_terms` shell function in C
>  - bisect: rewrite `check_term_format` shell function in C
>  - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
>
>  GSoC "bisect" topic.
>
>  Are people happy with this version?  How much of the planned
>  "porting" is finished by this part of the work?  How much more to
>  go?

The current branch contains 30-40 % of the work. I am going to send 3
more functions check_and_set_terms(), bisect_next_check() and
bisect_terms() positively by today. After that the work will be around
50-60% complete. After that bisect_start() (I have ported this but it
has a bug right now) then bisect_next(), bisect_replay(),
bisect_state(), and a few small more.

Regards,
Pranit Bauva
