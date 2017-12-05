Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF9F20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 19:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbdLETrY (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 14:47:24 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:43832 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbdLETrX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 14:47:23 -0500
Received: by mail-it0-f66.google.com with SMTP id u62so4439091ita.2
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 11:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SqTpHN8WStPifqyjU4VjpGkkHWAjJoHQA2VSUShuEVE=;
        b=lMCE0Z0Uta+GA7fnJBUt37SmvN5NDqcnD5rkb4iIapblaFI/afQH07K8UW9iQRXsD+
         LJIxnpOO6mcbK1eVSrxWWbSOPw1e1eYhI7W8cpM+p/+GNjCZTfPZq8P0dyRg5t1iKMwn
         6HCkycAFZ9c+H3fyDc+uEPNotXUXumQ870u1vk7lcPgfpV/AZv404tvfyvjERWXtTPAT
         tgQxm+vuA6i2xjirNEfKTPdMu4zmlEc9CmfZAlP4AEYDXvYpJgIpFp0xgU/XJV0Sb0jg
         9lwmhzD2nyMvd3zYl5OrRlc6yLg4nYjJ/I9rWEKGJVkWUgH6zb0BVVYnRaeATm7IV89j
         q/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SqTpHN8WStPifqyjU4VjpGkkHWAjJoHQA2VSUShuEVE=;
        b=CK0i5c6mmbxaMiGhI4sDqZQtg+PpM5Pl5w8zvAhxsbU7tLGoNVpBNuYbSGegumb7wd
         Kw8dLE6i1sJIAmH0L6egicQL0xcw+lruAVcv2R8BNuTOJmMKsOA2ZP8Pe7rN3weWK1lK
         TooeGFxR6vo1EnDcJlXCa6PqnUIZr39EvmUvOqOoSMlip/lnzvWKcMGRdi9bLyO86GkJ
         RE2OS24QqUUX3YjvBFTPr5EzLT7zEWGimArzBH0pp8N2PhpDstmmbS1W2F/kGZMrNWih
         4/OubTbUT8PYSQiPFYBiIp/3fO+U9fo/GNWJ2886VoHJwEeR3/gZV4S2DVeP+8RIcfFK
         90fQ==
X-Gm-Message-State: AJaThX7jQ4B1EwSCWbdckWY8YyyKy/AsDfSyIgTJ8s1QRVvArnrhz3kB
        WAwE/Y87VrVaawpus1l+8nI=
X-Google-Smtp-Source: AGs4zMZw8Y02J2zaPFQS0wixdzmTE4nqfVuE6owfxDyXSLkSf916Y1XX19Pn/Nub/58eQWD0JQi7kw==
X-Received: by 10.107.53.98 with SMTP id c95mr30157949ioa.199.1512503242507;
        Tue, 05 Dec 2017 11:47:22 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k18sm556823itb.32.2017.12.05.11.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 11:47:21 -0800 (PST)
Date:   Tue, 5 Dec 2017 11:46:45 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 2/2] t/README: document test_cmp_rev
Message-ID: <20171205194645.GA8183@aiede.mtv.corp.google.com>
References: <20171126202100.1658-1-t.gummerer@gmail.com>
 <20171126202100.1658-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171126202100.1658-2-t.gummerer@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thomas Gummerer wrote:

> test_cmp_rev is a useful function that's used in quite a few test
> scripts.  It is however not documented in t/README.  Document it.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  t/README | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I admit I usually go straight to t/test-lib-functions.sh when I want
to find an appropriate helper.  I think this kind of introductory
documentation in t/README is still useful, though.

Thanks,
Jonathan
