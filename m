Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82BF51F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 23:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbdARXai (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 18:30:38 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33640 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbdARXag (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 18:30:36 -0500
Received: by mail-pf0-f176.google.com with SMTP id y143so7896899pfb.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 15:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K04Q96WU2YialEgzjz2DW2RhXriJnVa0Ma/JKKcYNzk=;
        b=aqPmjqpW/gxkrgl3kEJwfSPo14zTak+7ESz3bb5LpyQ+Yfilzhybfc/RjMufGqKBbW
         lpbk6eM2ve6ioZUWRMXeeCyob7L3bFP/CyftRkWyQ0ZEfkzm3jsK8044ZkCe84wpLl4J
         UeFE8ZG+/65m6kfh8ikUwI30r9r21FtKgzjHcB4fizsVPWYy+KxZ3EzrSgDtet7/uqCy
         uswalYM4T2KtXty5uVqqIZ25AcVzlBLaCbIBn4CRWO+HquPUsqcyIktj2D8l6t+01RAR
         iF4PUOXpZIv9L1sdVNLHecMrtqD3vdE4XaKhydZoP6uD7Tp54iPmUlZ+GW5LuvGWjSfM
         sgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K04Q96WU2YialEgzjz2DW2RhXriJnVa0Ma/JKKcYNzk=;
        b=cL731gLnoFsbRVdafeg+er8ejsFzV/CON7Oe/etvqkqv100bn8KeYwmp9Qk76LqDwq
         3FzsbCjP5PM550t8VcD8gep0xHVt925mCitKKg7yXLyhr5lFw/b5ljRx0zU8yU63eduZ
         ygcFANXErP4cbdb14jJ4HdSU16YgXwLMA53JXPlGNi4cmXQaeetgquN8WTHI3KKZHpFF
         r1LOek/mrJGc1IuSwU6gASFrJwxZvTPiHsr3S13IaKlS5cyzM4NHemTRhsLKRkW+qA9s
         sWiiPpwd6POHfA9o+l1f7hvVgjUUWcSyy6CtRgQ11bqjF/AL2PDYJ08zMZTlo1eB5+rj
         7wLQ==
X-Gm-Message-State: AIkVDXJ/onY2MSCc0yMJiD03InJJXavLlGSK+6K9sLqLC9ARsNuAcAxqql+oBMHvTbTFl66k
X-Received: by 10.99.47.199 with SMTP id v190mr6903936pgv.26.1484781720858;
        Wed, 18 Jan 2017 15:22:00 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:40e0:b9ca:546a:a0ec])
        by smtp.gmail.com with ESMTPSA id x4sm3259117pgc.14.2017.01.18.15.22.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 15:22:00 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/4] start documenting core functions
Date:   Wed, 18 Jan 2017 15:21:41 -0800
Message-Id: <20170118232145.31606-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.299.g762782ba8a
In-Reply-To: <20170117233503.27137-1-sbeller@google.com>
References: <20170117233503.27137-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
included all suggestions from Junio

v1:
The two single patches[1] are turned into a series here.

[1] https://public-inbox.org/git/20170117200147.25425-1-sbeller@google.com/

Thanks,
Stefan

Stefan Beller (4):
  cache.h: document index_name_pos
  cache.h: document remove_index_entry_at
  cache.h: document add_[file_]to_index
  documentation: retire unfinished documentation

 Documentation/technical/api-in-core-index.txt | 21 -------------
 cache.h                                       | 43 +++++++++++++++++++++++----
 read-cache.c                                  |  1 -
 3 files changed, 38 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/technical/api-in-core-index.txt

-- 
2.11.0.299.g762782ba8a

