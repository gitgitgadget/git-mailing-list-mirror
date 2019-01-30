Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC48D1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 11:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfA3LdY (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 06:33:24 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:40824 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfA3LdY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 06:33:24 -0500
Received: by mail-qt1-f173.google.com with SMTP id k12so25760451qtf.7
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 03:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/M/1uXbazTMJhN4uy+HZn/A2BtfnGH0roveIbjWKLt4=;
        b=ZAKbs7LtAUo4PyK7dKlGUANPM2Z92HLn/yWaXkXRh4Etlu/IST8T35Ufxn0XTF2Vto
         ueCaEQNFEidrXiNCkPRaMS2tNRZDLtBNXVV0lxs+QujtMH0a3A5RX9ERND0d0Zh+XXAd
         1Ea+IS8OJNqUIdvkXfzWDAuDBexO41DfMJl6PBl51kKwl7n9AlsbOdH/Lwt4afAyiktq
         Kpjyt/+86OTCDp97KGXbIfAw99urua4ComHvgIzBYnIr8b8KuSlT8vd6sehLtFJ3Ram4
         Mz589XWAndRqUIV75iLYsPu4qTGdms2iHswzFvkPCbxQREMLIu4u07TgeRbUOxxUfLxP
         YT5g==
X-Gm-Message-State: AJcUukf6Tfqtc9WLe6oJLhXaPyMoTHQk2026RNlxuLA1yEiKppEVKe3P
        KVteZJi6VWLTIjrwZaXLaz++vFmRl3zRRdIbB8w=
X-Google-Smtp-Source: ALg8bN73BUxSYdF7td6u4Fri6mWl+ISmGJt1wBjCKTN2d9W7W5k+s3gCKRAtlS+M/tBLVteHmSgCI3LNkeWVATX0GyU=
X-Received: by 2002:ac8:27c8:: with SMTP id x8mr28950754qtx.352.1548848003374;
 Wed, 30 Jan 2019 03:33:23 -0800 (PST)
MIME-Version: 1.0
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-2-jeremyhu@apple.com>
In-Reply-To: <20190129193818.8645-2-jeremyhu@apple.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 Jan 2019 06:33:12 -0500
Message-ID: <CAPig+cSkm-M7fP=KLOCO5J8OSYCEyjy950AM=VzTnP9C6AcKxw@mail.gmail.com>
Subject: Re: [PATCH (Apple Git) 01/13] .gitignore: Remove *.s as it matches
 *.S on case insensitive filesystem
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 3:11 PM Jeremy Huddleston Sequoia
<jeremyhu@apple.com> wrote:
> This was causing problems with ppc/sha1ppc.S

What problems, exactly?

> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> ---
> diff --git a/.gitignore b/.gitignore
> @@ -195,7 +195,7 @@
> -*.[aos]
> +*.[ao]
