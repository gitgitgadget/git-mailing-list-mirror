Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242C51F597
	for <e@80x24.org>; Fri,  3 Aug 2018 13:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeHCPVb (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 11:21:31 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35297 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731364AbeHCPVb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 11:21:31 -0400
Received: by mail-wr1-f44.google.com with SMTP id g1-v6so1931182wru.2
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SIw7adwLDx35+cOP7e8nsIow7TuqJeNYaze8QV8k/Eo=;
        b=r3aX/cN2JC8/lNgn/Aawu5YqaOmiveVHafX1lYbJJpuQhrRhprej6l8zafM/OSs04N
         0st6f161xP2Khlwk+xzbzbF20fIvTOUATWtMmOy6Wluf4Ci3hd85H5gnbzv9ee7KeKxO
         LAgwvbFCdzWcqEfQVG9Zt3QiUd007FsOdPqT3nFERSnlW5OpxJC1HAqM4w5p6SJOZh6D
         74rO65GdmPF8Q9tVoesuX3cnjMy7yGiwjweslmT5c1Ls+ihssK0kjTkg1zyiSvLHoOk7
         KOyehRA1xstW43DLPtnlkLWgYlvj9fKaSaLTe84yOJCUKJj586xW0H8ZCXjSdFtoT3Xe
         BYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SIw7adwLDx35+cOP7e8nsIow7TuqJeNYaze8QV8k/Eo=;
        b=n1JKO7YUnnwbhDdKhuU2B/kgDlr67CjSeRSDKlnzPkJKZnQVCjT4hdml+GZa6M7ifw
         cp7PtRzC4D24ufykwvpP/aGl6/4CVTzuME66Nb1ittLpCvA+AGve5hIjnsKhEf1Gwzei
         B4hPxkfW2fVsfN1q26L2bsm5YqDB+I2qs8P34hAup1br0uPK99MqeO2s1NrFL2+hHfWN
         sPWHIygB9QJ4wSLCU2nNxdN5wnFSoEOWUQs3VBuJ4Flm5X+OnzxqiC/CC0yKWuVr3qB+
         jfvl7JKW5S+YyX/TVXTYzRqlxNJMAlsUPV/KPv/xue+M5EfIL62b/yVUD41Q+355GufA
         1OZw==
X-Gm-Message-State: AOUpUlG2L/hDcUnls7CflJMNfG49PbOLEo0RfEItLR5QH3o8RBn8nGMI
        lM5R+lQ0fzlqFlIlLWhH324=
X-Google-Smtp-Source: AAOMgpc7AsTLkT21jBwJQ3q7pkfoCvK0wJUgpGzWAEUwVGMPhUSEXKhK7+Ijcu23XL/WvZo0E9MfZw==
X-Received: by 2002:adf:9527:: with SMTP id 36-v6mr2447608wrs.99.1533302709610;
        Fri, 03 Aug 2018 06:25:09 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id t19-v6sm5296938wmi.42.2018.08.03.06.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 06:25:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Liam Decker <ldecker@indeed.com>, git@vger.kernel.org
Subject: Re: Question regarding quarantine environments
References: <CALcD6sYfcaftciYU+2AHpzabyOS9ohRcZoE6LDuMyht+dxktHw@mail.gmail.com>
        <20180802183924.GB23690@sigill.intra.peff.net>
        <878t5ntxqs.fsf@evledraar.gmail.com>
        <20180803130058.GA4671@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180803130058.GA4671@sigill.intra.peff.net>
Date:   Fri, 03 Aug 2018 15:25:08 +0200
Message-ID: <877el7twej.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 03 2018, Jeff King wrote:

> On Fri, Aug 03, 2018 at 02:56:11PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> > Any Git commands you run should therefore find objects from either
>> > location, but any writes would go to the quarantine (most notably, Git's
>> > own index-pack/unpack-objects processes, which is the point of the
>> > quarantine in the first place).
>>
>> To add to this, one interesting thing that you can do with hooks because
>> of this quarantine is to answer certain questions about the push that
>> were prohibitively expensive before it existed, but there's no explicit
>> documentation for this.
>>
>> E.g. for a hook that wants to ban big blobs in the repo, but wants to
>> allow all existing blobs (you don't want to block e.g. a revert of a
>> commit that removed it from the checkout), you can juggle these two env
>> variables and hide the "main" object dir from the hook for some
>> operations, so e.g. if a blob lookup succeeds in the alternate
>> quarantine dir, but not the main object dir, you know it's new.
>
> I'd be a bit careful with that, though, as the definition of "new" is
> vague there.
>
> For example, completing a thin pack may mean that the receiver creates a
> copy of a base object found in the main repo. That object isn't new as
> part of the push, nor was it even sent on the wire, but it will appear
> in the quarantine directory. But only sometimes, depending on whether we
> kept the sender's pack or exploded it to loose objects.

Right, I mean:

    is_new = !in_quarantine() && in_main()

Or:

    is_new = !in_main()

Should work, in the latter case if the object really is missing from the
quarnatine too, other fsck bits will stop the push.

But as you point out:

    is_new = in_quarantine()

Cannot be relied upon, although it'll be true most of the time.

Perhaps I'm missing some edge case above, but I wanted to reword it to
make sure I understood it correctly (and perhaps you have a correction).
