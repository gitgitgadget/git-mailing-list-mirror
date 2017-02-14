Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F5B2013B
	for <e@80x24.org>; Tue, 14 Feb 2017 04:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdBND76 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 22:59:58 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33800 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbdBND75 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 22:59:57 -0500
Received: by mail-qt0-f193.google.com with SMTP id w20so15870850qtb.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 19:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=cpu1uND1nBEa7pSVHdNDHMADSz/FUHjykM4CC4dkz2o=;
        b=QgfAP7nN3JBaAW3ttJOAfPeQ6Cb4dMWpmQUapIb6DqCW7Uf7vSZ+t77qlx7/Bj4T0o
         xXvmB1aVrv17bM3gsGcnZ4dR07emdJHPJ5aGPmBLeSXvg0oKQrYXq4yagDDgXkLxrmze
         YWLY9aaebHyX706scyDjauZWfVsC9T14Ilt2T4OCVZZqfvJfOFfNOh3E//LmoTjR2/M2
         sMPIFevYPnI2oLYYE5h1GkrdV/oisUaywHFn+nidwB/4vkgV7puKKZGlFmMKr4mOs5yh
         vmbTg2ye4Gnshk9O+OAn3bEgPd8cb5MsHwQqlfCfwzzW8AhKM1fz1z1VT98Y1JZl8LEF
         NTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cpu1uND1nBEa7pSVHdNDHMADSz/FUHjykM4CC4dkz2o=;
        b=s5fCGvI9fShKipJ67xr6TFGQObvaSOlfi7jFAS4eQryKpNGpU0P06RXpXigYToIj8U
         mXRIhdgLeUqcnS6BM6QMew9TiXB4HzPjb+ihmpoZ8F23oOaMUcNoU8zFzF6kL59kvQS+
         FuoYv9pzp0pokVuKDuO74TV5UIBxP2I2VEX9L02u6eKl92tRy/BLBVGGFqFJ0lH9Wyyt
         vm3ZtVMEyaN5GjjZm0h8TAMniaeQCmIap1jgbUn2sDA99k+ZA6OBo/HVXOnsdbIvdAu4
         FzXtmAHfsmiQ4UOMaa1EoDLfjJ3pgtjD3It299Zjg1PH11APbEg5O+jvhRrsCzt1EQDN
         eNmg==
X-Gm-Message-State: AMke39no6yHCpirCCb17wLRZ8zqIK9Ph2nH9XXPsGoWElp0B5O2fulVp++CMJNYJK41y4A==
X-Received: by 10.200.53.70 with SMTP id z6mr25878561qtb.150.1487044796823;
        Mon, 13 Feb 2017 19:59:56 -0800 (PST)
Received: from localhost.localdomain (c-24-131-5-126.hsd1.va.comcast.net. [24.131.5.126])
        by smtp.gmail.com with ESMTPSA id s2sm8833997qts.25.2017.02.13.19.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 19:59:56 -0800 (PST)
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
To:     Arif Khokar <arif.i.khokar@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
 <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
 <alpine.DEB.2.20.1608241509200.4924@virtualbox>
 <alpine.DEB.2.20.1702101707060.3496@virtualbox>
 <d16546a4-25be-7b85-3191-e9393fda1164@hotmail.com>
 <alpine.DEB.2.20.1702131533400.3496@virtualbox>
 <7dbe0866-4a9b-7afe-8f51-ca1d5524d4a4@hotmail.com>
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "meta@public-inbox.org" <meta@public-inbox.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
From:   Arif Khokar <arif.i.khokar@gmail.com>
Message-ID: <003e1ed8-3770-8790-7ed9-2fc5766711d5@hotmail.com>
Date:   Mon, 13 Feb 2017 22:59:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <7dbe0866-4a9b-7afe-8f51-ca1d5524d4a4@hotmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/13/2017 10:56 PM, Arif Khokar wrote:

> I wasn't aware of that expectation.  My idea was to use NNTP as a way to
> facilitate the development of a new git utility that would serve as the
> inverse of git-send-email (sort of like the relationship between git
> format-patch and git am), rather than using a

...custom script that's tightly coupled to gmane and public-inbox.org

