Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342F21F406
	for <e@80x24.org>; Fri, 12 Jan 2018 17:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964873AbeALRB6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 12:01:58 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:45308 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964860AbeALRB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 12:01:57 -0500
Received: by mail-wm0-f42.google.com with SMTP id i186so13380228wmi.4
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 09:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Py6aKVMpKE/vGNuMkEydCwWTvEOUrRij8Dgyvyv2EhE=;
        b=tYFIfxV9ebnYGPZukgZe3yZ8EwcDIJUbw7kPNmOnjbyTh0Cxlmt9JTVjvNps+JoUzu
         Q5my/7Vc6Q092+yd5qy5xH+LuxWRG6Tjf3Gi0MKGpKUfNav4YyMlLyvdSn/BwnTQgGma
         Uj7c9/gYG3VEGb1kocSjYiWQ4Qc2c+7rBM+UxcjfkUhSd5R7QU3T+zUpza7pw3BxT9Y2
         cdywpCd+keY34wcBvo33R36ETfsQNs8hN2DX3O3nsrrkABW5VXB0o5D/c2muWWXK0dXW
         Dnz7DOUTubyEwFs/yqNMGVpq6cZRsS+ZaWp+CF+zr8FtzDHlamntBepT86Mjv8cj3IrC
         4u2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Py6aKVMpKE/vGNuMkEydCwWTvEOUrRij8Dgyvyv2EhE=;
        b=UIMxvi2an/5B4aR31McSTXaf/R1teexnRAyvHUMIALQuehUEF2aHx4joimQV1956sU
         xGByiJSw9k5+r3E9RdXVXTUEI3HYUIg7gomLKkjTEXuB4ad5SeeSUwLjO1HuOHoSquTt
         XAnMx2QU/tjPZ0l2tryZdvOoocgAetLmTVfWHsFRmsWmjTW5ObN7QPPdRUIqtUUbQx7u
         PsathB8dhKOzkuy+6D26Jm15qli/C99cJlPxb/T4QcT7VWXZe/R94uaUVwfVz0sH5sir
         pDXBjxMhTO4IrCAfF9M607XVSwWbxWFdcF8iI63K7RvS/KF4UsNLX4bD9ASErApFm6k2
         A8wg==
X-Gm-Message-State: AKwxytduhBonC+YisjssnIuGYRAP+35JbeRcFYpCw78/JBfhIKzgE/5b
        wdwzLxxR/bH/YrvbvsiAzOPR6A==
X-Google-Smtp-Source: ACJfBovtHJofgzLEryJX/t8MFYFRUdOtJWR8AQjUwRkv9GWyyzG/Z2tLS0Ts+ZV7BQOzpN4L3yiwWg==
X-Received: by 10.80.221.206 with SMTP id x14mr7498692edk.196.1515776516757;
        Fri, 12 Jan 2018 09:01:56 -0800 (PST)
Received: from [192.168.178.26] (ipservice-092-214-164-190.092.214.pools.vodafone-ip.de. [92.214.164.190])
        by smtp.googlemail.com with ESMTPSA id o15sm13766992edk.25.2018.01.12.09.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 09:01:55 -0800 (PST)
Subject: Re: [PATCH] l10n: de.po: translate 72 new messages
To:     Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Jan_Kr=c3=bcger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?Q?Magnus_G=c3=b6rlitz?= <magnus.goerlitz@googlemail.com>
References: <20180111174401.8006-1-ralf.thielow@gmail.com>
From:   =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>
Message-ID: <cb9c9680-6ef2-f59a-b549-5082fee68496@gmail.com>
Date:   Fri, 12 Jan 2018 18:01:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180111174401.8006-1-ralf.thielow@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

thanks for your translations.

The only thing that could be changed is:


>  #: builtin/submodule--helper.c:678
>  msgid ""
>  "Use commit stored in the index instead of the one stored in the submodule "
>  "HEAD"
> -msgstr ""
> +msgstr "benutze den Commit, der im Index gespeichert ist, statt den im Submodul HEAD"


The original message has a capital letter so maybe it should be "Benutze"?

Everything else looks great!


Kind regards,
Matthias
