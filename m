Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160931F597
	for <e@80x24.org>; Fri, 20 Jul 2018 21:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeGTWl4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:41:56 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35929 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbeGTWl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 18:41:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id n21-v6so8324326oig.3
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 14:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=4GsVnwsCjNfkMfQwEA12NdOfbqvqlMb4Px193tEt+l8=;
        b=rY1kBfEd2N+pEdP4UeDu4sqIFs/FGeKsyOkYyuwtOVN4mODvIuUMqP1EddNRynuqq/
         hFEYz5jQAgOPqeI5TCih3CQ5UzAjXlfqlhzM+qMVPr0/wCecJ224Pc8VetYYNIywJ9IV
         u+rKd1TlBr35vn1CaN524W9TsVDUGn3p4oCzGh1uKIQzONfzy+mjVJpVrkyB4L5AitLl
         fZX0oJnSEIMZs8X9KfYGSyM31bcTHigvK5dfITyXopEap44i5jfg64+TDelqwY+VPSLY
         PTbeaEAmL82GODwikCIwIR1qdFu7prgeKj9IeGkN/qm7moP9E91m+MzqC7lfmQf3V19Q
         wfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=4GsVnwsCjNfkMfQwEA12NdOfbqvqlMb4Px193tEt+l8=;
        b=hJROnmwACHHBtyLtAm9zBd+qUrvxISJuQSrot8c5TN8t4N5z3xq6bokVLyNEdFmoVm
         fqp+UbASEP82TVoB4oOIfpwdy+9d5xho1AOK7LkX77hlnokOFxDAUdFeJs9Xi+oEdztH
         qxH2e+dS+AknOVdw50wEt3f76/lcwF1fL2FequviJImGpnSDkofUuDXpqo/zTvk8lOqg
         vh/0kxScd9/o4GF9DU8Tm2hToz7Io/+5fnUDn44hS5ukAvPlWyjA/Pkpes4hd8X1m1mx
         YJk9Doc6f/XWDZmcpdVKlAfTnnY0oeh5G6TMAeUqiMZLdzmeNJ3Y24fYmvKoNGXgrUhD
         YUcw==
X-Gm-Message-State: AOUpUlEHBpDQYF+hKpWPnntpsNFZQx2rpXZxjdRq4U3p8GuaZ6gInt6R
        2ZgYefrYS3G45WWmwLaVxoQ26z3usozp4MiHzSNlXQ==
X-Google-Smtp-Source: AAOMgpeesPt3ojZHhtXYb3jdEjFfuNPD/8RioXrF0F5VKWBhmOPNjOuq0X1Yq5+NgNTD5L4L0rTtoMsGvEeF5MILaQY=
X-Received: by 2002:aca:c78c:: with SMTP id x134-v6mr486833oif.8.1532123507314;
 Fri, 20 Jul 2018 14:51:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c712:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 14:51:46
 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <20180720210459.GA18502@genre.crustytoothpaste.net>
References: <CAH8yC8=oruFBtkndQ0p9N4s23SMvjjrAC_E7zzKRSVbjEwL0FQ@mail.gmail.com>
 <20180720210459.GA18502@genre.crustytoothpaste.net>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 20 Jul 2018 17:51:46 -0400
Message-ID: <CAH8yC8m7T8k8usGnV_OYp9G=2N4_jdzLT6frme2iBrLnt5iqnw@mail.gmail.com>
Subject: Re: No rule to make target `git-daemon'
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeffrey Walton <noloader@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 5:04 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Thu, Jul 19, 2018 at 09:37:08PM -0400, Jeffrey Walton wrote:
>> Hi Everyone,
>>
>> I'm working from the 2.18 tarball on Solaris 11.3 x86_64. I'm catching
>> the following when building from sources. This appears to be a new
>> issue. It was not present in 2.17.1.
>>
>>     gmake: *** No rule to make target `git-daemon'.  Stop.
>>     gmake: *** Waiting for unfinished jobs....
>>     Failed to build Git
>>
>> There does not appear to be an option to control building the daemon:
>>
>>     $ ./configure --help | grep -i daemon
>>     $
>>
>> Any ideas on how to side-step it?
>
> I also don't see this issue, and I didn't see anything between 2.17.1
> and 2.18 that stood out to me as a potential cause of this problem.  Can
> you tell us a bit more about what version of GNU make you're using and
> the configuration you're trying to build (say, the config.mak.autogen)?

Sorry about the late reply. I meant to reply this morning.

My shell script to patch things on Solaris was the cause of the problem.

(If anyone is interested in first class Solaris support then I am
happy to help. The patch set needed for the platform has been stable
for the last couple of years).

Jeff
