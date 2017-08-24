Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2000220285
	for <e@80x24.org>; Thu, 24 Aug 2017 15:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbdHXP3y (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 11:29:54 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34456 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdHXP3x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 11:29:53 -0400
Received: by mail-qt0-f180.google.com with SMTP id 69so4817150qtb.1
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=KJXT6pI0zg5naLkJo60oyYjYh0dTMSV2nMLP+YRg/kM=;
        b=ujPwupqF1T2Guy9Xubib647MKBqrKispcdPrbapb9NUdUtgwKvCX8vM0PQvdARsnAX
         6mMl91BajE8pv5cjSGXkm/7jgPiyWxm+OVKkyQK83Dk7qIDFfFY8BONFCo1JIK5rnnvG
         vhSb/0+lexIpVmHpKs1X3mZRqaoxSreTIAbc2eMFSGDiqfSSzWwjv5PHEBsss8MJ7TRB
         CQlgTFT4K8PJ3mjIHplFhtILhWt3HTg2a+2JQ+4Z1TiVWMDAZuvG93iMas3AryXbiZGl
         kRkFLP9j9NmhIfB6v2lsEhLI63v1BvCKsrMOLR3XuHVi16Qk8HlP6RgTf6Cjci2KGgvj
         HNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KJXT6pI0zg5naLkJo60oyYjYh0dTMSV2nMLP+YRg/kM=;
        b=t88IcjJeI3KHvjeNtRaKQnvNc94DVBfIaZH6lGuuN0OsXP8w7Vj85Ouh9yjPPyP5l+
         BAl5B8LyPke7iZVXP4mNDSd5zdLd76FSTTV1QAdU+eTAfKfrcpXPH9IGVELs+T7Rb6D5
         1T0i0xnfs0sFpxDROzQEar6qoT6wffDIjDZ/rzkGRofzIwqanly7iYexSNDYy8/d6MyD
         ALGyPB5IM/QpR6DWMalu14Lz6LCEIMT4Xf1v/znIyEzqPti0m05E7EoUgZY6leD0Uag8
         1BJrVV9pfYBssX85oUMSofFxs84JBqkitNN8P9gbii04r9YFj2fYhlUaCw9q+Ud6GBiG
         JxpQ==
X-Gm-Message-State: AHYfb5iydVkInaAyeKym6gBGWEeDYqennG7ucK6NYIOk+5qX/EFHRFcp
        SnD1kFGaSYJ50CFk
X-Received: by 10.200.34.173 with SMTP id f42mr9605253qta.150.1503588593132;
        Thu, 24 Aug 2017 08:29:53 -0700 (PDT)
Received: from ?IPv6:2604:6000:b40b:7800::5? ([2604:6000:b40b:7800::5])
        by smtp.gmail.com with ESMTPSA id y66sm2608960qke.21.2017.08.24.08.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2017 08:29:51 -0700 (PDT)
Subject: Re: [PATCH 0/1] Add stash entry count summary to short status output
From:   Sonny Michaud <michaud.sonny@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com
References: <c3ac0335-4f41-40d9-00ee-2a4e115bcf7a@gmail.com>
 <cd00912b-5b66-f299-87bf-52aa19d90270@gmail.com>
Message-ID: <45c23aab-bf20-d234-1e08-e6f0358f1779@gmail.com>
Date:   Thu, 24 Aug 2017 11:29:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <cd00912b-5b66-f299-87bf-52aa19d90270@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/22/2017 11:25 AM, Sonny Michaud wrote:
> I am just bumping this thread; I presume there is something amiss with 
> my submissions, so if someone can let me know how to fix any issues, I 
> will gladly re-submit the patch.
>
> Thanks!
>
> - Sonny

Bumping again for visibility.
