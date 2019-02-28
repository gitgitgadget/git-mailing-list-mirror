Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6930320248
	for <e@80x24.org>; Thu, 28 Feb 2019 19:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfB1TDP (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 14:03:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44242 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfB1TDP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 14:03:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id j3so10138667pgm.11
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 11:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dL8aGKJZYJBngTcIvQxAei9D+AjG7qyE/ag4tVdMbvg=;
        b=fiqlKyzhwDEgLjjNj8+R6SYacb5MJvMO9ZdPuKkf5m8Srlew1QJsCXXRE7UsuNtLj7
         VbbEwokST4ToxpEO4IfM0TdKE8yNkwnktRalEj/EgFKtZU0ANu3C334HJkEpUmLL8c1j
         vzy04hGt+hF0mPUtoO9hGJFzy99qyp8sVrWuSntFvtsglO7upoM7RvgSjwKT6N1B/R91
         TaLcLar9qMEtcDBq4a3COfWK6ZKvBZu02DoiermvHuhFc4zW2+VWLqTzDpjciLthqhRL
         p+VlB8jIb+SF+6UA+Kn8K2RA+q8YvtdU9P9MkptKDNCVTR4M3PP+ntcZoJLilM4/RqVK
         Phgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dL8aGKJZYJBngTcIvQxAei9D+AjG7qyE/ag4tVdMbvg=;
        b=oA2egj3HL7tDgQs8M/10AkZrD7zlJuamwNGccxr6TH15QFFEFnXz3LTXbtwWQnfnx0
         sm8/LINOE9NjEV0QRqZrH1eoiiyCIgABxrAc10IpMa6K/OLdCURAHBq4am0vZySRsJH1
         aotYyRv4oMHBA4gKd7kKshuASHvoHWOUHpwArdKkkLSHz79xN7/7MY5ZNkJZiVm7OY/J
         gUzpisbI+vIXSX/ocp3zlde59N60ksF79Hb3J+U8hZCTxcPAi+Gl7x3KGnSeeg+rpMVw
         GiVmEeBskmS9bDrYHOwqch9kkV0xgni/nyCCYMsth2ED9x6LRJkiIxOBIYbZDWBA86x3
         0v0w==
X-Gm-Message-State: APjAAAVKgdmkEyDrftTe8Aq5IxZcojofGBIg1FZ2PXJXydelqgYVaRRl
        rBRhafM1X1A1/zP0NGPFAPTcJaKCh0E=
X-Google-Smtp-Source: APXvYqxQN2g8GBMydY6tLbv48C4VColo2hiSefjmCRcMLNwSgx2+0tlAlDdH367GE2654UWY/aDCjg==
X-Received: by 2002:a63:8542:: with SMTP id u63mr625614pgd.323.1551380593679;
        Thu, 28 Feb 2019 11:03:13 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id 1sm27427894pfi.99.2019.02.28.11.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 11:03:12 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, rohit.ashiwal265@gmail.com,
        martin.agren@gmail.com, pclouds@gmail.com, peff@peff.com,
        szeder.dev@gmail.com, git@matthieu-moy.fr,
        Johannes.Schindelin@gmx.de
Subject: [GSoC] acknowledging mistakes
Date:   Fri,  1 Mar 2019 00:32:42 +0530
Message-Id: <20190228190242.20680-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <f881f01e4f05c1c9ad7e35fea5fd7db2947427a1.1551349607.git.gitgitgadget@gmail.com>
References: <f881f01e4f05c1c9ad7e35fea5fd7db2947427a1.1551349607.git.gitgitgadget@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey people

I had a discussion with Rafael over the #git irc channel and Thanks to
him I was able to find these minute mistakes:

1. Commit message was less than 50 chars which should be around 72 chars
   according to coding guide lines. Should I change this to match 72?

2. My changes had some uneven use of tabs and spaces, which I made
   considering that pre-existing code had them too. Is there a
   possibility to change the whole code according to CodingGuidelines?
   If yes should I only change my code according to guidelines or the
   whole file?

3. There is no helper function for `test -s` but Rafael suggested we can
   make use of other helper functions to provide similar functionality,
   if we can.

Open to suggestions and debate. These will be fixed in next revision
accordingly.

Thanks
Rohit

