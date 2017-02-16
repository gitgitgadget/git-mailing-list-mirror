Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D12192013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754483AbdBPAUd (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:20:33 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35783 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbdBPAUb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:20:31 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so164558pfx.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nmfUqQ4rbgsIosQxeqPK0+Gq94d57ke1BQaxcgF+SkA=;
        b=NU7TbCFkUZUX/hnWCNW1F3Znw4Y8xcG3AngqkjwWnMSgoFn1cNcCdSPEHnWoCgQ1Cl
         u6UoWXvFyG6vHdPWLZo7weB4mdEFiR1dAQ6N6tD4YycH2DreJXM8JW7oPFtaGJBWgMr0
         nx7QcjMxwnRqRaTaLyhpjGULzK3gNxGQMM6VYLC2jreUo5J19vE4dTlWAH55hqNEiu06
         nDH+6X8jXDeBy5K+3490R9zLOkiTMvxtszNrW0hnysoBdLdRA72axXJ7jSpIu7Yqd7M5
         SOhkNcGRV9tm1Q3XsvAx9bgzuXd6Kxd/BPcWbsX4s/7lWScjHTp0KDDWrRA0txnR/DkC
         ZNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nmfUqQ4rbgsIosQxeqPK0+Gq94d57ke1BQaxcgF+SkA=;
        b=uCdPrOWInNA3vAqSzi9YZmbK6SwLPUT86uE8aRi3xrzt1RBpz+RptMp359BbPuw5vr
         C8/DDFivIz4+iLyCXJsCBf0/HCHPkrhZe/o4snRDw3siycsAindAXdjnin0U4grhuPTA
         wa0aR9xX5IVu5nZyzJM5YsOOUPWv6xOXB3tdCSDcJij8GT5qXHWTkHz/zabcXZSLWORp
         R1wF0ocmOKX6gC5/mjnjjkrjD4zPJl/ILDq7436zi02+0r6ILT30ocRKmrqwyQ6T3XTG
         GfrUKJHEo63WYcsuXObPsWl0QQJnNfYdBgB2k1DwNtXEUz0YWtbRim8FVVe2iuFN9Z74
         AxSQ==
X-Gm-Message-State: AMke39mG8SIfr7RExRj4E2QXbl2KTwl7xwBZapFMyMYOhPbZauNoZ959j6T5TMXG0yMPZA==
X-Received: by 10.84.229.76 with SMTP id d12mr46007289pln.21.1487204430703;
        Wed, 15 Feb 2017 16:20:30 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id s8sm9552740pfj.30.2017.02.15.16.20.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:20:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Christian Couder" <christian.couder@gmail.com>,
        <git-for-windows@googlegroups.com>, "git" <git@vger.kernel.org>
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox>
        <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702142150220.3496@virtualbox>
        <xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com>
        <E2C1B7A8FBF94C8CB1C9C5754D882800@PhilipOakley>
        <alpine.DEB.2.20.1702151509251.3496@virtualbox>
        <77C7E23E18774409AA1818B12C844985@PhilipOakley>
Date:   Wed, 15 Feb 2017 16:20:29 -0800
In-Reply-To: <77C7E23E18774409AA1818B12C844985@PhilipOakley> (Philip Oakley's
        message of "Wed, 15 Feb 2017 23:57:23 -0000")
Message-ID: <xmqq60kb0ywi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> It may even be worth 'splitting' the pu branch sequence into the
> existing pu (with merges from series that are selected as reasonable),
> and then a pr branch (public review?) on top of that holding the rest
> of the series that have been submitted, so that the CI can do a full
> test on the tips of them to support those devs with limited test
> capability.

I won't stop you from publishing such a pr branch yourself.

For patches whose merit is not clear because the problem they try to
solve is under-explained, whose solution is ill-designed, etc., IOW,
with issues that makes me judge that they are not interesting enough
for 'pu', it is not worth my time to deal with whitespace brekages
in them to make them not even apply, to figure out what base the
patches are meant to apply to, or to resolve conflicts caused by
them with topics already in flight, etc.





