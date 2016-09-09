Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0953F207DF
	for <e@80x24.org>; Fri,  9 Sep 2016 23:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755559AbcIIXbE (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 19:31:04 -0400
Received: from mail-ua0-f179.google.com ([209.85.217.179]:33643 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754738AbcIIXbD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 19:31:03 -0400
Received: by mail-ua0-f179.google.com with SMTP id 31so80729504uao.0
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 16:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m53sDujQQl3gLArYeu8+ZgeHOAWiBJeicp+CZWqES9s=;
        b=0Rg94SY6VhPZl8DU0Ot/Latn5UaTGvQuhHrVyi3in7inyPhQxjM8OndXAngiCD3g1o
         FK1X7r2K5I4oLd0H5hJe1kEMgbUpy/c20f0BS0UFodcAr5UxLyGGFuTI6bdC7v6mpiZX
         VrF7MbGwDmtGggtf5BOJNcaOpD9xTDSVcwsaa5CCoDICjzVCMVzn0U6CQoPVoRuevmv9
         q09uduZek1t1OCFRApJpG0oT0nB1qWOdul0odjdJ65kWfBqdVHN7shDc+d21kAfuCl9S
         Rt/g49+Blvw/DB8m1M3TB/vwd+9BWhQzKU+U7Wyi3ghKM0aCVvRfSDdnZpxe3WE5U9hR
         KPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m53sDujQQl3gLArYeu8+ZgeHOAWiBJeicp+CZWqES9s=;
        b=a3Bacj/Qx66MFHSoY7UxoYBIB6fpGtIPmkdIJlOWRazrELn0Mro2azh2SySfo2TIc8
         b2iYjzYSeynUV/5M6ASbgU06bs4sEYnN9L3XHWs9OnC9DVu28aJzARxJNllmen7L6j4o
         9IBKnMc0svyHcifBw/cBezVOoiai0YrbgehtwlmTxehyiQfDyuZY+ihWDzZiyWqPNgiL
         CUZQDTla+3F3vCD+1tDuxTLTJJC8UfKyp0Dve0msE+n8OI5Ea+cOj9//Pes2K64+CjLY
         0xASM1QHg38up2wYetzXNkSavzGG/SzDkpfQHvc++MycBoLNE7LlUoVAM5ZfTk8w/qJe
         wHVg==
X-Gm-Message-State: AE9vXwPxjAwQot++3BwlU4XWrT3SsjUyenlz718dSJFDDXokcSChcg8CIdgbU6uCCZ+nuGDEm33WuWTfre3Uog==
X-Received: by 10.176.65.68 with SMTP id j62mr4411718uad.6.1473463862307; Fri,
 09 Sep 2016 16:31:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.50.213 with HTTP; Fri, 9 Sep 2016 16:31:01 -0700 (PDT)
In-Reply-To: <xmqqk2ekc2zl.fsf@gitster.mtv.corp.google.com>
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
 <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com> <20160729181121.GB14953@sigill.intra.peff.net>
 <xmqq1t2cnvco.fsf@gitster.mtv.corp.google.com> <20160729223134.GA22591@sigill.intra.peff.net>
 <xmqqvaz7x6vv.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1609091731540.129229@virtualbox>
 <xmqq7faldpgp.fsf@gitster.mtv.corp.google.com> <xmqqk2ekc2zl.fsf@gitster.mtv.corp.google.com>
From:   Dakota Hawkins <dakotahawkins@gmail.com>
Date:   Fri, 9 Sep 2016 19:31:01 -0400
Message-ID: <CAG0BQXmNyh-5pcCudobRpG=2bTHibDYkXJEBdWBx4HUgH4Ysqg@mail.gmail.com>
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" +
 "pull.rebase = preserve" - "user.email"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You guys are the best, I'm really impressed with all of the responses
to this issue! Thank you all for all of your hard work!

Dakota

On Fri, Sep 9, 2016 at 3:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> On Thu, 11 Aug 2016, Junio C Hamano wrote:
>>>>
>>>> Do you have a preference either way to help us decide if we want to
>>>> take this change or not?
>>>
>>> I have no strong preference. I guess that it does not hurt to go with the
>>> patch, and it would probably help in a few cases.
>>
>> OK.  Let me dig the change back and how well it still fits ;-)
>
> Ah, I already had it in my tree lest I forget.  Let me mark it for
> merging down to 'master'.
>
> Thanks.
