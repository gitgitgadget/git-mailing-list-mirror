Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 556C41F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfJGUIo (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54117 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfJGUIm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so766217wmd.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xCZIUJKlOnbwNhuxRGiI7T/gfJU3N5zEWpmYYb9368g=;
        b=TQmEfOAFk//UGFzFHX4cEXpn+Vu4SyF2PX1JILYCxEUQRqarBtvUqXURVu6zn/PdpV
         acaEL6y9okFoHOr5zAkPsH9qwBkSCtoJFGr0RzvZ9xy/xPh5VIFvgHvVxkJzmztFE7WT
         99IlnjB0RPkw+sM5GbU3Fr/aDPPL4Bp00Pu4QSu++cg+mcyd+PWDCjbHExXeVkfRQsB1
         vNbRg8TFHuAVNr0CIgnfbFAHUfdWWlO0E8x/zLegvZUUqWjAqJHjzSlp4UqTvSn9j/lX
         NnT2T9dAQa6IR2Pa3wb5M29a+2BnE/AuUBGH+5b+KLR4re7/YF6BP08pLOYXtjVLwL0k
         anTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xCZIUJKlOnbwNhuxRGiI7T/gfJU3N5zEWpmYYb9368g=;
        b=H0vU5gTbFt7MSFiJ5POlP8rBumjQU0zCELY6McJiySwwIugZuKWejwoWBOApKbmqb8
         Jt0caRRWm0tX0yA9Zgq3XMxG+94gInpOdly7D/1Yseoi7TfQs6yDkSCZEtYSf8Xzo+K8
         59sjBiiTj8ITP//8OrLBuvFBbz7B6plNPodps4Hv2H0b6uUiBpaOKWw8DUnKIpu3ky29
         IqSHuy8hUIg6Gs3+YdnZ66YqAouhLqOyIr43wLqsrVvkGg0jIv4gILToP8YIiW4MgFgw
         JgPc7BvNeWModWBSggoBRksKKCfeROk6fhsipLf0mjRHIXUjzglNScVaHu5Hcceh0jzt
         ecJw==
X-Gm-Message-State: APjAAAV3DYyuhNa44NxT6M6o2vSsKzHYaU3OmNNmi59vUU7C6Xkex1K1
        gNQ/nih1pFCSIEv93S0a38TJSman
X-Google-Smtp-Source: APXvYqyiJ1AQMKASGSQFMCD6O2sNs2LSokfKzov2kaR04kgZWqIQKLgDRbQb9FAPsue07ziOpburUA==
X-Received: by 2002:a05:600c:141:: with SMTP id w1mr735120wmm.75.1570478920507;
        Mon, 07 Oct 2019 13:08:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5sm17381576wrs.34.2019.10.07.13.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:39 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:39 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:21 GMT
Message-Id: <3a677f32b6b914fcc800b619fd082da25c275422.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 13/17] read-tree: show progress by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The read-tree builtin has a --verbose option that signals to show
progress and other data while updating the index. Update this to
be on by default when stderr is a terminal window.

This will help tools like 'git sparse-checkout' to automatically
benefit from progress indicators when a user runs these commands.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/read-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index ca5e655d2f..69963d83dc 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -162,6 +162,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	opts.head_idx = -1;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	opts.verbose_update = isatty(2);
 
 	git_config(git_read_tree_config, NULL);
 
-- 
gitgitgadget

