Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0170020248
	for <e@80x24.org>; Tue, 12 Mar 2019 11:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCLLYN (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 07:24:13 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:38660 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfCLLYN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 07:24:13 -0400
Received: by mail-pf1-f177.google.com with SMTP id n125so1598311pfn.5
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZAjbmyfT8Rh5n7gIdscV3sU8paS5DctD9IJpNc1x4ig=;
        b=qmSxgMWtpGYslB6t3GkqziFIGEOkq94zGTMH+lO/Qlfr51V87XnPL2TFt/D+7FfmKG
         rxw7vcv5iND5uOJzqMDK6YYgheOYZ1Qw12/3NihnY4Jre/DnN7B9P7qIu1aNrLdpvqo6
         hFY4o9qaZw9HqGASAg5s1c870O0P4XryIlm9kRaoDP0Lan5nc165HePWgFSRvhgjcsaf
         nOMk3CUoodwtI/v96un02zz67LsOHOy5+1GWsybzxMCsHa3lKQphVe2DKWOoo2DmQxAi
         PwpOJ9YlFYK8ZAar2ebw46BPlQ7Agg51wgML+gcCP4dw1BHC8bVbqzo8a1OuvFq3QC2d
         CpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZAjbmyfT8Rh5n7gIdscV3sU8paS5DctD9IJpNc1x4ig=;
        b=lhFYajovGx9f9dzvrZLNhZqyl/Kx3R3s39+qalSH+56PF5Q6b6ZtLdGVO4OSbMe3tw
         SksZf0FspGt344Fqo/4m5D5K8UCyGepuG7ZJWca+JRJ1MQtfCr+BnzAw7Wi1mOj28GAX
         YfX4tgTyqWNv/C+2NBepttfTZBs1RaVP5Zfv3XFFt7/BT0y+UTmBzUaifKLbhHq18nkO
         wVUpCJbgxuVfg0p6RlvvIJSsUqBx1FZEX2uMLkx2Th07oOLEjSSw2+InZcr7NKRZTttf
         2+Lt2OPL7nS+frosgFuVGXTYZ2tzPoiETHE98CIO6QlB/84E1L54HvO826+vJ969TX8F
         cFig==
X-Gm-Message-State: APjAAAUaCoEy/L725x4jPg8ULgIBAfYzwOH89rRLvcy7D38KidaMuXgO
        FiAE/eX2QAK+aqLav85mHYjPdBBb
X-Google-Smtp-Source: APXvYqwDvaemPZAhhfjby0pgiIiFoqy16MPc/TuvyypTEd4BqdgWsRrqqTk+nultLEoMSw3LBQ7xTA==
X-Received: by 2002:a63:d502:: with SMTP id c2mr13027512pgg.290.1552389852247;
        Tue, 12 Mar 2019 04:24:12 -0700 (PDT)
Received: from hacker-queen ([157.49.152.138])
        by smtp.gmail.com with ESMTPSA id k3sm20921617pfc.59.2019.03.12.04.24.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 04:24:11 -0700 (PDT)
From:   Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>
X-Google-Original-From: Sushma Unnibhavi <sushmaunnibhavi@gmail.com>
Date:   Tue, 12 Mar 2019 16:54:04 +0530
To:     git@vger.kernel.org
Subject: [GSOC]regarding project selection
Message-ID: <20190312112404.GA5031@hacker-queen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am interested to do a project on improving git log --oneline.I can program in C language,I have learnt how to send patches and I am also comfortable with using git.I wanted to know what are the prerequisites for doing the project.Can I get some help regarding this matter.
