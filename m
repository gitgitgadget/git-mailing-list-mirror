Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBBE920248
	for <e@80x24.org>; Wed, 20 Mar 2019 23:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfCTXIP (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 19:08:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43419 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCTXIP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 19:08:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id l11so2852192pgq.10
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 16:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GmXfxMUXP+rg4LnGXdVVMekNLlWY52reHnx90pnTUsM=;
        b=USMAgzxN+r8+ku/wgJrE8FyJmLTmFvv/mZthx02hLvflvVAElT/JvfvAZsCq+GMcDP
         0mT4jpWtjoGqEsYj9T56QDXF+vRQBYLayAfYeDztKJqOMctr+w8U1eMSM+zMpoMSGogc
         gVth/Bjpy+8PRcWcvXmRNWPj1FJzkF6RKaDaJa1BH2z5uW0iTgvkpvCtULKDdVJkRYkS
         M1LV9dx/N0uFUALAF66vlIampd3WgcTAS1SnbGgk7jT3qZ4I7pHM7FA6yi4eTvlvr0p9
         4zyUva8nK/o+BLsuDMJvbs3Y+2ZGIucSbMrI0pAJqw33CJ5NEht9LTvDUvtAf0Tgb3l5
         m+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GmXfxMUXP+rg4LnGXdVVMekNLlWY52reHnx90pnTUsM=;
        b=OSuITSIIptSCuKOYFaxaajL8Y9D5Jhfvadv6CbLKa8I3hl4baVDYybsb3thpqHiqLO
         sDWn+i7nQX4xPlM7Nd0z0nwdP94sEHoqtAVJfaj2PQIklqxtaK+fVpxfvYPw4SgqOSnT
         1YxtZol/8c85C7XirWpff4km+XNdyJGfYCgcdRmklq0eW6o3UvRT3jEdGphGWKOfz12n
         8MY9C8lPPcBCtv7Mi7TQGu1M6XtvklHjyVbKb1DJ61G42YKkMdCysuuoLOpG5pXuNQ7x
         x7pZs8KvT8qEo8hNkJt0K7szWGkoifodsyq/wvMNZ/rXG0SlmW8Hmhh8Q9Iq4je1roqO
         LhaQ==
X-Gm-Message-State: APjAAAVHNheetlI/DoZPBpF+9OahnoZ3yxtujS+OImhSuOqrQmxJjMBJ
        SJzuCMwBNFmC4g6o/AmIlek=
X-Google-Smtp-Source: APXvYqz2SJV9NRLGyloLAOwzaFb5TZQa4KIyvwg4aGRlXbm0niji/8jii3Gn6e+rJIpZD7ZjeYVLQQ==
X-Received: by 2002:a17:902:380c:: with SMTP id l12mr331176plc.238.1553123293973;
        Wed, 20 Mar 2019 16:08:13 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id 4sm3768309pfo.110.2019.03.20.16.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 16:08:12 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     t.gummerer@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, rohit.ashiwal265@gmail.com,
        sunshine@sunshineco.com
Subject: Re: What's cooking in git.git (Mar 2019, #04; Wed, 20)
Date:   Thu, 21 Mar 2019 04:37:27 +0530
Message-Id: <20190320230727.15553-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190320225638.GF32487@hank.intra.tgummerer.com>
References: <20190320225638.GF32487@hank.intra.tgummerer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-03-20 22:56 UTC Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Junio sometimes applies these fixes himself, if he deems it easier to
> apply them directly than to wait for another iteration, and if he has
> time to do so.  If you have a look at the ra/t3600-test-path-funcs
> branch in gitster/git, e.g. on GitHub [*1*], you can see that Eric's
> suggestions for the commit message in 3/3 have already been applied,
> so there's nothing more you need to do here at this point.

Thanks Thomas for the information. I think then this patch is good to go
for a merge.

Feeling ecstatic
Rohit

