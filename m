Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B4A1F4C7
	for <e@80x24.org>; Mon, 21 Oct 2019 17:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfJUROU (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 13:14:20 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:39690 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUROT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 13:14:19 -0400
Received: by mail-il1-f172.google.com with SMTP id i12so2216776ils.6
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FdR3mAFy735QPVo9Nw0JwWiilqsxcSF37tHE83WL2nE=;
        b=YFIghqEfyt/K+dOpnK/9E0Rn33Fs0Ee1gWTLf56k9JLmBHoYJMRPgrON/ghpX18zXs
         8aQHIJZk/MPiJXqAWglN8Vna8L2yY/IMKvpxqgTBdhkj0UlOVMaHXRusT1k43xFnqgv9
         t5CcBx4ehLjcOsvj9DFOl86JpQtRwhQpxJcdhR97L0mGMtr0iDOzD3Yob2hoJEXAMN9s
         RsIKZfuVhdlKtcAoa1BZMUKII6VtgteghQY4ywECvCeX3lbA1dy/qUdKpV1WIQ1N+t3x
         HxALztfVZQLAjBtwTn7l+ZfG5DwIAbZP7/SqPFKChgdlS702Yqgr9aEZrQaNjrlO4PL8
         LKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FdR3mAFy735QPVo9Nw0JwWiilqsxcSF37tHE83WL2nE=;
        b=NPREdwwxmtFXgBQi+IJ28O09uv5ZKcsIPfMz4ecSa/1zhf/Cnv0j8fsgmmZmmNVQ1Y
         kgRTLFwUlPeWep8BpQtvQ+M7h90naXOPiEqNDN+xooqdueTcL6eio6EGhOasOKfTVY0X
         iNqqMRUCHYX4LfAMTRXPuJ5YxoGLq4uaHuNiiCS5ZzXJAIRqHEM+ycVpH8Vqum7YaOBR
         82HK9Dy+qvYLaM4lPRsgTMbYWEuFQ12HHk74KSjCNAuWhr9h+wwNwvPthKceFYLS/MMS
         BS3k/A4lV7bGWWbWclUyOVX8egtSyVv9HI/yKt+GwhgtgMCTCP787qVhkLD4x1FMk1vl
         oxaQ==
X-Gm-Message-State: APjAAAUx0STTQS5Ira1AqxlTmJw9hqcCRqJRKlW2M3+1aepNfd104Fjo
        xs1km4TLn9rjWNQXBbe5BFucXHij0uo0WpnmqhYGi7B0lIg=
X-Google-Smtp-Source: APXvYqwzMfMz4oH1lc0rgFFV2GpTV77w8J+SJxBAE5Fv0HwLGxEYkCTK8zxwS/vcpkrE9ChRD++ykpUjaj5VapldoFQ=
X-Received: by 2002:a92:b00f:: with SMTP id x15mr3788054ilh.280.1571678058368;
 Mon, 21 Oct 2019 10:14:18 -0700 (PDT)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 21 Oct 2019 14:14:07 -0300
Message-ID: <CAHd-oW5WHwZCoXtJ5an-8hnHfMsFxKyr6YfHFFg0Pm8Yt5DtrQ@mail.gmail.com>
Subject: [GSoC] Follow-up post
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

I wrote a small follow-up post to talk about the conclusion of my GSoC
project. I believe the main remaining tasks are now finally complete
:) If you would be interested in taking a look, the post is at
https://matheustavares.gitlab.io/posts/gsoc-follow-ups

Thanks,
Matheus
