Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BBFA204A3
	for <e@80x24.org>; Sat, 27 Aug 2016 22:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754947AbcH0Wih (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 18:38:37 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38557 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbcH0Wig (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 18:38:36 -0400
Received: by mail-wm0-f54.google.com with SMTP id o80so39424130wme.1
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 15:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ScWxJdEeH7qMN4mjlZn6pQu4xyxe9OCLHE4AXfmBceQ=;
        b=iwwbd3vRN3RkTPpoUvIHd2j4eibLNPQG/NVpnGD2gEhr6E3dwIa+GnkRUGTJCh+aL/
         fVcZpKIobwmq9fFe6m05pqap/fH/M3/8KI4j2C69Ha45nbxaCx09K02kR70beUo/Mv2z
         GOQ5pX8dwPIWz4lgqJ0zdqDIloANBK/Uk5DnFS+ZudxCD+B0nUCe6C8aQ6VFIqwkK7Pp
         cXOYY16uyrGPYbUsNFkdCTk0BFgAhdVr5CSKOdnlibIxtX9lP1AQayizTbpKHcBrYWJ6
         OxgWS9DisAsmsV3GZhOFAfLaZse/D6GNZxQwiNdwAV8dJjom4xsF1CP2wljKJVW6LycM
         xZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ScWxJdEeH7qMN4mjlZn6pQu4xyxe9OCLHE4AXfmBceQ=;
        b=fIBigpNzIU9Bb+SdUD0lQrZHJFvHEgcTKOr58M/NloMRqPuo+2Vb78wbUqrr+edIL+
         vgo04J5kD+UA2gL/l0dW1XaHpAkHCUf0S4dRj1m/Acu548dNk5GGcMKjVTo5QzXt4oAH
         I8BJ6busXlRVPLA0mPxjKVnhdwUNSlv/RrYeA0w0eBkJdP4gJguE+IWfXg/UJUebYsO7
         UyHuEMLloo0VJHrT2mUgVWyAdn3rIvBVIwh/yPXoNz0FqD927fVaPPFJj6rTGfms6LhM
         4JXZqKmFmxORgVIZHwE+CDsqDvZ2SHWxTBcKM9xokP2RkcySZAOkeiKHY5V5G80fISV6
         mfLg==
X-Gm-Message-State: AE9vXwPLTmWSpyP3lYl7KX1/X/XLzK9CEIwXMfAYrPWBruAOx7nAzhsMii8UgdeJldB7ug==
X-Received: by 10.28.109.197 with SMTP id b66mr4637732wmi.68.1472337513733;
        Sat, 27 Aug 2016 15:38:33 -0700 (PDT)
Received: from [192.168.1.26] (enk96.neoplus.adsl.tpnet.pl. [83.20.0.96])
        by smtp.googlemail.com with ESMTPSA id 142sm5683756wmh.12.2016.08.27.15.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Aug 2016 15:38:33 -0700 (PDT)
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160818204902.GA1670@starla>
 <alpine.DEB.2.20.1608191720040.4924@virtualbox> <20160819223547.GB16646@dcvr>
 <alpine.DEB.2.20.1608221509010.4924@virtualbox>
 <20160822225549.GA25383@starla>
 <alpine.DEB.2.20.1608251457310.4924@virtualbox>
Cc:     Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <d2c4d54f-e3be-8e17-860c-d9b8bacf68e0@gmail.com>
Date:   Sun, 28 Aug 2016 00:38:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608251457310.4924@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 25.08.2016 o 14:58, Johannes Schindelin pisze:
> On Mon, 22 Aug 2016, Eric Wong wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>
>>> I just want developers who are already familiar with Git, and come up with
>>> an improvement to Git itself, to be able to contribute it without having
>>> to pull out their hair in despair.
>>
>> We want the same thing.  I just want to go farther and get
>> people familiar with (federated|decentralized) tools instead of
>> proprietary and centralized ones.
> 
> Why require users to get familiar with (federated|decentralized) tools
> *unless* they make things provably more convenient? So far, I only see
> that this would add to the hurdle, not improve things.

Arguably for some federated/decentralized tools are preferred
(for philosophical reasons), even if they do not achieve even feature
parity with centralized tools (c.f. FSF).  Though Git is not there
to improve the world, just to be better...

On the other hand some may say that centralized tools (such as GitHub
and its pull requests) do not achieve feature parity with email based
workflow... though the basics are here.

Best regards,
-- 
Jakub Narębski

