Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991931F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 18:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKSSZJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 13:25:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33235 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKSSZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 13:25:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id w9so25087739wrr.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 10:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/DZRim46ckvxnZ/nX5K5FkcosOY04aA8jv/SLrSs9CI=;
        b=QUHXnVjaSlMl2QNkm3HbJ4ohshZnTn+Ei135mL+cH+IAJb2C53hBAhy9te1x7qLrCO
         yCJ1eBAKpEhRQn9HgbP9Qr9J5wszQZLWJA1Hd73lqzbWqskNT0EIUj9dxBRECehru/1D
         P0Ey8nzlxwzi8mFm3AO+idkCkrdrLwrog+F3rGsXV0scMpkIy10UtpZvgCkpQUsRTiYC
         Cr6mRP4iMpYiqsmY6JLN4U3TAR2Ip9Em23zAWzEyiK96HydGElJjiJX7CgUzXK43acvC
         0sPv9D2IVMqJU0YlgxLxQ4aaFmVRn90SDSG+ceGp1vHZY0xZctmf10hCzplKHBx7ecoM
         H+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/DZRim46ckvxnZ/nX5K5FkcosOY04aA8jv/SLrSs9CI=;
        b=G8NbmVPR4U0IehDg7Syb+tjHPV+sW5Df7JvTP7vH3h3/GzJvCN0DhN/nfZsKsc1mOy
         4WXwzIPXXq7r8LCcSzichicqCNY+VHeIoCTZdpTdCi1mxNsoIadd2Xr5t3J0MJzzmUws
         9nrN04pS/mkrkII+ydrK1qZ8Y6JWEmXC109dCs+cCDarDO1yVyNs+YmPhWEDrWO21S6P
         kQ9t7ZBTRzOkAk16g4K1swdWex4Hsx4GEPSbHPVGklr3i02eqW1EYvdBB3GpUBnTFMup
         w4M9gvpnbM1nsUDEyTugDDVbF8RzwlzViaP5zUL7V/XFyIuM5C93Zei8D63l3ai4Y2PY
         HkbQ==
X-Gm-Message-State: APjAAAV0wR3szPJ+hJGVI+JF103jr+uDZSYhLYa3cATFsyrWuHUVzGkS
        RVQESdWvKYz5taZqS5M2Ag0=
X-Google-Smtp-Source: APXvYqwUL+yrYld77UOTDtZIp7o/Q1KFoYp8U9aNCO4MlXoILwL31bMEwF6O30B409CTGQBH9HlCmQ==
X-Received: by 2002:adf:c00a:: with SMTP id z10mr38454037wre.81.1574187906913;
        Tue, 19 Nov 2019 10:25:06 -0800 (PST)
Received: from szeder.dev (x4d0c2755.dyn.telefonica.de. [77.12.39.85])
        by smtp.gmail.com with ESMTPSA id p15sm3929527wmb.10.2019.11.19.10.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 10:25:06 -0800 (PST)
Date:   Tue, 19 Nov 2019 19:25:01 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add avenues for getting help
Message-ID: <20191119182501.GA5076@szeder.dev>
References: <20191115215342.37408-1-emilyshaffer@google.com>
 <20191115230637.76877-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115230637.76877-1-emilyshaffer@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 15, 2019 at 03:06:37PM -0800, Emily Shaffer wrote:
> +==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
> +
> +This IRC channel is for conversations between Git contributors. If someone is
> +currently online and knows the answer to your question, you can receive help
> +in real time. Otherwise, you can read the
> +https://colabti.org/irclogger//irclogger_logs/git-devel[scrollback] to see

Nit: there are two consecutive slashes in the middle of that URL.

