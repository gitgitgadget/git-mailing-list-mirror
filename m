Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818BD207F8
	for <e@80x24.org>; Thu,  4 May 2017 01:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932178AbdEDBfT (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 21:35:19 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34682 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932170AbdEDBfR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 21:35:17 -0400
Received: by mail-pf0-f182.google.com with SMTP id e64so79338pfd.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 18:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2e/7GF7uuw/Ah4qjwbtcjlawZ+m2uDiB0Iin91LtP3U=;
        b=RLsOSapNmvUjmjR0XY987fFWXmek4UefzvsmC9CbbOxRQAaqExM0Xr5Y/4qEr/XAFn
         oHAZbRV9DILHB3MiVJ45bRtZZn24OkuYjWz+/oiCXP8l/wVSeyIFXGQhFWRkEiAfUck5
         +wvn7UZMRAf/2cQKekL4bnhqBetRIq8mhhIKkNJ2UxX+Q7gAGK5Sk01cnCU4CoCsDDXW
         EW4H/F3RmN5BY3Jp8Mryam3GbKgb6wuFVK+YtbGiDwiNRnEConRX0+/dVQGS0KtxfRfB
         7THCjeDeXRI5IV8FAOjnKrlPHx/pArZM3BvAUjXWrWNeJ1oyYiADliOMJ2o4R/JHjGiw
         N4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2e/7GF7uuw/Ah4qjwbtcjlawZ+m2uDiB0Iin91LtP3U=;
        b=gYqtWFHG/HcggThpORryaE4PPNlLueTwZmKIIEKM7PjRlUXwn2+IpSAUem7qnit1uz
         ZPFJ3ibwRvh4E46OfyGBF2IH72N8Ng0swNDg8Yr++U7qQkmocg5UGq7K8ZQGrFZOtdZp
         218RIGg1TOxf4bdn2Xy0+jXPMunFJO4suK/BWF4UsynsYD4KlEkGtd/BgAqcbKXMTIB2
         AE2Vkea2qu/LIbmKPRCdXs2BD7CedFtBM19j9lTh5Mx4QZpVjgqYEXLFO2IdYpG6fuxa
         4kDqT8o+PcffbIkQMHbuFSNNyvze7qHxzFxmhdyqGp7hTmUOcw6nI7S3DE8hDHnCuBIo
         hadA==
X-Gm-Message-State: AN3rC/4wIP8le9OhS0LK2E0kKTqu3eVCHnTUulSckHYoChOMeY7dLrQD
        GZOo32tEbvdAlQ==
X-Received: by 10.98.87.203 with SMTP id i72mr8163348pfj.151.1493861716661;
        Wed, 03 May 2017 18:35:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:21be:aa3e:8063:4b3])
        by smtp.gmail.com with ESMTPSA id r2sm606353pfd.1.2017.05.03.18.35.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 18:35:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     git@vger.kernel.org, worldhello.net@gmail.com
Subject: Re: [PATCH] i18n: remove i18n from tag reflog message
References: <20170429100253.4710-1-jn.avila@free.fr>
        <xmqqwpa1ic4e.fsf@gitster.mtv.corp.google.com>
        <2070499.EYhsb04HyH@cayenne>
Date:   Wed, 03 May 2017 18:35:14 -0700
In-Reply-To: <2070499.EYhsb04HyH@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Wed, 03 May 2017 18:38:45 +0200")
Message-ID: <xmqqfuglcskt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël AVILA <jn.avila@free.fr> writes:

> Le dimanche 30 avril 2017, 18:45:05 CEST Junio C Hamano a écrit :
>> Jean-Noel Avila <jn.avila@free.fr> writes:
>> > The building of the reflog message is using strbuf, which is not
>> > friendly with internationalization frameworks. No other reflog
>> > messages are translated right now and switching all the messages to
>> > i18n would require a major rework of the way the messages are built.
>> 
>> Thanks for spotting.  Before we declare that reflog messages are for
>> i18n, we'd need to either drop (or redesign the implementation of)
>> the "checkout -" feature, which relies on the exact phrasing of how
>> reflog entries from "git checkout" looks like.
>> 
>> Will queue and merge down to 'master' quickly.
>> 
>
> I didn't know this "side effect". Maybe adding a test against it would be 
> requiered. Unfortunately, I don't know enough of it.

Sorry, but I am not sure what "side effect" you are referring to.  I
am saying that in the current codebase not translating tag reflog
message (i.e. your fix) is the right thing to do.

builtin/checkout.c does

		strbuf_addf(&msg, "checkout: moving from %s to %s",
			old_desc ? old_desc : "(invalid)", new->name);

when "git checkout" is used to switch from old to new branch.  The
above phrasing is used by sha1_name.c::grab_nth_branch_switch() to
know what branch you were on, and not having _() around the message
is the right thing to do, at least in the current codebase.

If somebody wants to i18n the reflog message, that needs to be done
at the reading/dispaying end, I would think.  Instead of being purely
textual records, a new reflog format would have to be a machine
parsable message-id with parameters, and the code that wants to
understand the reflog record like grab_nth_branch_switch(), as
opposed to show the record to the humans, would just use the machine
parsable raw data, while "git reflog" and friends that format the
reflog record would give the message-id to gettext and feed the
parameters recorded using the result of gettext() as the format
string to fprintf(), or something like that.





