Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E93F1F428
	for <e@80x24.org>; Wed, 29 Aug 2018 15:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeH2TlD (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 15:41:03 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:43043 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbeH2TlD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 15:41:03 -0400
Received: by mail-lf1-f46.google.com with SMTP id h64-v6so4658916lfi.10
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fjk+r86pYM0j0EsnE1y1d1ZbTIruoP3uOm/W/Zoiz3Y=;
        b=WAdPlCHbDkacwOcEze4DueRgM3QByvBvY90MqimzRXkGY86t5/zSfpJJS68BQ/oSC/
         iB90nuTdBQyY8oQel5uPW9sWor3FJpcajBBc/AnzjmPHHqW8wG9xx3jjIdFzq4w3kgw8
         c0tSllJeyUJOGqZnKA94PY3pysXMHLAcLT8q07hBO+itHkBWBAZXhH3DLNwUc3jpe1xZ
         qLENb7uUt81dS3amL3sj2T91/UPjJ8wmxHp2Mnyxyhy/C0LGjGit8sNQZraivaprqVdk
         ybrY22oAHA17R15zn7m2ApZnDYnHgRnCWMW5tiaLCxdNjLkNRDOTc8yAYjy2XuTJVQFs
         JZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fjk+r86pYM0j0EsnE1y1d1ZbTIruoP3uOm/W/Zoiz3Y=;
        b=FzMKILsEdwFNVCNVE0W/IUPfGueT1PEiI/Wv7y4qGUfVNbQ3zkpehlqPl1DH4d3Ov9
         PZDbdTyHylBtc+VzokjKOmSMxFDc1XcK/vNm4TKr8bzo6A0vxAtJzClSRm+Uhpb6tuz4
         PdsFgl6RYNH/JTHvU3CzhbfaVE9IIPVOuy7aj7yhZPwKtD4L6R+dXY1IQb2TzjVnfuO9
         Kzdy/vIHjSaa3H6IlcwXw+SsIDJl+rQWQ5v6eNU3OIjHrB1O5PiPS3wPHgQuKJZhEyKC
         JY8rgWDXiwWfLvscELKRbOWFQoWcRQi/hHmdjUa0vEsn5At7Qc95eIpbf5iWQ2hRFwcc
         ozQQ==
X-Gm-Message-State: APzg51BJD2w+HkaQqnuKXklWV29h6UztUzeVIzOXddG8p4n6ucqqKeqK
        GsV0Fb4m3nEgpAZKV91Li/J4wnNjKIU=
X-Google-Smtp-Source: ANB0VdaezTZbPjnr7uJBrehtIglWcicGOXjqq8y9rlfxHNTtn1xz8gN5JZqrrjY2AbI3Y7KT6kBGZQ==
X-Received: by 2002:ac2:4308:: with SMTP id l8-v6mr4942778lfh.35.1535557410365;
        Wed, 29 Aug 2018 08:43:30 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id f25-v6sm760895ljc.97.2018.08.29.08.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 08:43:29 -0700 (PDT)
Subject: Re: Thank you for public-inbox!
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <nycvar.QRO.7.76.6.1808271552580.73@tvgsbejvaqbjf.bet>
 <20180829050745.GD15274@sigill.intra.peff.net> <20180829100243.GA28180@dcvr>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <3eb1c5e8-3e89-0d2e-30b1-339f38c4c703@gmail.com>
Date:   Wed, 29 Aug 2018 17:43:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829100243.GA28180@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-29 12:02, Eric Wong wrote:
> Anyways I hope to teach public-inbox to auto-linkify Message-ID-looking
> strings "<XXXXXXXXXXX@XXXXXXXX>" into URLs for domain-portability,
> (but it's ambiguous with email addresses).  But yeah, I don't
> like things being tied to domain names.

This would be very useful for people who use MUAs without
Message-ID lookup capabilities, even without domain-portability.
