Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F1A20756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdAJUn2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:43:28 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:34403 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbdAJUnN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:43:13 -0500
Received: by mail-io0-f181.google.com with SMTP id l66so8877483ioi.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l0H6klCen5sAQEf/ae+PPn76IG7SNy3q317CoybLSrQ=;
        b=XPZtm7AJ7dYUgKFFr+tu0vNhComUezQAT5z+FPugHQwiqhJwvJRCJPATDZoOsF7j9C
         wCb2NkCLEyvQqsmSfYbu/F5SbukQ5m8KpndQeqfwfbtjRSZf+9s1rC8YWSB3dOI/CMK7
         tr0GNVfZNQ25oX//YsxXCFt+nO5UZ0/rT+6U3kY6qlcTAyZ6CtaDX2itRNWFL/2v8f1N
         A15lF3UZ9GZ8R05p+iPAGTIoTyEcd+ZSUds/qEwle92pjnhKYHKvOVBIgqP8R4ZYTB+J
         sKz/HWPyZ4SPyz3WasMHH2C9rSLI119BiA807xgfhWKaUuWDXQQzpByCmXgYR/PMsRrY
         Vm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l0H6klCen5sAQEf/ae+PPn76IG7SNy3q317CoybLSrQ=;
        b=tfOpIYgFjoBL0LaNRoY3c3QoNvslkJoFmjRtMP9elm7o4++thocfUpZOaHqll4pvX7
         WmRL6oa30wseilFxJg33OYpWjDntuYsWE/ZRwDO95vXJRoA0WhTNj6LsQOZFSj0m7n4n
         YwYPltxzTa+vtjSf9qyo1Vb9AM6QmVhVbwsmGlnTcQZ472vxrxUEkdMunJHviSICQwX5
         qQ2md6isAwYacMtceFosIJQ1E1UiQstHB2V3vbGkDHSeOFJc32Q8KqZiBuUouc8j/UOh
         g/BXsTwy76E9PWKP6SyJWJMQOETP0YJ1TOeaER0kqxjBtin/qsrIt94eRMdeotMYiNvU
         2kzw==
X-Gm-Message-State: AIkVDXJPMZyaKjSTYR2JiA6JMLIFs5YZHZQfXPf0ef7h/XBrX5VYfBi5JcB1GV3DFVi7nt5K1zNkaHHVjE7O72oL
X-Received: by 10.107.16.14 with SMTP id y14mr4749007ioi.164.1484080992628;
 Tue, 10 Jan 2017 12:43:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 10 Jan 2017 12:43:12 -0800 (PST)
In-Reply-To: <xmqqr34ar6s1.fsf@gitster.mtv.corp.google.com>
References: <20170110014542.19352-1-sbeller@google.com> <20170110014542.19352-3-sbeller@google.com>
 <xmqqr34ar6s1.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Jan 2017 12:43:12 -0800
Message-ID: <CAGZ79kbm4GRwNe7J_KP_V3eP8ZyAMEhOy-HL_ytHGtPoe19NPg@mail.gmail.com>
Subject: Re: [PATCH 2/4] t1000: modernize style
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 12:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The preferred style in tests seems to be
>
> s/seems to be/is/;

If this is the only nit, mind to fix up the commit message locally?
(I was even unsure if we want to have this patch as part
of a larger series, as it is just refactoring for the sake of refactoring,
i.e. t1000 doesn't see a new test in this series, only t1001 does)

>
>>
>> test_expect_success 'short description, ended by 2 single quotes' '
>>       here comes the test &&
>>       and chains over many lines &&
>>       ended by a quote
>> '
>
> Thanks.  This is way overdue.  During the time the script has been
> dormant for more than two years, we should have done this.

agreed.
