Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26BBC1FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 19:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757934AbdJKTXV (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 15:23:21 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:46289 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757370AbdJKTXU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 15:23:20 -0400
Received: by mail-pf0-f169.google.com with SMTP id p87so1748460pfj.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yy3sx8Ue6JaI885mFsGT0VddiGfrytFzDymdwYuJJlY=;
        b=jjZhtwnwNDmV2LcG4H/94yM2dtH6dNW7ZDE7RcARkkE443FaHEX2jS3IezUxlOmsPD
         MbyhmymHeiHQZZW30W5ET1QqdMiBxRg8BLB0NmdzzXsg1Ouwcwc96UrtXcKWHSnulDi9
         kV1AkdBKi0KM/Asfl86A49QRBiA3CJKLQbO8rnLcTn9ugMb/PmzAMn5zXld+ImAt5Mge
         2Ijy8Kdvky3HaRBnkc3fG3mCHuLgepx2r+A8QAZSzIxwqvrr4M4uOrfY1jyQ30Lxu0vz
         kHBQ7L60WGXIjT8v7yxVNmgV5d7bM+XqeroK4IatU14JuKs1CaUqpU1qZCQwo3ZerMBd
         KPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yy3sx8Ue6JaI885mFsGT0VddiGfrytFzDymdwYuJJlY=;
        b=KU3flOnxpxxbdleiKS0m60+GT0nuqSCTf88dpSfUv9lY9viEcCKYtKvfJGyPHBoq7a
         DToKIih4lr6fK2iZkoU51tB/S694GPnkqbp97X+VwkP9QFFxeaW7v11RJcS47wJ/sglM
         9EXRBQOOXMkeUgGthFc6pJ7Y9uz6jFAi74jz4sH66fBHIjw2ZvSmw6yVKZqHRNkERakr
         vtPGwmLHM+lLDbWPlY5Ccq1Hy1Zb6McLGjmmFnAMacdkRLX/PNE4QYDKVXAz09A8iyDG
         l44h6Wplc5++48n2DYFW/ST1UotWLzyxccACLn/8dz5hixC5RDXzCH9vGk9LTeNwOEdi
         6MJg==
X-Gm-Message-State: AMCzsaWNd8ejFKVAQjwJbhpRBBx4JmZQD5d+ghyiCV9pIB7HZW00NdSW
        WOJMMCfKO1g01U/Hb0G25J8XVQ==
X-Google-Smtp-Source: AOwi7QAuTN9IhchNW2jaZ0/XcTC43QGwdDcZj5o5gEx3GwsYFzqT1N9+d1r5QYY8TdMHB2y0t1p3fw==
X-Received: by 10.101.86.9 with SMTP id l9mr32394pgs.297.1507749799423;
        Wed, 11 Oct 2017 12:23:19 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:f009:30df:5144:99e2])
        by smtp.gmail.com with ESMTPSA id d124sm24557167pfc.42.2017.10.11.12.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Oct 2017 12:23:18 -0700 (PDT)
Date:   Wed, 11 Oct 2017 12:23:18 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     =?UTF-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: how can I conform if I succeed in sending patch to mailing
 list
Message-Id: <20171011122318.71a40d5e6d89fedbb74e22da@google.com>
In-Reply-To: <CAC2JkrJV7XdRyLiu3fTLZmLSJzU3GX_2rr6sQcUx-w0-BZ7f1g@mail.gmail.com>
References: <CAC2JkrLfcUzipRPhUHiVEMipsPVcia6ku+QK7OwMJrME-JtAzQ@mail.gmail.com>
        <CAC2JkrJV7XdRyLiu3fTLZmLSJzU3GX_2rr6sQcUx-w0-BZ7f1g@mail.gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 12 Oct 2017 04:14:18 +0900
小川恭史 <aiueogawa217@gmail.com> wrote:

> Hello, I found a mistake in documents, fixed it, and send patch to mailing list.
> 
> Sending patches by 'git send-email' with Gmail smtp seemed to be
> successful because CC included my email address and I received it.
> However, I never received email from mailing list. Of course I'm
> subscribing mailing list.
> 
> How can I conform if I succeed in sending patch to mailing list?

The easiest way I can think of is to check an online mailing list
archive [1].

I think your patch was received, as you can see in [2].

[1] for example, https://public-inbox.org/git/

[2] https://public-inbox.org/git/?q=aiueogawa217
