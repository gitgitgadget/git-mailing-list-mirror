Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D921F731
	for <e@80x24.org>; Sat,  3 Aug 2019 21:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfHCVgZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 17:36:25 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:39063 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbfHCVgY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 17:36:24 -0400
Received: by mail-pf1-f169.google.com with SMTP id f17so33731141pfn.6
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 14:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZZ/XDCXRMhznSyDgJEfBEAlXSlVHPWv+fWRk7lGoEo=;
        b=BJZIXotOkoURasmrdDHRKeW7lqNfcV7jT3w8aXW7XLEvHEK+0SnWDpWjpSEw2AN227
         zXfgs5OZ/E+d44hTealL2bNTaDi0xnKrZcb/m5oItiYA/4a360/IlWTnRn86Pi1rPLuL
         sQkII2lpaEYdN6fTWuJoUqKEI8MW5cGivj6SuIpaFqsSzouFEMDkGDlrHuNCkcNevSBX
         Mx32z65YN0ofXvkAAuPSmboVvJG3CUrpRzYbZVNhHnolU3FrHZSl+amUnTOkNzVI3VPe
         ESV9QeABQmN00Bc+TV5jc1yOpjMpujheXVFssJ55SIqOETmTxdoz5Evz9iKueUAS5XOT
         khdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZZ/XDCXRMhznSyDgJEfBEAlXSlVHPWv+fWRk7lGoEo=;
        b=I7b0ZoXF3XmP6er+t35WE57fav3Ve8LF+f5nt6hsc6kShLvAgLmUORg7P8/utvrA7s
         TgoFd3JpX1XwJuVIR/l16csuiLQqEVuAi0Iht2Yc5WPmttpai/R2dIkYdFdOv6CSpkyk
         CJlVf3w0CgymMhSrZ8jAgL4dx8Wd1LbAlx8iQbrHlVV16jEfRkcE5vHzDh7pjWXb4L/R
         IlCV7oSPjkS5B1UDVzxYaWvt4BD5YiwD4Eb40/hbMemgpduBb9jyrNdbc/XAivbebAYg
         f7UfrcmOas+4lfNyI/ENQPLjgbuT2yor6HiONGrmwljL90X9BO8criU9XyGM0DujrYoR
         ee1Q==
X-Gm-Message-State: APjAAAUmIdwrQ1i6Brkl1rWP3TA2gvwSb45mjY09xQyvOh8hOsiKJKkJ
        Hp3rsDp6PdFrZDF2xl9KpLM=
X-Google-Smtp-Source: APXvYqzDatMLWqs24Cp5rVSKrh4bfAgeIUAejy87A2jVaDahesNtVbHkXhtUGC9CRdFw7i2Bry4YPw==
X-Received: by 2002:a17:90b:95:: with SMTP id bb21mr11115956pjb.8.1564868183242;
        Sat, 03 Aug 2019 14:36:23 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.226])
        by smtp.gmail.com with ESMTPSA id p65sm78643210pfp.58.2019.08.03.14.36.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 14:36:22 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        olyatelezhnaya@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC] Blogging with Rohit
Date:   Sun,  4 Aug 2019 03:03:21 +0530
Message-Id: <20190803213321.26285-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
References: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone!

Here[1] is an update about my last week and some insight on the
future work.

Thanks
Rohit

[1]: https://rashiwal.me/2019/the-discussion/

