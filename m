Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3F61F597
	for <e@80x24.org>; Tue, 24 Jul 2018 18:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbeGXUDy (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 16:03:54 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:41020 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388402AbeGXUDy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 16:03:54 -0400
Received: by mail-wr1-f43.google.com with SMTP id j5-v6so5122487wrr.8
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IascuhJWDdReJHxqVh2FFWcjn37/O3Qan9INOyM/pt4=;
        b=auB+1yHSymKxsDMbvofKntissBLBDqtKrrWkDrHGJQpnTjnlwSaSSd9D7xayPkAXAx
         zOy0rvMgWyTnKH5uu9pPgVq/+3m6r9yBpQ8Htorv013CHHB41Ryu5uWFno9F4TP7//ic
         m3Qf70lE0jIEfiVzTV8hJ/HjeJJ3cuMv1CjF8ZMu9BwrT26+8ME33Gnf8jRCR304tyVj
         aJzkWz9vxECO11iM1pFZMFNNl8JUEuUbHml3689bBYjdkTDlULEYODU0syX9tmoixU76
         zfdknXATdDZ9CFY6usFNUkPgwHK4X+0suTEgRYWguhFUMLU/Uolpfm98g38j6mDo8sKe
         /YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=IascuhJWDdReJHxqVh2FFWcjn37/O3Qan9INOyM/pt4=;
        b=O/QZCOUJ0DfgxfzSxhrjz+jRSCABPmKA5X08HD5ooQmjN4iheGNLSGTn3g6yOCRfuC
         rxwvFAIRVH3m/nmzizfem1hqpzxcMbpnXTiPcR1bh5bD+R94wgAX6ZWqJx7VCwgj+9Cn
         qUxU3XPDUlUMjAEbW1eCmMRPx2q5OssZDUPncQZRPPpathBOCqd4NJ0oFJXeDVjwItOZ
         Rxp3Mxlz5Wth4Y1StFDnSa6BvTii2i4ryVPInDlQ4tneJEOEg9ruWtvo9aIzU3i/BiJk
         I1WjFZuYhrJ4whSoR3W5LP7PTtr0vAbrEclInVCXKYuFQ8ckqXeWv8AcfzJbwjLnoN90
         L9cA==
X-Gm-Message-State: AOUpUlFRdMJFZpiKEdEk/lxSJHJEdO5vQsAHbriAWQ5FRLMG3NOebFpn
        2UxwyFSXaP+zA85Umekvk+0=
X-Google-Smtp-Source: AAOMgpfE2OXpdWQLEm1q93zWs7n+5+mDjDwSOWnylWzJKTmgyL6j/+9mFdSKowwihcNPgcENIov0jQ==
X-Received: by 2002:a5d:4f0d:: with SMTP id c13-v6mr7538598wru.114.1532458563416;
        Tue, 24 Jul 2018 11:56:03 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-75-221.w92-156.abo.wanadoo.fr. [92.156.127.221])
        by smtp.gmail.com with ESMTPSA id q1-v6sm19163094wrw.42.2018.07.24.11.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 11:56:02 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] GSoC with git, week 12
Openpgp: preference=signencrypt
Message-ID: <7c05cfb5-d29d-79ab-f400-b2614855d7ac@gmail.com>
Date:   Tue, 24 Jul 2018 20:55:43 +0200
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

I published a new blog post here:

    https://blog.pa1ch.fr/posts/2018/07/24/en/gsoc2018-week12.html

Cheers,
Alban

