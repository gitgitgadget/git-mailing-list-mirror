Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3169D2023D
	for <e@80x24.org>; Tue, 23 May 2017 05:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935699AbdEWFqg (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 01:46:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34987 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934600AbdEWFqg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 01:46:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so25056590pfd.2
        for <git@vger.kernel.org>; Mon, 22 May 2017 22:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B7d8ySsjr4QTi1Xl0oTp13tAc0DvFi67hqDNlHpCELI=;
        b=A6HwA0VjH7zX3jccRn2DYD3WJyhs9avy9BQiYdGFH85kyCaRsPB9w2l6buKeh7nVUO
         +PaDfuVvygUdDs27Q2wr/16ns7GBKUiQLlMCMJfWArC3VrDfzyNxWyL6uTJOt/j6XpnJ
         0lK+/OTXGPG4yf06ryDtvdm1oidSBBc/A346BtRWJ/NGmHo+TzTfIfzyNXu2GR8eBBn7
         tCYrSmkePPCw+AXT5GN21J+rTigs3egIwWdpPBYYpM9QzwUn1YXt5mctsR/JQceSBxpF
         eH9o9z95mwAv3B8VyZ81gAcGPMCIBwK9sWE9oPMqVq2Aja+yPY2v6EZSKI8obZVexX2w
         4ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B7d8ySsjr4QTi1Xl0oTp13tAc0DvFi67hqDNlHpCELI=;
        b=F0J4x3a8Bt7Z1SIuR0525xS+HssWuMJPZSaejfRdLbxNRrkWxnho7LVuc3R0hlTGfg
         PYOavzoEbKFMeass/cf8jop0pGHTxsYN2UJvvJX4Q/Uu4aSQVZIgQKdc5bPwACngC7iQ
         l1K4gDZt8a+MsWU7rsTenTNVMxEkeA2lBJwV9z5fYu0ANX8Bmy+VGdTQgjrpGll3fDeP
         IaTjPpd/MnX3Q9Cimfk46GRv+axBunrqQyXGie2Hv1ZgcNZCV6YCxYCHU+hBGSPlsd91
         dFZA2ItMFYC9tcA8P7v6dV3gB6h5rwPuBtFCI/K8U0OKwYv7Nj9G44AgIvmAjJcdmLI9
         2wlw==
X-Gm-Message-State: AODbwcBFALUMYlO34ZKDRgw5FejBi+w46EEUGMlZUkIP+5TdOnSqduDV
        VFUw6kIBffiDww==
X-Received: by 10.84.130.99 with SMTP id 90mr8430488plc.165.1495518395368;
        Mon, 22 May 2017 22:46:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id l186sm32126446pgd.42.2017.05.22.22.46.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 22:46:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix formatting typo in pretty-formats.txt
References: <20170522205958.10962-1-asheiduk@gmail.com>
Date:   Tue, 23 May 2017 14:46:33 +0900
In-Reply-To: <20170522205958.10962-1-asheiduk@gmail.com> (Andreas Heiduk's
        message of "Mon, 22 May 2017 22:59:58 +0200")
Message-ID: <xmqqr2zgktvq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
