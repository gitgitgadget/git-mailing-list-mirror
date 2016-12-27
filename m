Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E83200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 18:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754387AbcL0SIS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 13:08:18 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34098 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbcL0SIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 13:08:16 -0500
Received: by mail-qk0-f170.google.com with SMTP id h201so86218558qke.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 10:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/rVPNOVI0rvciKgXpmaKMmVLvB50VB6CyUuc7wQ1pYM=;
        b=as3e2TWYVRCTSp5NSX2HwqUxB6ZCyNUsC1cWgTAy/z8TelA8A1OZFZDJWZLh5unCsD
         2sjFY7MqBk+KoCVYqJO2YDdysA1gABbWvUD6YPyZiYTNvbXEkdOxP3y0s8w4SwjnLT+n
         d0OsX4r49v/IVmjUQBt76IgeHxdI2VuPKTMFuH9hvU6gcRJYZ0vrNurMZcKwPwhsV8hd
         DVprTSHGGYWV5BOdxtbr2BXikEC8HY8Y7z4+HvYB7fa4/8zgwZyl1JbQEhyVJySLgkaG
         J03u0CZFyH85aUjobISHx68vU1W2OSxSEel6AkGKORIM1Xd8xMlHm0j4nJZVHeTzREVF
         72sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/rVPNOVI0rvciKgXpmaKMmVLvB50VB6CyUuc7wQ1pYM=;
        b=eq2uCCenWxc1ZqXzhdmKTBhIABu0VasZ1xWQ83PE85lzZpDI+eq5C9/aBiZhzTSnXc
         SD/bhByffenyk3kL3tUpqnjPWW336j8KlCCF0tymfYY3dIAi6kCG6PzYjYV/69xsrERr
         bbZGy17xWS4ARxRD0GvXsQBfb0fu5BS6KrEkykslQe3aIhVmYBhBFxxAilJms/ex7lCm
         ECTtsv37j88S2BirfywWZoBtP3bgmgM/kogQuxoumPV/9TPrYNiMc2+1UUzqQaCD3fWn
         yE9Pa5ZxhWzIDMFsYgdfB0VlhfRNFrerlS2i6tX4XNKIKAUMJm5jT/ZtM/R62Jxb+LGF
         VHrg==
X-Gm-Message-State: AIkVDXKESVeBHEA7TPRp3NHMyUJvUUB8BF+G+EtDVBS/TnJOnFNFEm62tSeRAD38K6VpoakUCs77YWO9j5OaLHR2
X-Received: by 10.55.105.129 with SMTP id e123mr34318766qkc.173.1482861570675;
 Tue, 27 Dec 2016 09:59:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Tue, 27 Dec 2016 09:59:30 -0800 (PST)
In-Reply-To: <xmqqinq6cgxa.fsf@gitster.mtv.corp.google.com>
References: <20161220232012.15997-1-sbeller@google.com> <20161220232012.15997-2-sbeller@google.com>
 <xmqqinq6cgxa.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Dec 2016 09:59:30 -0800
Message-ID: <CAGZ79kYU3yKrMwQp96-wdHedwzX7tKE1NK2OwdfOau1U3q1gaA@mail.gmail.com>
Subject: Re: [PATCHv5 1/4] submodule.h: add extern keyword to functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <David.Turner@twosigma.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 26, 2016 at 5:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> As the upcoming series will add a lot of functions to the submodule
>> header, let's first make the header consistent to the rest of the project
>> by adding the extern keyword to functions.
>
> This may be the right thing to do in the longer term but a patch
> like this adds a lot of unnecessary work on the integrator when
> there are _other_ topics that are in flight.  I'll see how bad the
> conflicts are while merging the topic to 'pu'.
>
> Thanks.

Maybe we can roll this patch on its own,
so in case the latter patches need rerolls we still have this one and can
build on top?

Thanks,
Stefan
