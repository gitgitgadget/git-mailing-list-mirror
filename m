Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 746031F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 01:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfHMBiF (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 21:38:05 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:44138 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfHMBiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 21:38:05 -0400
Received: by mail-pg1-f177.google.com with SMTP id i18so50386873pgl.11
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 18:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8jUw/LnlWJ1geAp2FwEDP4Bvb23wYCJA4jobk1jWtU=;
        b=tknAJ8Pv9+5IHoWpDEB61wO5RQAdHeDlSoqQZ4Sj31Z44eX6wS8C3EIy2kjJVDaP1K
         YYZbZgKJYGvps5txqzUCiB5KskKSUhtY2V1DihlFxC9PRHpNDpg+wTIZS3ODDpJW2eP6
         NyzawsZ6ehYZ3AYsleLUrKtePnzGGLGvYFLfeT7A9mZdMpLKjOHrVPAZAEqRvWl46iuh
         auY1ntmJDeVffL+Z/d/Pgv1nTK3mUHTteMzBNakL5xaLFsJ9GlhIfDl98TGJvP3DugLE
         foIYKCaqzZ3lhZYWoIB2lY49Ym1hPxgN2rMzAw2somiSj/LUR10uEfhynvzxw0Gm4RhT
         SCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8jUw/LnlWJ1geAp2FwEDP4Bvb23wYCJA4jobk1jWtU=;
        b=uP1xR2eWIk7gp4Mn2HKafg0ESh5dfWjz2jVVWt9/1JRCRnGQV56UFHx5mS1Cc3fXIJ
         Nvs9Uo4Xf96QYBJZqR/yebMqiitFnUQMoZvVQrIbuD6KYsjFmdnMFw++CX8ZvQ+62x2/
         j0TtXoFygIjK+kJSpDOuxWno9zC3aUfqdttbXJ4j+LktkjTYLtx/N5ywth+/MEEvD5Wz
         uYsNaKnNysM3Ut4kiwPJKakoZoNacq8K2mnZxRCNSXYIPGPLxb+hiW08t/2spaGKbrsF
         7ALYOod8ynn54rQ7PWqyouPJBFj0++77EHTNgmmUrXQlzSi0d6sVW3YGNgDe0iHt2H6D
         LUVw==
X-Gm-Message-State: APjAAAXcI9SD0x5cwBXaTXGwLub6jEQiMfvwscKA77ClgypO/zA8Tu70
        oZgfpaUXU95nYPYfsK/zErc=
X-Google-Smtp-Source: APXvYqyPSlvPUxFeQX9WR3jR4QFd3tDhz7N9pylcitxliD37hMBz60sGpgqJaydTaOO9VRpwLQZ5eg==
X-Received: by 2002:a17:90a:db06:: with SMTP id g6mr1994552pjv.60.1565660283989;
        Mon, 12 Aug 2019 18:38:03 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.228])
        by smtp.gmail.com with ESMTPSA id h70sm102498876pgc.36.2019.08.12.18.38.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 18:38:03 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        olyatelezhnaya@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC] Blogging with Rohit
Date:   Tue, 13 Aug 2019 07:04:56 +0530
Message-Id: <20190813013456.32338-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
References: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All!

Here[1] is an update about the last week. Sorry for a late update.
I couldn't find time to post since we are in the middle of an
internship season.

Thanks for reading
Rohit

[1]: https://rashiwal.me/2019/another-iteration/

