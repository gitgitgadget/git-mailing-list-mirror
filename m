Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A821F597
	for <e@80x24.org>; Thu,  2 Aug 2018 20:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeHBVxu (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:53:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50372 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeHBVxu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:53:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so3870189wmc.0
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 13:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gykSO9zPuwczaWfTGbKDcJPbqb5yRG4cQw5tKMV7ikA=;
        b=imtFil2j32PsQkLrN/wTqaZnVQU4O/cwxWhxkVRYVXMwRXUMPRWZuq7gwfN6LW3CdY
         GM3+CNiEalZhDfzD2icOlFPaBtZ/VdVfvqJXdOFNzV+6Xr0YvkfvIuAnmyKZYysZGo5s
         gtp76tg4zymbgML8xs9OC70zjC7SeoMpiEyREaqrk3cKNGTkHbm2aWui7TYjFqxZDzZp
         SWqcQ0aIPi3IkQLXyYJsL1ZtxG1iCym1udQZrCgr8pwjT8lQfw9rN0oSsYBwMnR6bgKt
         Uxi6HH4GdPwm+u3T3+CD7/Qqm6Hxmj/ZNdqS/82CF36zMMKnIvkng4mFVvEVDXIl4BSn
         R7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gykSO9zPuwczaWfTGbKDcJPbqb5yRG4cQw5tKMV7ikA=;
        b=UxAt4N+185inpICqeIKhldoMdObp0CfF1cMNXlpmcNtDA7Y+Xe6jQSa/30OFnypB/J
         Z/HUjJ7Ncjf2gFntD3W1qrX9+Ia1B9Nu6NXtXN15duV8pZ5MQnVxbDC0J5izhWGtBeYv
         2RJkNu4Alpg3MXrbLqkZy9Sw+8KYYIiFFpnsaPIP3ewc+wRdmWv9crL8s8Yhi/Jv8Xk1
         L0mDi9NGjh9zDDObvvAbQSjILTGhp4X3f77W+Uc62KnT6+8DnLMzhDrOwm3pVKZVdofK
         0THsNlwh6p+BzDp9jOmhxSIQbPiGusmvqjp9Ol5ei6/k7O+7lGCtMX5MRPHqBp2Y3QFh
         1jTg==
X-Gm-Message-State: AOUpUlEgzwQDUZCSYJF1R7u4XhrBw2GqiMuL5oIUQLsKY6VxhmbuRQG3
        Bm9EnvDkiUMJF4wIFA4Bz0e/QbZ8
X-Google-Smtp-Source: AAOMgpexinE5zo4Qyfop0GFAeZxvD5TRB2NvprstVbjRzdi2LyaLkQifLRl6DWmg7mlvZ2/vIL0Ibw==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21-v6mr387752wmh.1.1533240069644;
        Thu, 02 Aug 2018 13:01:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y11-v6sm3240194wrt.4.2018.08.02.13.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 13:01:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
        <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
        <87h8kdu3ay.fsf@evledraar.gmail.com>
        <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
        <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
        <20180802165457.GC15984@sigill.intra.peff.net>
        <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
Date:   Thu, 02 Aug 2018 13:01:08 -0700
In-Reply-To: <ad2d8f99-07a3-0191-88a2-c43081657988@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 2 Aug 2018 20:46:31 +0200")
Message-ID: <xmqqzhy4zgfv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 02.08.2018 um 18:54 schrieb Jeff King:
>> PS I actually would have made the rule simply "does it begin with a
>>     '<'", which seems simpler still. If people accidentally write "<foo",
>>     forgetting to close their brackets, that is a bug under both the
>>     old and new behavior (just with slightly different outcomes).
>
> Good point.

Straying sideways into a tangent, but do we know if any locale wants
to use something other than "<>" as an enclosing braket around a
placeholder?  This arg-help text, for example,

	N_("refspec")			without LIT-ARG-HELP

would be irritating for such a locale's translator, who cannot
defeat the "<>" that is hardcoded and not inside _()

	s = literal ? "%s" : "<%s>";
                        
that appear in parse-options.c::usage_argh().

Perhaps we should do _("<%s>") here?  That way, the result would
hopefully be made consistent with

	N_("<refspec>[:<expect>]")	with LIT-ARG-HELP

which allows translator to use the bracket of the locale's choice.
