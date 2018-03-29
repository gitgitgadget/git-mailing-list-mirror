Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDB411F404
	for <e@80x24.org>; Thu, 29 Mar 2018 01:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeC2B6z (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 21:58:55 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:42245 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeC2B6y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 21:58:54 -0400
Received: by mail-pf0-f176.google.com with SMTP id a16so2147001pfn.9
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 18:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JKh4T1gfBh8L7mx6Yk2xtZb0Kroj6ymixhBdNrwyGSU=;
        b=Q9z6frTGJeONWOtDQ9D9v/HTF1ziiqdbfz4WYsP36d7WnqEfcUX4y6Pd6yxiOxIA/b
         OJy+HlsdzNhKeCSZWrT1wEKtquS0guFNyEHZj98oUdKGW5NBYYjohgC31ipEhkK/MAvU
         3+SJdvyvIcSvRQitrTppvzpC2Z5kmOCXBcyLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JKh4T1gfBh8L7mx6Yk2xtZb0Kroj6ymixhBdNrwyGSU=;
        b=n4b1YlOYdpWDDb9u6yWN6soHRVF8ac0YEdG1TKTXeqVYPoZUIEgvcvIcs5PM0ZD+eP
         5+3Gpeq0Qj+fIQdX2DLAIGDH0fdCv5FcSW0oTW1763fj7BGFwuERBWHXLkoZqULsQf0Y
         GrsDmbAdZjn3T+VKXWsaepdqdQdFMpg+TM9nIJrLsTLjQpA+7AsLZHiycB0gJGOYXBSD
         ItYq6mukTUtLXNw9gzDsApOwMmekCtlefXM2StLLPQ6rS80qglqD3q9HgJozicBVyh+w
         D5p77tk0+0DanHtqhH5gLQ5xYN97SaIZOfKqM68ajcXf9TWxkcGhKqZMQTuWpM4fSdIB
         ee0g==
X-Gm-Message-State: AElRT7Hg0+OlH/OO55I1bgnBgj3p/bb2YOLriyzVrh8dJOm2By4LyPXK
        /qLTQlBo/8/Dg2M8rso0cHTgXQ==
X-Google-Smtp-Source: AIpwx492dzWfZuaAsx4Xd+WXTGUn5nmEkmB2mzdH77E9UT+cp75YCSfxQJMpWnDbeAg+UiNcDQlioA==
X-Received: by 2002:a17:902:2862:: with SMTP id e89-v6mr6099125plb.348.1522288733866;
        Wed, 28 Mar 2018 18:58:53 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec10:419d:d341:c920])
        by smtp.gmail.com with ESMTPSA id s78sm10044972pfa.161.2018.03.28.18.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 18:58:53 -0700 (PDT)
Date:   Wed, 28 Mar 2018 18:58:48 -0700
From:   Taylor Blau <ttaylorr@github.com>
To:     Mark Wartman <markwartman1@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Question
Message-ID: <20180329015848.GA82123@syl.local>
References: <CA263ADB-E23D-4C75-ACDC-C9C0B75A4A85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA263ADB-E23D-4C75-ACDC-C9C0B75A4A85@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 08:49:19PM -0500, Mark Wartman wrote:
> I am following this tutorial and I expected to only see user.name &
> user.email, so what are the filters.lfs’s and the credential.helper?
> Should I ignore them, or try to get rid of them?  Please advise.

The `filter.lfs` configuration is set by Git LFS [1] in order to
correctly filter large files into your working copy.

You can safely ignore these, or remove them if you are not using Git
LFS.

> What is the best way to upgrade to a newer stable version of git?

On macOS, you can use Homebrew [2] to install any version of Git.
Install the latest via:

  brew update && brew install git

Thanks,
Taylor

[1]: https://git-lfs.github.com
[2]: https://brew.sh
