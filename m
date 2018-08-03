Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7661F597
	for <e@80x24.org>; Fri,  3 Aug 2018 15:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeHCR0J (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 13:26:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39422 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbeHCR0J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 13:26:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so5773263wre.6
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=raoRwY/LaawbfB/j1Qwox82nZ3Nh0h04khj4HCLWoz0=;
        b=rIpyaWcqjpsB8EhatyxbHJuWBBAVAgae60MoKHXGOAkK1jXljBqON2vj5P5RMlQpaA
         P+hrITpjLQLBgasPDKX62QJSOyhj52cSJ5baW0nPQUmyWu22YbsEPK3TkIupYe1QlShK
         KETD1RSLv6ua7/iG0ZCedXbudjFhGn+4Guae9Gl0QFmZo7c0u+fx285/UzLQfxoZpMso
         UhF/ih3kXaQkE93VkjlDDhdVdvUecR/wO47i+Q+WqXlWLJUQS0W3yyixnmAo6Zp+DqTS
         zUNuEPhfBfPsEkU+SOTKRnXrKYiUj6Jr5mVdp8ENK70bJnMLXljR6C5ShosG4nAe7X+w
         Rj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=raoRwY/LaawbfB/j1Qwox82nZ3Nh0h04khj4HCLWoz0=;
        b=VCJICS1Rqc4XiMd/A3Sy8/omDZE5uewRWu71o/Ct2IHJJ/4PKmoxNXs1p7Aqagj2OA
         oFakImsjadNnhusRtDp6euux2Hym/HGXfrwR9WdRwKPGW4aqeM0xvbGpBT32MT4pukiu
         J1s4qcPPIxZLnflk4NQIY15JeC/F5wSA5gge3HHyLjfij09TCQIKxwQ4wSRqD925H2Mp
         n3BJ4yWAbaOu58mBQXK0AtBtMiusVyk962anLLs5TqfMAI2S4myumiGG+Rf76FNIh0ty
         jGKYKBxdDRcDadmvLimxVFbbaTFWlNU2KclOF2QOaYbI09sYmYHRU5/tdHhCk1QHjz8c
         XVDQ==
X-Gm-Message-State: AOUpUlF3ygBd2kuq5HGRO0NUT3CTo6Uj7EgDXGhS1TpZ3Jfmt2J8jRAM
        hylSuHIVNQRyUEw0bQ/a2NQ=
X-Google-Smtp-Source: AAOMgpf1FYO+0DcslAfleyYEUtERBm2lPoEd2tkjS+OVWfkga8lz/fDqwUMCQe9BZQZaxQRq6bJ54w==
X-Received: by 2002:adf:b2a7:: with SMTP id g36-v6mr2874262wrd.218.1533310159121;
        Fri, 03 Aug 2018 08:29:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w204-v6sm6337318wmw.5.2018.08.03.08.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 08:29:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Alexander Shopov <ash@kambanaria.org>
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
        <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
        <87h8kdu3ay.fsf@evledraar.gmail.com>
        <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
        <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
        <20180802165457.GC15984@sigill.intra.peff.net>
        <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
        <xmqqzhy4zgfv.fsf@gitster-ct.c.googlers.com>
        <ea253620-ed28-54a4-0e52-16cbf4ec8451@web.de>
Date:   Fri, 03 Aug 2018 08:29:17 -0700
In-Reply-To: <ea253620-ed28-54a4-0e52-16cbf4ec8451@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 3 Aug 2018 00:38:51 +0200")
Message-ID: <xmqqa7q31naq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 02.08.2018 um 22:01 schrieb Junio C Hamano:
>> 
>> Straying sideways into a tangent, but do we know if any locale wants
>> to use something other than "<>" as an enclosing braket around a
>> placeholder?
>
> Bulgarian seems to use capitals instead; here are some examples found
> with git grep -A1 'msgid "<' po/:
>
> po/bg.po:msgid "<remote>"
> po/bg.po-msgstr "ОТДАЛЕЧЕНО_ХРАНИЛИЩЕ"
> ...
>> 
>> Perhaps we should do _("<%s>") here?  That way, the result would
>> hopefully be made consistent with
>> 
>> 	N_("<refspec>[:<expect>]")	with LIT-ARG-HELP
>> 
>> which allows translator to use the bracket of the locale's choice.

I did not consider locales that do not use any kind of bracket, but
I guess _("<%s>") would work for them, too, in this context.  When
the locale's convention is to upcase, for example, the arg-help text
that is not marked with PARSE_OPT_LITERAL_ARGHELP would be upcased,
and _("<%s>") in the usage_argh() can be translated to "%s", which
passes the translated (i.e. upcased) arg-help text through.
