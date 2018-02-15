Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277B31F404
	for <e@80x24.org>; Thu, 15 Feb 2018 19:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167213AbeBOTH0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 14:07:26 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43863 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1167127AbeBOTHX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 14:07:23 -0500
Received: by mail-wr0-f193.google.com with SMTP id b52so713764wrd.10
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 11:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Tq/Q7Usa5XDwR0XMr1f0plCsbF46kxKv7G8nliUHgrg=;
        b=nTeHnb//K1Mxq+KDGEVhZ5MHFQ+coErIziDkD8u9AfacY52m8nl1Nt0DbNoZqQ1ovW
         yRNdmXugbFcP81JcbLiRgCcvTIQQlwJ1Ju+Fi1xFr2c945Fq+SZznYmaLHfvInf6WPGN
         /f5JUNsdz7OgpEukiCfPAEggBDSXtqhS9Pl/s5+Ptb0ioGfhL94CNnA/lIYT0QQta9/l
         j8iofs6qgGxYG5f8rEhx2TdiRfsdunFFO5Q56Nhnvu2CypI9QEubXBiHpFySiT4rjqOf
         x8FJ2mmTARMBawRAg9Ur2fw9huTpIcVoKKnbLu2ZP6pb0WNhxKAN8K1lNbwUCJjLUSDs
         5dAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Tq/Q7Usa5XDwR0XMr1f0plCsbF46kxKv7G8nliUHgrg=;
        b=dQeBFPWWL6NAvxx1MjmsWTTKTOZLV1eSc5MjQnSqxpGA7KM2JS99rTRGcFsT2E77Zp
         dIMNo8TQKDukdOlzSKtLaf0Dgb9gd+2v3+Z7v6bFKJ7xkxdcb/lIU4HM1sVUy3Brzkk/
         XB6xb9atEwPU6AYwNSUB3EGgHk4fqdaGOGpwJpX/iNjsAKlka3IYw/FECJeqfw4J04uh
         z39BvduTeJtCU1Bdl+kfaGmjo/vApcACVipuncv6yNmmawmEXsTxu3fGSzQFgctvFQ2M
         eVWa7TJmtQ6Hzp42io48oQkzyve1+YWHCl5BjDLXOzdHpIor8CSXseNx5jUteAmziG3B
         vTmQ==
X-Gm-Message-State: APf1xPCcXVQkwIWRtZk+S36ZUAuI0ick7d1Cp16u5Y2s2fLXsJvLk5YV
        OKSVKd5ndpDjkTAjoph/hK8=
X-Google-Smtp-Source: AH8x227AQ0gcNOHMm9jBiyNkvSCqZ6tlDmA8E5DRb0AmO83D9LOcf0raYHJv9n6/Wd/vFt1bMRMrkA==
X-Received: by 10.223.150.148 with SMTP id u20mr3209531wrb.276.1518721641863;
        Thu, 15 Feb 2018 11:07:21 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 123sm15868249wmt.31.2018.02.15.11.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 11:07:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation/git-status: clarify status table for porcelain mode
References: <20180215001812.135304-1-sbeller@google.com>
        <20180215001812.135304-2-sbeller@google.com>
Date:   Thu, 15 Feb 2018 11:07:20 -0800
In-Reply-To: <20180215001812.135304-2-sbeller@google.com> (Stefan Beller's
        message of "Wed, 14 Feb 2018 16:18:12 -0800")
Message-ID: <xmqqzi4a842f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> It is possible to have the output ' A' from 'git status --porcelain'
> by adding a file using the '--intend-to-add' flag.  Make this clear by
> adding the pattern in the table of the documentation.
>
> However the mode 'DM' (deleted in the index, modified in the working tree)
> is not possible in the non-merge case in which the file only shows
> as 'D ' (and adding it back to the worktree would show an additional line

Correct.  Thanks, will queue.
