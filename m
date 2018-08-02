Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F81E1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 14:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbeHBQDh (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:03:37 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:38721 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732402AbeHBQDg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:03:36 -0400
Received: by mail-wr1-f49.google.com with SMTP id v14-v6so2300797wro.5
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vDAAVYEW4quvfniy6l6XrXygTR1LB3gYVf6Nkiazuz8=;
        b=UymAFJgL3bPirhYmEUJ5tHgli8aqnPFzdEiPow7/Ynono/AUwec91hFHFbc8slCGNx
         Oyna2IWHYFW/+dRveZoM+vKsnxmaN5n0i/Q8CYKQoqCaVcg/yTP9VFmxWCbrFydYyxUn
         Gstc2QideEyTqH1o7BYGRdbPg48oYd86fGzxuXCbkOM995KrWaYVaVAk3ULAN23q2U2X
         Efq7c6ErFAmTjlXlff+wAOCkPyfG4sJiCBLFyO2ekRlcj7dgYqFkfbsA/UMFlfB751jt
         TRWTFgWUurZ9VDtAdq3LxyXFJQwpx6fIoQhc67c9zpTMDW2qDTiOOruG7mfNFq1e75yP
         sFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=vDAAVYEW4quvfniy6l6XrXygTR1LB3gYVf6Nkiazuz8=;
        b=DF/ne5+1U+cuVa9kSUPGX8CVwHDxv88T70cc05faApOXoF0Zr0oQasRvf12iw13r0K
         tBViBbjodglAy3dfF1GUX5g+FowY/Bs7JmkGhkWS3/mNsI/Xrhy1RoIg6h9U9QPPWwMj
         N6L2i4mjrIjzjaSShXLtbT8D+iz9hqTt0cbJU3Y3ALwO+o5TqwWGQa7dNxYA1AFSv81B
         KZ0uepgdlWqBzifqhepUsdPW5uiFjUi/NbwQybWstNtnIFVCj2Qt3ibNNe/kPY5xVx7A
         1zRYL7TdYGhuhKhGcoizeL5YyUbiqNj5CHECdILDrkvRisb24gkKSQ+V3bM39RJTpMlm
         t4rA==
X-Gm-Message-State: AOUpUlFN3lGnboXuQJXWoI4IxTSs6HJS2CAwlEFMzv3k3jfz6f2bZmeo
        a6rxjRHq2PnukBZ1O3UHvME=
X-Google-Smtp-Source: AAOMgpdq6r8PFDv5pbW4yXQTUI7zmslyGblPC6KoLr2MaDrHfi4UkhnR+xzhghG73MFt3+SxB54n+w==
X-Received: by 2002:adf:f850:: with SMTP id d16-v6mr2038393wrq.172.1533219132321;
        Thu, 02 Aug 2018 07:12:12 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.gmail.com with ESMTPSA id e133-v6sm3290617wma.33.2018.08.02.07.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 07:12:11 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] GSoC with git, week 13
Openpgp: preference=signencrypt
Message-ID: <d226cf24-a268-15ea-df71-dce39a5ed81b@gmail.com>
Date:   Thu, 2 Aug 2018 16:11:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am a bit late this week, but here is my blog post:

    https://blog.pa1ch.fr/posts/2018/08/02/en/gsoc2018-week13.html

Cheers,
Alban

