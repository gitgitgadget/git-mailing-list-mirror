Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58279202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 21:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbdB1VZb (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:25:31 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33640 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbdB1VZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:25:28 -0500
Received: by mail-pg0-f68.google.com with SMTP id x17so3029481pgi.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 13:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6H5HIEc6VpL9ZYNCFENdLo5GlXZ6hGcqMhpSHR2IYe0=;
        b=dicjq5VydpfshVjnia58M7/7OP4jJASZbAQwbC8+pQVjRMSg8u8G6t8gDEoq2KK+/a
         kcuiL+TW7d51BJ9R4tRqtbrQDe0F+89dJEWkcI8kSKzuu6vUPMQip3ULv5u2SLb6FfhH
         0Xt814F+Mi85/WlABLTEJKTVK5b+f9LrrDJgkYBiEyJV/HU9i49SXOFVga4I9ncNqsT8
         n/7yW/ujWMj7H1M8Y6nA/4y/eDvAwiwNtT2y3OBwTAEdWWZZCIOEJJP8l48DZgdwn7o5
         uvTEfKH8IgQC3nvlIt3lxs1vEMbs7X7blCdzL63Vo5JWM31mVoJu5vM2gav8bJx/aIii
         d/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6H5HIEc6VpL9ZYNCFENdLo5GlXZ6hGcqMhpSHR2IYe0=;
        b=XH2JWJdi9OIjUPZBRwrllb57RjlidRMUn00/yXkdERV4kcK/Tc5X096LvoO5T411P6
         DUaui1RjGF6caoK0At6HPnNYb/GjmWHgUJWJdZTQVrHxmbbQIru/UGBcHjbFapVau/3E
         m2Mz4t9zzQa+AepL/WAslK0LORP60yCAtHpEPUhaNBz9yl18AoNLnaduLVw2bYL6qR/i
         CQ5aqXHCaZEhb4sK1jAMgK1th64cAjWFB0Pg5x9ZFHVRMPAJ3OfcBhV+B0jY78O9Bzmk
         uH4cA9jawVZW8EONmS9dDHaOM+n+WwDQ2A4mBJkn4YrJI3BtnJtxje5F3wkIycvQXdmp
         8EjQ==
X-Gm-Message-State: AMke39m+YF2WBo5SUqucND0Yfx+LlFpUo8v5QM1mWggAt0rupNr2LitTiMAxWTrDJKzVpw==
X-Received: by 10.98.65.148 with SMTP id g20mr4929348pfd.44.1488317117272;
        Tue, 28 Feb 2017 13:25:17 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id 71sm5999755pfx.40.2017.02.28.13.25.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 13:25:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Documentation: Link descriptions of -z to core.quotePath
References: <3c801e54-28c7-52d0-6915-ee7aaf1d89c9@gmail.com>
        <1487968676-6126-1-git-send-email-asheiduk@gmail.com>
        <1487968676-6126-3-git-send-email-asheiduk@gmail.com>
        <xmqqmvd6jayn.fsf@gitster.mtv.corp.google.com>
        <d59bda7b-2eb5-a6cc-8240-0ff4f50de540@gmail.com>
Date:   Tue, 28 Feb 2017 13:25:15 -0800
In-Reply-To: <d59bda7b-2eb5-a6cc-8240-0ff4f50de540@gmail.com> (Andreas
        Heiduk's message of "Tue, 28 Feb 2017 22:13:35 +0100")
Message-ID: <xmqq60juj9dw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> I'll fix the "munged" and, unless there are objections, I will also
> replace the remaining ones in the vicinity. These are the last
> occurrences of "munged".

I'd rather see the "we do not munge" to stay the same.  "we do not
quote" still allows us to do modifications that are different from
quoting.

> You are OK with the references to another man page? My idea was to
> establish a well-known term.

The "well-known term" cannot just be "quote", because it is too
generic.  "git rev-parse --sq-quote" does a different kind of
quoting from the quoting done here for paths with unusual
characters, for example.

We certainly *could* (1) add to glossary-content.txt the definition
of "c-quote" and describe it there, (2) change the "see the quoting
explained for core.quotePath" to "unless -z is given, paths are
c-quoted", and (3) change the core.quotePath description to refer to
"c-quote" in the glossary.

But I am not sure it that makes the resulting document easier to use
by the end users.  I personally find the result of applying the
patch you posted easier.



