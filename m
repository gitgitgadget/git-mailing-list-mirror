Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A20D200E0
	for <e@80x24.org>; Thu, 29 Dec 2016 10:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbcL2KaD (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 05:30:03 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35098 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbcL2KaB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 05:30:01 -0500
Received: by mail-wj0-f194.google.com with SMTP id hb5so23965640wjc.2
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 02:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8a9i/bM/mroQoJGAObnrfJ5DGAgsLLGEabhtkXWKq8c=;
        b=Q95K3z9GenuXAvBmEwIFSGbQNh1n+4hxpKTggyRg6mEz3+tEZZj10mwCfnE6Lhqw+7
         TJFIskTeOEQzGddkE12D+mJljfTxFhPhE/y9jzjnFooKFa0uzlXpnetOLIr3jdSpzudU
         bzLW450g2ipz3LiTex/aAV6si3SLQYNad/ibG44jNZcQtVAKmC2IEDWR0Ba+71nC8QdR
         IpniIUNn+5oYSe/WPZxsPRuQuaG/Yu19/gyk+ZTSI8t4yHgzR0osYYcs7P0bOaPStUWS
         HXsGT1gy8omHrixv6lsUFZGhLnRN0a6mTff5iqMBClX2O1fzjAkPyO3W3yZd2TErpqEf
         Bfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8a9i/bM/mroQoJGAObnrfJ5DGAgsLLGEabhtkXWKq8c=;
        b=ULLnIWsn+D/lwF9dpdxRqFbBNacZt15YM+iAmpxv/kKGQwwyuO/e01ZhDCYR7me8+u
         RfXY7p9jb9843M+HhxTCLaBNIiVKwsiaIUjKZ8ubxBDkc40GUGXRjRuuSGksSzreTYOP
         UOsSP4Kc/Oq/ASDo6Qkqq2GwpSirQT4Nbw/C81BdM1YQMD4BnMzAxvauBMuM62hLlI4F
         3l6hMG4IuNkx2Hr4EWgkn7+cvEclEUMa2RVW/shj45P3lItNmK8rxlHVvuMs8bo2TtRD
         a/QlGKxp9Qg2p+LYmhKYgJYLbi1iCvPyLbws06pjrkmuuqBfc7EUsXcMHskH6hHlT6Td
         CL1A==
X-Gm-Message-State: AIkVDXL/DvUOGnvVBPhxscZfnYZlfvxu/WgegW445k62rsd/oaI/q4C8c7NLTlOQ9QFpOg==
X-Received: by 10.194.7.233 with SMTP id m9mr35278164wja.108.1483007400332;
        Thu, 29 Dec 2016 02:30:00 -0800 (PST)
Received: from [192.168.0.185] (HSI-KBW-085-216-063-243.hsi.kabelbw.de. [85.216.63.243])
        by smtp.gmail.com with ESMTPSA id cl6sm68202826wjc.10.2016.12.29.02.29.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Dec 2016 02:29:59 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: HowTo distribute a hook with the reposity.
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CA+P7+xoBpAV1hiZQ0WZHP-kbB9zhddMhtj_CZ1Wejdur3oPXhQ@mail.gmail.com>
Date:   Thu, 29 Dec 2016 11:29:59 +0100
Cc:     Jeff King <peff@peff.net>,
        "John P. Hartmann" <jphartmann@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <3F7E50D2-3F9C-48BB-B3BD-E27E502A639B@gmail.com>
References: <6e228b75-0208-63e8-b4e8-70905e3f9ea3@gmail.com> <CA+P7+xqHTgRvMRwgL2TJ7SRb_SR0sbtA039J_5N0xSjf3TNrgg@mail.gmail.com> <20161228060840.gelgcs2hd33id56j@sigill.intra.peff.net> <CA+P7+xoBpAV1hiZQ0WZHP-kbB9zhddMhtj_CZ1Wejdur3oPXhQ@mail.gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 28 Dec 2016, at 19:53, Jacob Keller <jacob.keller@gmail.com> wrote:
> 
> On Tue, Dec 27, 2016 at 10:08 PM, Jeff King <peff@peff.net> wrote:
>> 
>>       https://github.com/Autodesk/enterprise-config-for-git
>> 
>>     (with the disclaimer that I've never used it myself, so I have no
>>     idea how good it is).
>> 
>> I think you probably know all that, Jake, but I am laying it out for the
>> benefit of the OP and the list. :)
>> 
> 
> Heh, well I didn't know about this last part so it's still useful to
> me! I knew of the larger description for why not but wasn't exactly
> clear how to word it so I am glad you filled that in. Thanks!

Author of the "enterprise-config-for-git" here. The version in the public
Git repo is a stripped down version of the one we use at my day job for
our engineering workforce. I tried to extract the "generally useful bits".
Unfortunately it cannot be used "as-is". Don't hesitate to ping me if you
want to learn more about it and/or if you have an idea how to make it
better suited for open source collaboration.

Cheers,
Lars

