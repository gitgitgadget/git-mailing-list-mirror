Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 853031F403
	for <e@80x24.org>; Mon, 18 Jun 2018 17:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935397AbeFRRel (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 13:34:41 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:39071 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935319AbeFRRek (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 13:34:40 -0400
Received: by mail-wr0-f175.google.com with SMTP id w7-v6so17697164wrn.6
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=R7FuSe40Q3nAF8sduk6/tGqTQN8muK21nn2MKsYtJ7I=;
        b=KC5ZtdeytkJJePM4JM/8sj2HcA7FpCJHtBx2QS7mQoJi+YrkMdT/Q67ipzv0DUqJib
         3+3+7//ib/oze4xy8tFq1X53PFSZ/1HNL+Zos/nj+aG6aBDcpxzkO7rys/IsCiygTEAM
         jQWPo0eP/uLaxICmIVblys9lMPpTYZxKv17ob4XfYMaScS0F30pbyRdDFve0P6uQwvON
         fD+HkUQRPotFi2dBdQ91LcpTcGig3w3NgdVduPQ+Dl+bsgc6rkd/7mxVRXKpQ4GYqFl5
         G3EPLn7XRh6g0M44qAhf4hLFypZua8Y6s0LvHnvhUxNm1LWo0MemWhxMmJ5kNyhyxuZP
         8ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=R7FuSe40Q3nAF8sduk6/tGqTQN8muK21nn2MKsYtJ7I=;
        b=tSHJp5Ww57vAZcbKMDUUcD78S4Y6BrScs5+jMZs5qjCA2VJZ/u8S5t6g3tCZtAawuC
         GW4KAja3txvYgXs5q44ii/qh2rYTv2fp+yCmHvxsdcmQm/KOzcc18ikFbfeCD0LvGMKY
         WzF0NFSxtlZ6ZZBTenwFgqTMrrvmBWBvAk2Y4XnA63rVS3KtxPosSSb/GlNEPH8IBDij
         kdfDGqIThL4urHxIDJinaYEsYiZ7oYeolqeqMDUUD4q50IkyxtjJCLtd2m0Fo+QrEZQV
         cwodsLrZA6x6S7vTORg+euCM22H6XXaSXlEswPUEWf9vKISOOMexqM9II6J6FZuV/FWf
         MmEg==
X-Gm-Message-State: APt69E1M9yAHC+h3GQ7QS4yHnuPr4xFLFe0fMSbDltNS3jWptDh0NUwg
        MlmdPWwqV5hdrR2y2KouWs8=
X-Google-Smtp-Source: ADUXVKIYlGI7QEaVknCOlhouYkd9Xd7QtxBkcqOSm9KtYkYOz2TW1ohclOUsNR0nfaEaMOWk7mX6Bw==
X-Received: by 2002:adf:c3c2:: with SMTP id d2-v6mr11223570wrg.68.1529343279534;
        Mon, 18 Jun 2018 10:34:39 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.gmail.com with ESMTPSA id d90-v6sm10200071wmi.26.2018.06.18.10.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 10:34:38 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] GSoC with git, week 7
Openpgp: preference=signencrypt
Message-ID: <f7cd9f11-c239-15f0-87b8-b1503b1d54fc@gmail.com>
Date:   Mon, 18 Jun 2018 19:34:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I published a new blog post here:

  https://blog.pa1ch.fr/posts/2018/06/18/en/gsoc2018-week-7.html

It’s shorter than the last one, but feel free to tell me what you think
about it!  :)

Cheers,
Alban

