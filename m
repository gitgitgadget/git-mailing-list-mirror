Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F231F404
	for <e@80x24.org>; Thu,  8 Mar 2018 04:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933415AbeCHEKm (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 23:10:42 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:54262 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeCHEKm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 23:10:42 -0500
Received: by mail-it0-f47.google.com with SMTP id w63so5984971ita.3
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 20:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GNAa7ej07UCQcJXkFwvEW/2Wk6TSqmMhvSsNcRPZTBM=;
        b=u6MCKJN9RKEd6+TTB/LK5Za+sVlr/nEOs7LQx5sjWHpdzBfbBV6YFUE/sRSW+dt+cR
         IoF7WGaesd5NyQDBTjH9CPQ7WM2pNEAje+VzjIbx+7kXtW+ASwY21juglJ8mI7duhOnF
         yn/MUmqylB+xCyry6uBiQAat6eBllWm6nSZDVr2z7oQIFnkezEhHzfhqR/Lm57Ov0ksV
         qmR1CYEDaTw7ybwx9NliAaTWtRfuwiIOWY4r0u9DhypjzsV81Mt7P59JjAQvvA/33YAP
         nj5CFSAtRJQmVu6Pn1yO7qmWrCPnJLqZzOBNh2ft0X7+OHk8pVKUgQo2jFa5W9JGOw5p
         ssKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GNAa7ej07UCQcJXkFwvEW/2Wk6TSqmMhvSsNcRPZTBM=;
        b=W09iKQinfaxCa/OD+tlvCqs8B0tIBEpLQiO+nutvLUrt6horJTdPqfnPR7+Qn+u/i8
         BDtQCb0qPfk6bLEb7dL8YdKEux8Hrc2//nVSvXciUDvTMpbL6siY4u8OIQVB+WnPTJeS
         kgkp7JFQg+dnYSJejEhg55mMb+/t2k3NdnIpDdXtNK8zrTBE2CK2s14iCXCFhgxoYZNK
         UZJXT/AmSX4VpRSMxTYFLrKqylAIKEVQn5RXtk0nOS2z32C54C8HQ3LXVrYwU6G2qi7n
         pkVGXJLP3VqQq6YdOTHNkgoKLn4TSSBbvlEvdFCIo1qd3j1g+ierxYelPTkUgBDw4gQq
         uzMQ==
X-Gm-Message-State: AElRT7FOa3c+/L8P/tdQMKfrsUKaCO3LQEk517NuDNoc1do8WRis0B/Y
        XLx+CD9zkWpwLZrFnwwsOIMI/SwOqUACGPrQGsXzAgq4
X-Google-Smtp-Source: AG47ELthdoW2eG3Na3qKEDMbWP5rpYvyVHBTrqiwwRLRtH8uwS69D5uMWo9hbbXUIS9kjLg6rPsRAELGJzEs+dh/oiQ=
X-Received: by 10.36.71.72 with SMTP id t69mr27445724itb.10.1520482241249;
 Wed, 07 Mar 2018 20:10:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.180.179 with HTTP; Wed, 7 Mar 2018 20:10:40 -0800 (PST)
From:   ZhenTian <loooseleaves@gmail.com>
Date:   Thu, 8 Mar 2018 12:10:40 +0800
Message-ID: <CAGrdoOoviEvGjg6jC0_h-zi11-Le+vva6L_2Q4A_VMM03aDr0A@mail.gmail.com>
Subject: I got a forced update after I run git pull --rebase
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I can't reproduct my issue, this is my first time, but my colleague
came across this issue several weeks ago.

After I pushed my commit to git server without rejection. I run git
pull --rebase, then I got a forced update, and my last commit is
missing.

I have asked a question on StackOverflow, there is more details about
this issue: https://stackoverflow.com/questions/49164906/why-git-pull-rebase-results-a-forced-update

I have no idea about this.

I'm using Ubuntu 16.04.4 with Git 2.16.2, PyCharm IDE.

----
Sincerely,
Tian Zhen
