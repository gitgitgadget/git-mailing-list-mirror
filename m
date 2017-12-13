Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251021F406
	for <e@80x24.org>; Wed, 13 Dec 2017 05:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdLMFfx (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 00:35:53 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34104 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdLMFfw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 00:35:52 -0500
Received: by mail-wm0-f44.google.com with SMTP id y82so20136561wmg.1
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 21:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M+gUSuYeWDy8Tz8K99BwWU9YbYz4Epf18W2SUtYU31g=;
        b=k0bzFw8Yl9+GX8r6L1Rh+CPmZibKGylpeMxvjKb3f0rjIrUCqya8x8P3en1TAuCtbG
         YPsT70wYQQdKQR0WxcihofkNYtozcdUZtJs4tmgNWtBsDA3swNR/oiibpzG7jysWVwyW
         owxsZGQPPi1ZAohdMj9DBTA7bDcdBx5/lskJ3gFLz7EZOklaWHFGt6Fb9s87xON1goFf
         3L6baK8sYABsYlh86AFGa0eonxAhtlbQAHpGZIpeP9a6Af5G0aEGPx+tELmbD3hwvyx2
         OLKIN53Ihl+SBSwN63cIZ7J6p5V1JMIO0kne9gxjaBGbqegGozKfkXQxBsbdRk+JEDCT
         T7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M+gUSuYeWDy8Tz8K99BwWU9YbYz4Epf18W2SUtYU31g=;
        b=YMSbjrCBM8cjm4VTqt6EIOQ18cAcIJti9txSVWup01PMJtm9cvf4MQEoj9XSAzHpJ4
         BTAoRPFGJZoSE1TNDNyMJqcdQyM4KeZjO77neEKE6IR/51rJM9Vtq78zjsDs3KFnQ/4n
         0cu/rEzIcbxjQWUr1wTZmEkDyEBBaro1C3W7DkFoqiLBvCDN7iCjNO25AyOxpxfk/Fd3
         F6+y0Yp/Z1YY7Nbg2cA3vXuV/FKlG2PpaHRnI69ddqAgDxu8CUxGKXXKds+LLxGFdjwR
         UQk4ySTKJVaMkUtjktvENdDWxDUFW71HDGOKTA3N0nqtT/e7o2MCAbX8vPlrJstYF+YN
         OcDw==
X-Gm-Message-State: AKGB3mKG3ySZ5H6R+pegFA+/bd2Yqjml7Bhn+FvooZPeX5bpHr/Pj8Cm
        iUmKyUuqc0FFTiaNc3ZxbIEVi4Z1F6ukbWHeVSM=
X-Google-Smtp-Source: ACJfBovzvoePY+5b9EMRQNosH2+Ke9zEY9PW7r3T/RYnGklvD+qS8G6jRJxEpva+RgchhHEcGkX414+waBjtQNd4DRs=
X-Received: by 10.80.165.109 with SMTP id z42mr5815643edb.18.1513143351107;
 Tue, 12 Dec 2017 21:35:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Tue, 12 Dec 2017 21:35:30 -0800 (PST)
In-Reply-To: <xmqqshcf20y1.fsf@gitster.mtv.corp.google.com>
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
 <20171211225615.GC214273@aiede.mtv.corp.google.com> <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xpH6M-FqRJcvsbv=mjj1T04GR6pxz-4NkTmGZUgUKU6wQ@mail.gmail.com> <xmqqshcf20y1.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 12 Dec 2017 21:35:30 -0800
Message-ID: <CA+P7+xo4G=qou=VGYCu0TgwUT5g_dnNTPB31WyRdC29w3p_CpA@mail.gmail.com>
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global" or
 just a bug?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 12, 2017 at 11:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>> I actually thought that the plan was "you either have this, or the
>>> other one, never both at the same time" (and I think those who
>>> pushed the XDG thing in to the system made us favor it over the
>>> traditional one).  So as long as --global updates the one that
>>> exists, and updates XDG one when both or neither do, I think we
>>> should be OK.  And from that viewpoint, we definitely do not want
>>> two kinds of --global to pretend as if we support use of both at the
>>> same time.
>>
>> It appears that we actually prefer ~/.gitconfig rather than XDG_CONFIG_HOME..
>>
>> And at least based on current cursory testing on the command line, we
>> do both read and write to the proper location, assuming that
>> ~/.gitconfig is preferred over $XDG_CONFIG_HOME.
>
> OK, so I misremembered the details but it seems that the behaviour
> is consistent and there is no ambiguity?
>
> Am I reading you correctly?

As far as I could tell based on local testing. I could be wrong, and
haven't yet cooked up a test case for it yet.

Thanks,
Jake
