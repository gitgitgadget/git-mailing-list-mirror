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
	by dcvr.yhbt.net (Postfix) with ESMTP id C42291F462
	for <e@80x24.org>; Sat, 27 Jul 2019 21:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388064AbfG0VGX (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 17:06:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33793 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0VGX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 17:06:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so20120776pgc.1
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TpOoRlh8ecb33LtdpdCem1NiSv9wnGQuS2mQR3/vRPs=;
        b=IyFWl7Lwjn0cdnM1gr+jP+k9hHn0UYf4nUsGV/21imcMJCK9qvKd08x9x0eKXLsTZZ
         uDHi4PjZ8vBVlAFUDNrb9ALQqrvYWZG+rxGI4WuEztOmMSo+Q+9GGmTqjPuJ96XHZBwY
         rB5JyyXKT9eip1fmoPDR+EqaCvZeq2347aU9Y4mDIqTlz9ImaHj+78PHCgdUUQAd8/fh
         284hUmMM6bMuWaQN37df5bWQeXPAlyfDf04M7AY74EuV06GDzZHUmLNyHxrFOLsiS25N
         gHKqJz/paa4Pvhmdwj2qUswXpHMNnR85JEtcIzdypepkSkQoBO3kpmKtPrbR1Efeu8yR
         u+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TpOoRlh8ecb33LtdpdCem1NiSv9wnGQuS2mQR3/vRPs=;
        b=SwcBFsx5RYo3hrhapzuzh5l77U4Pnvlj0RH+97NgUQmlcOyic1lZPS+eW0daACJaVs
         5ZHcyAR/KLryB2ES3yRxkL+/wc09SsSj850jfwb1SbPgzM+GaDRUBS5ccdn2V9x7FBNu
         xidRR1bBvF7cURUzPNgEkzX3l3bRpge+3UOeh74J/J/JHZgnj5iJLy0ruerGJHiSfs9v
         EAQMRLXiQxpUva07+YUt9JWFcqSP5w6j0NfK0m1k2wJbGLIpJbPirsdti8DD81CFfZhk
         03cFh/8lsJ6oxBGd/IMrW4qLraHAKZtrIN5cR1a+3/DeUVSb528znhlX8v306jz18j9v
         bRwg==
X-Gm-Message-State: APjAAAUzJygaPbhWuUODVD5ks4Cw429vrY6jkEdpwFDVdCOoMf2k2UYP
        zhaf21Rd0eJHkjmm5UNlayQegr3JVkk=
X-Google-Smtp-Source: APXvYqyhnVYgAIGOut01tDAZJUphhLOZ4TZqVsbFOpXchvE9YIaEI4PARD1AC3h7jslN08DshNhERQ==
X-Received: by 2002:a62:3883:: with SMTP id f125mr29139684pfa.258.1564261582235;
        Sat, 27 Jul 2019 14:06:22 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.218])
        by smtp.gmail.com with ESMTPSA id z4sm90054780pfg.166.2019.07.27.14.06.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 14:06:21 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        olyatelezhnaya@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC] Blogging with Rohit
Date:   Sun, 28 Jul 2019 02:33:28 +0530
Message-Id: <20190727210328.17314-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
References: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Everyone!

Here an update about my last week[1]. There were reviews on
patches I submitted which need to be accounted. There is also
some _mess_ (commit ordering and merging topics) that needs to
be taken out. Polishing them will teach rebase -i some new flags!

Thanks
Rohit

[1]: https://rashiwal.me/2019/second-evaluation/

