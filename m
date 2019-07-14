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
	by dcvr.yhbt.net (Postfix) with ESMTP id 13DC41F461
	for <e@80x24.org>; Sun, 14 Jul 2019 12:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfGNMFK (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jul 2019 08:05:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43288 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfGNMFK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jul 2019 08:05:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so6180120pfg.10
        for <git@vger.kernel.org>; Sun, 14 Jul 2019 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1OsjsziqGt3lJA5L6A3yZ0SDISP+2rqEW7bas4/tyhY=;
        b=ABrMQ5owVf72qJB9jAf6PJXZ0Xh5M2zrUmidjNHwieFsmnw6qpmjr/DdE4Dw7BCKv5
         MMBYlvfA0VDRykR9E2VKI/ajoJ6RHfcocYTyS31undYNCthhsPaDh8zAtmnPm5VXL8l3
         eritIdBh7SiiBQ02TWsYBOSPFUOZUodYkMdNjJqLpoOENVSboAyf067jJu+GVtrpTNkx
         GqpD9gj6Jt4gpq9rPCTmycydCZDq/GqyFtr1TPlIe6YNUPGNdbTrjPUBrqE/eZofkeZU
         Cr5GhalmiYLI21V32F5ysw5t/ZWfXB1i3HmQqsptkT46Hynjf3EyR5qoa3ghUCJ1zhHh
         jD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1OsjsziqGt3lJA5L6A3yZ0SDISP+2rqEW7bas4/tyhY=;
        b=VRgdDi+sbg/W5jlEqu2pbPJMUo+TUNfRP+RZdJaY/NBbSD2z0z1GfRyRfP5lIcOQv3
         0H0rnNW60wY3ya8HyREOMNfTHAzzAXskehHyco2Hnmt/PQnmfgNiO2HzDAvd0lpvHW1/
         AdkKirD094wo7xcYeaou+VvPyqG27uzg1yhdFt5SNvrgp66bC5Nkawa1pTxQRa8l22Oc
         wNBhT666QQ6UxpC5JreiLq0INmBtnnraIZxaqkALF6+HLH1aP87WjVMviNermbwx+tgf
         LCw2wEqzlHGQmpTDU30k2ZW0mqXeq6mghxe2MJWSM+EkArpESKQmhSV7QeUTTc+ZkdJV
         +QjA==
X-Gm-Message-State: APjAAAUoXT7J7TpKVIkXEMkQZmfne5A7Oab4uPP8PgPGHf8nlrSR/QFF
        auzocgLta/ke8hNhb8P/Ums=
X-Google-Smtp-Source: APXvYqzbeBuriQQfoU3+78YwEHT+5H9dPHwitf2lXtX3HhBCLIDnL70bFwZ/6wHV76tOr/x39+cVZg==
X-Received: by 2002:a17:90a:9903:: with SMTP id b3mr23156091pjp.80.1563105909575;
        Sun, 14 Jul 2019 05:05:09 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.215])
        by smtp.gmail.com with ESMTPSA id i9sm12153353pjj.2.2019.07.14.05.05.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 05:05:08 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        olyatelezhnaya@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC] Blogging with Rohit
Date:   Sun, 14 Jul 2019 17:32:25 +0530
Message-Id: <20190714120225.15259-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
References: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all!

Here is an update about my last week. I submitted two patches.
And currently, I'm working on porting --ignore-date flag to
the interactive rebase.

Best
Rohit

[1]: https://rashiwal.me/2019/tale-of-two-patches/

