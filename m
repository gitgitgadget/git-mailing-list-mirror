Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A0320958
	for <e@80x24.org>; Thu, 23 Mar 2017 18:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935629AbdCWSUH (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 14:20:07 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34591 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933773AbdCWSTw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 14:19:52 -0400
Received: by mail-pf0-f176.google.com with SMTP id p189so86060169pfp.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m7pJBwBhKZUbW8pVeHA9YpdiqTieuripPviLNEfH+lw=;
        b=ASDt9pju93zOX1INnc2tnkSJ8I7ecOlSx0+zT1ZzVsb587GqNx6birGQ0AOu+lp0OG
         3HphCXbDi4H3YQGCpUDRkmtuSrI4C0TZwgzJxdXy988MASP1zDLD1JpCF9vtpBher28E
         qnpYObMSp7CrM+hGnBR5Dsqe98YxVaNHgy+c0OLDJFT5s3t5DSMarDy4QerPi+6hAkEW
         dDrKPrg8iGdnNAtLjKQy29u930pyKTNBQRVJ7uxM2YNRldbNoOOdBpSCPEiUr1ZTDgiy
         qPIV4Nl8Mxm1e7t65RGHOKgPGvWrtECN8hU95240scZ4hhLdytz10Ly+svcEf5xplyC1
         z0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m7pJBwBhKZUbW8pVeHA9YpdiqTieuripPviLNEfH+lw=;
        b=kO6MQ4HyGogMbcJm4X0ksW3/MgK1QTq9/q4b+yaltnLz/WjPetskHpBwVztY7nYE++
         qwv+yfbjUuNy+Ep6ZFX2GADE2nnGy40FN3W3X7TN8+dxYoFy/ngHGXHqNytsfMIlA/Rs
         Vk76+y9fXyWcyTGVApCLHhJmugwkAWMIEr7ak/idbJ8Zv4GCw/BQ1eHO7D48DjQHhglV
         299E2p3HDO3rujNTDZessIJotlSW74v18juIZIBzdrA4QZMEFqhCPOXViEIDanTHhuOo
         T7J3K1IVMO/TV2+dMG1mNoa8EqTaTVWvW0jreHGxsnVkJblSExrmVqaXG1L4ZGKtUvzN
         74Gg==
X-Gm-Message-State: AFeK/H2dKsI9a/qIilEZCvu/TNsJgfhN1QzkiE2QBESp6wFRJUoYik9IYTqjI6suAxdrL1bp2SYsj+/o+cpXlIIs
X-Received: by 10.99.137.66 with SMTP id v63mr4321509pgd.183.1490293191211;
 Thu, 23 Mar 2017 11:19:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Thu, 23 Mar 2017 11:19:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1703231827060.3767@virtualbox>
References: <20170320164154.xBcU6rG0C%pickfire@riseup.net> <CAGZ79kbF+O6tgn-4ivmOza3QGA4oFyJS=9eGHYZ1HQgw6+rEtQ@mail.gmail.com>
 <20170321060526.sXz0cdJwc%pickfire@riseup.net> <alpine.DEB.2.20.1703231827060.3767@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 23 Mar 2017 11:19:50 -0700
Message-ID: <CAGZ79kaR6FdoddiZXvSs+xYwGW4cS5r2EuLWNngA5a679puPNw@mail.gmail.com>
Subject: Re: Re: GSoC Project | Convert interactive rebase to C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ivan Tham <pickfire@riseup.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 10:30 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> Are you sure about that? From what I had looked into userdiff.c, there
>> is no support for shell. There just a recent patch for [go patterns][0].
>> Or perhaps I should have rename it as "userdiff.c: patterns for "shell"
>> language"?
>
> I also could not find any shell patterns in the userdiff code...

Sorry for the confusion on my part. I am unfamiliar with that part of the
diffing lib. I based my assumption on the output of "$ git log -p t/"
which contains hunk headers, that make sense most of the time for shell
code.

>
> Careful. It is a ton of work to get the rebase -i conversion done, and
> then a ton of work to get it integrated. That will fill 3 months, very
> easily.
>
>> > > What do you think of these projects? Would it collide with Valery
>> > > Tolstov's Shell to Builtins proposal?
>
> I missed that proposal, and could only find submodule-related mails on the
> public-inbox server. Care to provide a pointer?

Well I don't think it is a full grown proposal, but a confident attempt to
find a good starting point :)
e.g.
https://public-inbox.org/git/1489145258.10535.0@smtp.yandex.ru/

>> > Curious why all people ask about colliding with Valerys proposal here?
>> > I do not think it would collide, as submodules and rebase are very
>> > different areas of the code base.
>
> Indeed ;-)

Although I had some discussion on what the correct behavior of
"rebase --recurse-submodules" in a superproject should be. But this
sounds like future work after the GSoC is over. ;)

Thanks,
Stefan
