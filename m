Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057CD201CF
	for <e@80x24.org>; Thu, 18 May 2017 12:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbdERMGY (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 08:06:24 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38177 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932537AbdERMGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 08:06:19 -0400
Received: by mail-wm0-f52.google.com with SMTP id v15so50084976wmv.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 05:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=F2AvfYYndq856kIBUWZsm5CF39+Z7dTyASWeXELWZ/U=;
        b=IzZK7yoKd4BTkR8q48paY3wEMzQkOm9ZQ5rWYMTXFfLsPkF5O33LM9Giorw7souEQq
         m+QQmz0yt6nGvjQDEPzX2psOyamoVk/A4WLr/mFUD71rMqdop6pTZBfJClbH6Lvt3c/v
         7ZZFn3Vygpmc1ef20GBpCDOdl7ZhTZhqBrdRJrlhLdneUGZBpWv9dZ3zRYGm0F4r8ti5
         1kNWgMSbpgr8HMRzW/bhPcyKlQyENh/bJeeS4PQTQU0jNJ2kKxfY5Vw03N2bBt4Pcr/B
         F5fbckqhi7sxPNFmNhCTa71gLlyhLQ7lVkAxNynqRqN4lm/cw2KcIBBYfe3QjZretCdu
         +y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=F2AvfYYndq856kIBUWZsm5CF39+Z7dTyASWeXELWZ/U=;
        b=dZM4nraod9xNN6XKvzLUs8AdW1yPOH5YEMSl19VDNK51WhFqdJ58uoY9R0meWBcE3E
         kEq0i3JlQqy5h2LieGSwoV0DtqnX0csKV2EqM5zzrEmfcdvGSZ2LbishYcaRY6dWB4i5
         HR+OrOTF570JoEwUYmpjdNH88HcKFsw3gVepwtC0gA6dsgVkxQhIOp01Xl69fqtgC7Wc
         c9aqwvmoncyyO12t4vpfV5RTgA/sm/IKOgm/DGRiatye6nsQYqaes+dGNMnTk7P/SF6/
         CQU1pNGaeAHIes0n79i7tstb172gL5wR5M3sQIuhyADxaRwWktLor6Vn+f7WMBw991ru
         9V1Q==
X-Gm-Message-State: AODbwcCBFndu7lu1xXiZBAFFO2VK4lzf46vRUjWO9/CWT/Eyui6ZKVC7
        qPJ6z7gILr39dg==
X-Received: by 10.80.135.214 with SMTP id 22mr3030810edz.124.1495109178106;
        Thu, 18 May 2017 05:06:18 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w44sm1967516edd.53.2017.05.18.05.06.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 05:06:17 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: git-scm.com status report
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170517020334.ncp3c6meak4mkp2j@sigill.intra.peff.net>
Date:   Thu, 18 May 2017 14:06:16 +0200
Cc:     Samuel Lijin <sxlijin@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <469A925D-E5E4-4B9D-8AE2-A23DBA3595AE@gmail.com>
References: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net> <20170206182754.qxgzl7546i7u5wnw@sigill.intra.peff.net> <CAJZjrdXCYwbH4wtY44UiEQii+r47a-coTwLd0qYzhV3VZwyd1A@mail.gmail.com> <20170517020334.ncp3c6meak4mkp2j@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 May 2017, at 04:03, Jeff King <peff@peff.net> wrote:
> 
> On Tue, May 16, 2017 at 09:56:37PM -0400, Samuel Lijin wrote:
> 
>> So I've finally found the time to get everything set up (in the
>> process discovering that remote_genbook2 consistently induces a
>> segfault in VirtualBox's networking driver, impressively enough) and
>> am taking a look at how much work it would take to get the site
>> running on AWS EC2/DO or some other hosting provider.
>> 
>> Some things I'm wondering about:
>> 
>> - You mentioned a lot of people reaching out off-list about hosting
>> options. Do any of them look particularly appealing at the moment?
> 
> Yes. I actually have stuff to announce there soon, but was holding off
> until the final pieces are in place. But basically, the architecture
> would remain largely the same, but hosted on community-owned accounts
> (that I can share access to), with sponsorship from various hosting
> services.
> 
>> - How do I set up the ES service?
> 
> I haven't ever tried to do this in the local development environment.
> The production site currently just use a cloud-hosted ES (Bonsai). They
> have free "Sandbox" plans for testing, so you could probably use that as
> a test resource after setting up the relevant environment variables. Or
> alternatively, I think ElasticSearch folks produce binary builds you can
> try, and you could host locally.
> 
> There's a rake job that inserts documents into the search index (see
> lib/tasks/search.rake).

Disclaimer: I am jumping in here without much knowledge. Feel free
to ignore me :-)

In our TravisCI builds we create the AsciiDoc/Doctor documentation
already. Couldn't we push that result to some static hosting service?
Would that help in any way with git-scm.com?

- Lars
