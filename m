Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5DA1F731
	for <e@80x24.org>; Sun,  4 Aug 2019 17:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfHDR3a (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 13:29:30 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:41635 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfHDR3a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 13:29:30 -0400
Received: by mail-pf1-f171.google.com with SMTP id m30so38412536pff.8
        for <git@vger.kernel.org>; Sun, 04 Aug 2019 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=hvIbIwQv5ff1zeTrUA3G7azopvsxA04K1nVxE8bYxjM=;
        b=N1Rgx6FkX3WXRJKeLFgM39YO2Bh71WdrIqodZ4F9fHweb9uWLU2em6mN3+atDWNKSD
         oHsyUKn9xUInE3dsc10n1NxZRiG2prsfJUD2RxgYkAQX8JWkZVD3JTpQLvIWTIZ85wbw
         WZwnHnJ3G8jR+QpTx5BQDP20Jv8nKxDki2SRivRlG2qCT4AEj4a3U6oOKJfOgKL8rFHG
         vdIBlscVnOA11srg7aE6Xfd8Tdk4DIYWe3/Jk6Qzagmi8G6ngBPa5VfiJqz4SbDIHS9f
         9GJeV7dSTPC+2BYm1A4fKBY84dgTkzk8GpZ69XO50dnDAR8u1z5NACpnzvDLMWhwjz4q
         zNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=hvIbIwQv5ff1zeTrUA3G7azopvsxA04K1nVxE8bYxjM=;
        b=n1bkLf/G8E+LJBneJ1xWH4yy6FuMN9uHTasvRNQuc/W2ZJ+/dE/e2WfU0Nq9VBNftK
         ++aXcLQwi2WORJdtXoIX7EVQX16k1MEXvZxaTb02Z9qXBZ9YgPrX38c6PgT4rqlqbJgR
         0nrc1uio874ihUg78POV0Pg2quKU7ObtHI3LoySxrZSqLjh8TkocHowZM+oF80RnxHm3
         pcWvYWcCxb9CvjdRqnkabGgBLqkIJGlIpqfRHLJUFZrcH2ndOKMscF6FnLgJqnbm+1En
         0G5YHOe+j2uG/tkBCAztKaEaczAWm1DtsDk2qiYJVvqwRmKz5i9WrFFfueI8VAIHs0sp
         p2ig==
X-Gm-Message-State: APjAAAXJHR/gXOLkxmlvqltF3yQMCEzaO3hvFSLj8CVEp09YBPhm8Sl/
        Dboj1K8QQIb65psqgWCd7Q4=
X-Google-Smtp-Source: APXvYqzDN4zicCXw27YXvtgGXG/xq6xgpOCd5EgBUPvo1RsZKYFeX3Fpp+AXvCMROJYVnh1PwYqEJQ==
X-Received: by 2002:a63:48c:: with SMTP id 134mr10208016pge.386.1564939769241;
        Sun, 04 Aug 2019 10:29:29 -0700 (PDT)
Received: from [192.168.1.34] (c-24-130-165-243.hsd1.ca.comcast.net. [24.130.165.243])
        by smtp.gmail.com with ESMTPSA id s12sm80762555pgr.79.2019.08.04.10.29.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 10:29:28 -0700 (PDT)
Date:   Sun, 04 Aug 2019 11:29:21 -0700
From:   johnywhy@gmail.com
Subject: Re: Default Clone Dir?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Message-Id: <1564943361.2622.2@gmail.com>
In-Reply-To: <20190804172008.GG118825@genre.crustytoothpaste.net>
References: <1564938816.2622.1@gmail.com>
        <20190804172008.GG118825@genre.crustytoothpaste.net>
X-Mailer: geary/3.32.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thx! The alias is super.



