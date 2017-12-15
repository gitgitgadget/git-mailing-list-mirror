Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4BA1F404
	for <e@80x24.org>; Fri, 15 Dec 2017 01:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbdLOBSH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 20:18:07 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:39751 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754580AbdLOBRp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 20:17:45 -0500
Received: by mail-wm0-f54.google.com with SMTP id i11so14660015wmf.4
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 17:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rG7ERJu4auVGLYc/s4P/7ydasACgz8n2zzE0lG1xr+Y=;
        b=j6nkq0PYnjksw8uxAu1F2Nr1hGGW8wY6O82lt1zSx8umPvIpTwhlfMLuxn6rlkBmeJ
         7U250i8YkpTGSN7GlOmfiYcBiFlruk4jbcaQElPpBA8HlztG8xxf0/MwxhrfOIqoK7oE
         4KC1l4W19kJyEBrQsYMeg0aw++NcfRm4ckyesX3MW8JyNCj+shB7/dUxVdeZ+s6eypCg
         y9I2EKKx0nUhG2qUSpgdQ7XS4bQ94ea1MC2sOPi/h/XdzoRrFOUNxMVopSH6xGb/0IaY
         Xb06gkeaOtx4hbgzd/9aj+7bmcUNLmTbnMz9/2Sku0PNFUFJbD6+1XXrM3UibjJBjex5
         0sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rG7ERJu4auVGLYc/s4P/7ydasACgz8n2zzE0lG1xr+Y=;
        b=rgdgWkEa5tZwOsiMJFGTVLc04WnrdsuN6z0CsqTLZNdrJodFQ9rC6SJmpAkh9R6B4P
         zFjklRwsEv8BbX2+thNmMvACQAbjH9wsVyDL2R1C25Gc6tU0cJBe7sJ+DK6zDDDfE284
         GyA22Sn+FEOpoI+cPl50qZ8XHafsqRh1X5o8uKRvyciElJG/sXyjAo5GVz5NEcekFU1K
         Q3fyrjFS1oklc6d8N1TRDoeRC20CVaTT4ZVxPmxh/datCAjobPGz0TUhsvhrzXKiFHzs
         VcsyOHoXLI0W4lbZu8UVaB5kJ3u/h4ybbyy1qcrFVowseww5zJEhTxnC+vL+T7UTtDST
         g58w==
X-Gm-Message-State: AKGB3mLnpvlKe4YHqPdYkRxC0DVL+fcB4g6s6RKY2YXoaYv7MhjLaL1h
        WG+NqY3Fdwiw1RWdSDGoRUsbYFNI
X-Google-Smtp-Source: ACJfBoubF39Q0q7ObW2oxvMWiQWjBSDjwJMxxwZmIsOnBHtu7AWkpU7itC/0Upon0Z+jR/EQnvfoeQ==
X-Received: by 10.28.61.135 with SMTP id k129mr3527398wma.81.1513300664412;
        Thu, 14 Dec 2017 17:17:44 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 127sm8981586wmk.14.2017.12.14.17.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2017 17:17:43 -0800 (PST)
Subject: Re: Need help migrating workflow from svn to git.
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Josef Wolf <jw@raven.inka.de>
Cc:     git@vger.kernel.org
References: <20171214130933.GA18542@raven.inka.de>
 <5eb3fe18-864d-0b04-223e-d9e5cbf2c81e@gmail.com>
Message-ID: <b25a828f-3f0a-7c0e-6722-9521238ce7f3@gmail.com>
Date:   Fri, 15 Dec 2017 02:17:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <5eb3fe18-864d-0b04-223e-d9e5cbf2c81e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/12/2017 23:27, Igor Djordjevic wrote:
> 
> As you basically have a flow where two users (you and cron job) can 
> edit same files at the same time, desired outcome might be a bit 
> ambiguous, especially when scheduled execution of those files is 
> added to the mix.

This said, and without having you to change your habits too much (nor 
use Git in possibly awkward ways), I`m thinking you may actually 
benefit of using `git worktree add <temp_copy_path>`[1] to create a 
temporary working tree ("working copy", as you say), alongside a 
temporary branch, where you could hack and test as much as you want, 
unaffected by cron job updating and executing the original working 
copy/branch (also not stepping on cron job`s toes yourself).

Once you`re satisfied and you commit/merge/push your changes from 
within the temporary working copy/branch, you can just delete it 
(both temporary working copy and its branch), and you`re good :)

p.s. Even if you`re not familiar with Git branching and merging, it 
shouldn`t take too much effort to wrap your head around it, and it`s 
definitely worth it - and actually pretty easy, even more if you`re 
working alone.

[1] https://git-scm.com/docs/git-worktree
