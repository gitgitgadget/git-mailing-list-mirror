Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8EE1F428
	for <e@80x24.org>; Sat, 30 Dec 2017 14:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750939AbdL3OkX (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Dec 2017 09:40:23 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:39077 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdL3OkW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Dec 2017 09:40:22 -0500
Received: by mail-wr0-f180.google.com with SMTP id o101so14992864wrb.6
        for <git@vger.kernel.org>; Sat, 30 Dec 2017 06:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PZDcI73kX5SZe/TezLQfpveArjKLGGspIPGGM66QbNQ=;
        b=mo4LZp4U+cl4NtfWXl+KwI854KEUQXqV9BD9Ct4ULY0Ug8b8YPk9QF90XBij6Mq1WZ
         6Cm8n7mwFcpxMBhOBFczM08/6nZgbGZ2xNjYnelPbyQHLYifj60L1WJEwKPfrbYjGhyu
         Fx460SZ3noNpUqyLEMXRC68NqUqXZZ4Dplo+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZDcI73kX5SZe/TezLQfpveArjKLGGspIPGGM66QbNQ=;
        b=Gf890Bv7q0zAIQE8J39UA7P78obS7K85Z62vtIyPgeLPeAOZxW1S/zuYGXtT98skCF
         QE/RPQHwf6ddj/f1hDXUFArAjtTv0fuN4ej9d6987bW4dYjxX/uGJt6eHZ0TUioOXZbN
         pWuIi6cTrTmZDTBm2xKo65JTWQI1+XSMyKrUoabk6kEpoYUBTcbhozbnilZHsbBgjt74
         hTx5bzPsPUy+WGYmw1Zx1Cr4Fl2xTTTdBQ61PkzjDqhKry9s1sdM/LOv9f6qTK3NrOlV
         hte2DWh1Nz3iFHhiE968E6qdSGF8xZDZ/zox+jfejflLVy+AqfHwYQG/ZpuTMOHsQuT9
         zqYQ==
X-Gm-Message-State: AKGB3mLXfNMknyeTlPDTuE8uuUTa9Hj9nS8xvBGQkaL+uor7oq6Onidf
        c9OXoTc7zVC5KVoSYvpoDduj8g==
X-Google-Smtp-Source: ACJfBot622y+T4g061KGfmrPK+G8v1Pu6GyBakRFbbTeF5BtoebaDzxhRhd1VYIFM63qaELtSsqThA==
X-Received: by 10.223.148.97 with SMTP id 88mr38142419wrq.265.1514644821400;
        Sat, 30 Dec 2017 06:40:21 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id w75sm30647319wrb.86.2017.12.30.06.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Dec 2017 06:40:20 -0800 (PST)
Date:   Sat, 30 Dec 2017 14:40:19 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Test failure for v2.16.0-rc0 on cygwin
Message-ID: <20171230144019.GB29210@dinwoodie.org>
References: <519ac918-6b5f-bca3-05a0-0114683b9724@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519ac918-6b5f-bca3-05a0-0114683b9724@ramsayjones.plus.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday 30 December 2017 at 02:21 pm +0000, Ramsay Jones wrote:
> Hi Junio, Adam,
> 
> Just a quick note about the failure of the test-suite on cygwin.
> In particular, test t5580-clone-push-unc.sh #3, like so:
> 
> <snip>
>
> Adam, are you running the tests on Windows 10?

I'm only routinely testing on Windows 10 x86_64, but between holidays
various, I've not had the tests running for the past couple of weeks.
I'm kicking off a build now in the name of verifying I see the same
problem.

Adam
