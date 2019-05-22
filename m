Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79CA01F462
	for <e@80x24.org>; Wed, 22 May 2019 22:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfEVWPG (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 18:15:06 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:37438 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfEVWPG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 18:15:06 -0400
Received: by mail-pf1-f174.google.com with SMTP id a23so2061833pff.4
        for <git@vger.kernel.org>; Wed, 22 May 2019 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKUNrp74HYmMwWRCnyPDzJIX+5zwYdQ7rvaAXFyqHYw=;
        b=iij6Wdet5bBEZ5BGcvkvrI7KKSFAqUkxoeoA/gODRn83vhoGv9BdAKXb9sJAWNT6Yc
         J+IjZQVcupPpqo2k47l5NVWU+vIXtG3ytlZ5e/6lnDWbVVuYiC3fMwlifx+ziwMDov1K
         0GCmtvnweVS+KUBM4Mo0WvRx9vU3j+gvVMDI+15NPJD4lmnuw5A7DrCqFqNd4QHQaEBX
         HJXsAagB0mV2/6u2mICdj2PbgFMuiEwXN9E+fEpJl+xNN50Q58UrQn4yKCblvwb251jU
         iIj7rASjiysyDwgluSKUSkSfetwT5Z5m3/X/0iGSFe5W9qqYE4Q+6Yq2fKCKdmj8lYpc
         6Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKUNrp74HYmMwWRCnyPDzJIX+5zwYdQ7rvaAXFyqHYw=;
        b=AiFNSS7I/q3z1AVRxM2a6BhZRTMdAC9T1AQj0JYaeoyuUcf01Ic1/CAJGL3kgck4ks
         sQcfsYvhecqonxtfJkjDYT8KQFTZ6xtxKKTscBFbvP1TEKAhN/kIv/aBXaKevvsoAQG6
         e8K/AaEwF97J5MKM1W84VoEFEPklq7D6QnZ5+aqZYY9HnyhgXXn2wcbz3IvaNl2Ibkom
         nnu9WLeZrvcKa77ey/U/3H6bSFl7gQ4G6JM10CPbTJD01e2hvcVV5tId26S0C/Ozwkt4
         OTDmLC+O6KiOne/K7MyW/c+FhqFahqz4VvTk7NbRtVi/f2IVUkMJ1S2cmVkN/TJ2nkfY
         OA9Q==
X-Gm-Message-State: APjAAAUJu3jRwSwCqkwdrIydcz7BFkdjE0yG0ArZiXE7kBhXjbTvHhJJ
        BFgF82RJTBgeR2pGRpzZE7Y=
X-Google-Smtp-Source: APXvYqwPi6wxWaWbacXG88gtMN6wQxc9CKrZTFic7itMTXo5zSWt+s0+li3iPQFPNA0KQLt6aopPhQ==
X-Received: by 2002:a62:4e86:: with SMTP id c128mr98131431pfb.39.1558563305515;
        Wed, 22 May 2019 15:15:05 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id x66sm18200310pfx.139.2019.05.22.15.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 15:15:04 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        olyatelezhnaya@gmail.com, t.gummerer@gmail.com
Subject: [GSoC] Blogging with Rohit
Date:   Thu, 23 May 2019 03:43:19 +0530
Message-Id: <20190522221319.580-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
References: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all

Here I am with one more blog[1], where I talked about how we are
implementing `--skip` flag for git-cherry-pick. How you'll enjoy
reading this.

Thanks
Rohit

[1]: https://rashiwal.me/2019/to-pick-or-not-to-pick/
PS: comment section is now working, please leave your constructive remarks.

