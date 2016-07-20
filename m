Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE88E202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 15:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbcGTP3K (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 11:29:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35555 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbcGTP3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 11:29:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so7539309wmg.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 08:29:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=eY990IFURzZyXhT9OmLqncpnlOII8p6jCR6VqAEE+JY=;
        b=gnfSQdUMj8ap41XBBmjXJ0FouMO2PDQ5qLIWb7YJrUakZQPxxqsRdp+6j5E+SCGI8h
         HiuYWRvUejwHKFZII5Tj92ssoEVteTryZCM6njNh62Z7v4IYqM/iQSMyWC1ifHHzkwQ3
         lgRa9xj72tbVA3NO0fCEx5kT+jaauZ2YiWrJ603U8N0anOWQwHuOL58PKdxJav0G66mM
         5zGJ1Ww0kcXERT6EwQB/yI82lyazVm+MVwMCvsZl+++dCC6RbEPvCzjy52/KZu2Ye1A1
         w4T7VIxlDEVsNoVBmP2mKHvsD+cJKtKZ46GrobP9XZext3M8V87QK6t7lA5Y/vVhzG3X
         pasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=eY990IFURzZyXhT9OmLqncpnlOII8p6jCR6VqAEE+JY=;
        b=GZSss/wbN9sAjJPESAqmtld75RgBa4ewruAEqEn82GsutARVqngwDAYT0ads0cNTgT
         JmBaf7CMd8QinIyN+DemrekSzMsWez2o7J+GVi9+FqdRtU1YeWGfGTjdduNgKWzm7Io0
         +4wzntsJVerp59W/wV5c4xuJwzQJYh1VniEthA6KrbXSW3GQzIl3ZOdCElxQayHJYxvW
         xkmxKURGjto+3NByntNpU8VNfrPt7yDpcmFbXMiNNLYopNLwNPrM5zqhFfYVkjxU5r6r
         3NM1h4p8C9IrvlzFrVcpOADogTeyqv2WrUrVRQPHN+teDBPod2RFoxBaqaAVji1qVMYq
         In/Q==
X-Gm-Message-State: ALyK8tIKQ0LvhSTdkuEEQoYj4aoCQk5f4Pe09E+wcMRgSemvGDodOQkfpRn065oDEJnfWQ==
X-Received: by 10.28.69.203 with SMTP id l72mr11398720wmi.51.1469028546043;
        Wed, 20 Jul 2016 08:29:06 -0700 (PDT)
Received: from [192.168.1.26] (daf247.neoplus.adsl.tpnet.pl. [83.23.5.247])
        by smtp.googlemail.com with ESMTPSA id o8sm1804938wja.15.2016.07.20.08.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2016 08:29:05 -0700 (PDT)
Subject: Re: [PATCH v1 5/6] Add porcelain V2 documentation to status manpage
To:	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-6-git-send-email-jeffhost@microsoft.com>
Cc:	peff@peff.net, gitster@pobox.com
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <578F98BC.9060201@gmail.com>
Date:	Wed, 20 Jul 2016 17:29:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1468966258-11191-6-git-send-email-jeffhost@microsoft.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-20 o 00:10, Jeff Hostetler pisze:

> +Porcelain Format Version 2
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +
> +If `--branch` is given, a header line showing branch tracking information
> +is printed.  This line begins with "### branch: ".  Fields are separated
> +by a single space.
> +
> +    Field                    Meaning
> +    --------------------------------------------------------
> +    <sha> | (initial)        Current commit
> +    <branch> | (detached)    Current branch

I was wondering if all possible combinations are allowed.  It turns out
that for technical implementation reasons it is not possible to have
"(initial) (detached)".

Just something I was wondering about, no need for any change...
-- 
Jakub Narêbski
