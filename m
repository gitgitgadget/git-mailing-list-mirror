Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 932F11F404
	for <e@80x24.org>; Sun, 28 Jan 2018 20:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeA1Usf (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 15:48:35 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:43600 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeA1Usb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 15:48:31 -0500
Received: by mail-lf0-f41.google.com with SMTP id o89so7044342lfg.10
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 12:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yqJPQbF++xCPzELRDMfr3X3SZGftCfNKDmQIFYddKhE=;
        b=e8Dy75aF5Ex5Tr8LrFag8C2hdKs1OXkqYzYnB09J9WZTyeJDfH790tAuWPVuWPa0Nr
         Gy59mA+pWdQQd54LljGezyMY0b26m8byRr+/L327Ojpo4VLoG2DkG72faknvWfkPIN6o
         u732Xuj/KRKueFnDApy2mtCn8xWeSHWOC602bzuAhk3gRsAwstpJLvULrpGUZ9iqPZQr
         5KyIXcAH3DRieFG4I7YTbUe2sQKtrLXKMBmvIJb+kv0fD+nG1hM3MmjpDXyz95f/bwLv
         yhj/MdO9raoFP7hmmfZf9gZnoZf5OxZM2ifJR0pjAhUFe5cc2W3zR70Ek0aVZMmY1pux
         8Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yqJPQbF++xCPzELRDMfr3X3SZGftCfNKDmQIFYddKhE=;
        b=eFglcLxuVREui2n9dOEf+kz7p0wzSBxZLJMJVJ3UIBKd+u4ZaFsGKP+0+YNRG4U5Y3
         PgLXuWAC7lMLTpfDblFsZh6sKIWK9KgT3n6ZNzU6XWuttDOfeMcWArZGaN8ABowoZnpm
         NgmldkmJg2WRkmVBxtaxdn7AmuAvvIcyYlHDn0TB2Ybx/1g8oh4XgLuBf/mNg7XVpRU9
         a6fPhD+J/vJZhcv/Bk1wgYtfxT+nb2xeE//V3OzcAyXooBI0cp59bErG7WezyrXBFuPl
         KYstLnxhVp76xMeVb3+9F/juOTlj2Z9+eOnzG5M+UC0m8gxMgq+3eB86fCIWx+u4B5Ly
         iUQw==
X-Gm-Message-State: AKwxytcjgraUj0fZMBGwMBlOKElhZOnaz35b23ffqE/drLV8joOcnL8e
        L8Kdv4NEk97G/iE4ct7i2RA=
X-Google-Smtp-Source: AH8x225kSVDsMNDDxPzXbyMlMe2TDXYFHFJmJgfavaVP2Kbggnk+R/21UmKPs5BiseMRTp2g96lGvA==
X-Received: by 10.25.23.27 with SMTP id n27mr5660330lfi.89.1517172510265;
        Sun, 28 Jan 2018 12:48:30 -0800 (PST)
Received: from [192.168.1.138] ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id n24sm2612240lfi.18.2018.01.28.12.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jan 2018 12:48:29 -0800 (PST)
Subject: Re: [PATCH 00/12] object_id part 11 (the_hash_algo)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
From:   Patryk Obara <patryk.obara@gmail.com>
Message-ID: <1f464382-51f7-1e3b-509b-73f7fa49488f@gmail.com>
Date:   Sun, 28 Jan 2018 21:48:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <20180128155722.880805-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I looked at your branch object-id-part-12, and it conflicts with my next
batch of object_id conversions in quite many places (mostly through
formatting). Therefore I'll hold my horses and postpone my conversion
patches at least until part 12 will be sent.

-- 
| ← Ceci n'est pas une pipe
Patryk Obara
