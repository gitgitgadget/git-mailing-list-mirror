Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F35520248
	for <e@80x24.org>; Mon,  4 Mar 2019 19:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfCDT6k (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 14:58:40 -0500
Received: from smtp-35.italiaonline.it ([213.209.10.35]:46753 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfCDT6k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 14:58:40 -0500
Received: from DESKTOP-E4U7JCE ([5.168.24.152])
        by smtp-35.iol.local with ESMTPA
        id 0tjShIbqiYe7j0tjShvK4K; Mon, 04 Mar 2019 20:58:38 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1551729518; bh=2pppKABAhrt1q8odCDql2TyCzhN/X9UhOMnkbVrt6N0=;
        h=Subject:From:To:Date;
        b=ht2SJTO5/OGW4o3E3sYbqFaI1puWW/dBaOhC1NjnLF+jMZzv/iCj86JdgZgL/JG+7
         MO2noWXKO5yrA1MhR7qUi0g5Pqsaek6evqhEwG3JI88CLH/B412J3hfKYAtqaCwUFq
         le+xMHmCRIG5mRifh/dekwRpH6T2rWMly9KCYXyvjp6/IRayRtB1PYV9NMenzqL+ZW
         UwqUwk2x+RRbmgqwKmKQkchTAnzioj9UPOY7C0TgYkAnOrjNuyiq6jxgTD1dbYoYSV
         8SKYvKSeJVLvZ5IG9jgZas5QAtjh9bsgg9sN8lKT/qKJyMchNZTesKWlJbmhctaOj7
         yYH/XzrUQMnzA==
X-CNFS-Analysis: v=2.3 cv=ea/sgIMH c=1 sm=1 tr=0
 a=6M+yewxsaZYMRRaEAwjDyg==:117 a=6M+yewxsaZYMRRaEAwjDyg==:17
 a=IkcTkHD0fZMA:10 a=7Jp93jh9yD-LnpO0KwcA:9 a=QEXdDO2ut3YA:10
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
Message-ID: <1551729517.4092.1.camel@libero.it>
Subject: Can't build first git commit
From:   Fabio Aiuto <polinice83@libero.it>
To:     git@vger.kernel.org
Date:   Mon, 04 Mar 2019 20:58:37 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLME2twW3lq7MkERoRnP/ZfoOUOVFRT8n+tVU96cVoozm9MenTQTQsNqmlXQqW3rvKm6kgIOQlvil1VID3OSY+CvqbOdRMvpaFjM1+BhLEELX+t/9T0Y
 8r4jUL9dScLj0pBNK4QW6DuAKDT96mRUcP4G3xHs77SHyoGvf2YrZCM3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi to all,

I'm trying to build first commit of git made by Linus. I mean the one
named e83c5163316f89bfbde7d9ab23... (I think this is enough).
But at building stage i have the following error:

make all 
gcc -g -o update-cache update-cache.o read-cache.o -lssl
/usr/bin/ld: update-cache.o: undefined reference to symbol
'SHA1_Update@@OPENSSL_1_1_0'
//usr/lib/i386-linux-gnu/libcrypto.so.1.1: error adding symbols: DSO
missing from command line
collect2: error: ld returned 1 exit status
make: *** [update-cache] Errore 1
Makefile:16: set di istruzioni per l'obiettivo "update-cache" non
riuscito

I run a debian stretch on my machine. Could anyone help me?
Thanks in advance.
Fabio.

