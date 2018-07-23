Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7673A1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 19:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbeGWUu6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 16:50:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45381 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbeGWUu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 16:50:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id t13-v6so1826272wrv.12
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fF8SyQIkBkXetxTywu3CACmgKQas16WfANTpDhLyAHY=;
        b=NUol7ZKMWnyHGIzdO3ywstmmDGeNa30PVKeznr4ioLY/nnebkO1kj1gJQ6oBAXCDMw
         V4+VYr0nN53YTF0f0kJxc/RPY8kTUx7iJklu4VbOiZzb5zZzTAqzQaLZaFfd55HsZII4
         LJbcx+llAuQ2ixFlyYJMPRCppfSNLCk01veO8uuoCjV/rlzIDLhjlrKI4SNA4iapJSW0
         tDmWp+wCBSZvRqlZvbTUUHMTPbP/ghXdEgKJH4t/cYTAateVmkZyeAvM2LgmEBVShIsU
         v2bw0omnomkKW7f53bgpzmimelcWuschGRxad2IP6OWspU9Xw864c6spg7C5w+G0h7Ji
         H66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fF8SyQIkBkXetxTywu3CACmgKQas16WfANTpDhLyAHY=;
        b=lgdDMmybBTA8ADmHEQUzG2QrqUTlDxWjNTMVOTVYAtX6/OVIFE2liNutTi4kuQOcvg
         W1t3YeiKqwd+U16F0KzX8qJldZ+3cKjTOYs/j4HijrBgl+PusnLJFZr56vHnQuSXq7s4
         vRGKbQDOBUQH2xdlCaxGwFmq/qHrB3+WrTUZ8Irprp8UW126bGRsmPFNHnneY2C7vzpe
         9+eo7uHKtZVgpTq8r5p5kDfrv7LIV1K3HBxuqZsd+3tyvvb2Bmf24iN1sLrJpjD03Q0N
         qW8FCNukV1jzIIkpBGvZ3EN6cfAw9Ztcj/WjolrHS9ercdncxFT/T8cqg+BoFJU1d6bb
         N89w==
X-Gm-Message-State: AOUpUlFp/4IzWDsu6Sl12SGnIXHKauMPBIVtTrzNGRu53bfealg98Ro6
        lEPxO3J1NImeaOKH1hOmHXI=
X-Google-Smtp-Source: AAOMgpeEB19dj28E4uStlohC6bZWDbbf1BeONmaN+dbUhimSEgHjadLgB8nBHz9cpIa0bWjqPavnzA==
X-Received: by 2002:a5d:6892:: with SMTP id h18-v6mr9461732wru.108.1532375292291;
        Mon, 23 Jul 2018 12:48:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e12-v6sm7505396wrt.29.2018.07.23.12.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 12:48:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/9] contrib: add a script to initialize VS Code configuration
References: <pull.2.git.gitgitgadget@gmail.com>
        <e2e449a00385531d326d6811a871dde59624b818.1532353966.git.gitgitgadget@gmail.com>
Date:   Mon, 23 Jul 2018 12:48:11 -0700
In-Reply-To: <e2e449a00385531d326d6811a871dde59624b818.1532353966.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 23 Jul 2018
        06:52:49 -0700 (PDT)")
Message-ID: <xmqq1sbt68ec.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
> new file mode 100755
> index 000000000..3cc93243f
> --- /dev/null
> +++ b/contrib/vscode/init.sh
> @@ -0,0 +1,165 @@
> +#!/bin/sh

This is caued by our usual "git apply --whitespace=warn" as it
contains lines indented by spaces not tabs (perhaps the json
literals?)  Can we have contrib/vscode/.gitattributes to tweak the
whitespace breakage checking rules so that this file is excempt?

I'll just shut my eyes while applying this series for today, though
;-)
