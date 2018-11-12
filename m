Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A3201F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 18:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbeKME2M (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 23:28:12 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:5481 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbeKME2M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 23:28:12 -0500
Received: from [192.168.2.201] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id MH1sghplpwhzSMH1sg15TO; Mon, 12 Nov 2018 18:33:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542047624;
        bh=S8I1aT8U5GW3K/DpKrS1UBN0IDc1M+SdmLbJsraqaQQ=;
        h=Reply-To:To:From:Subject:Date;
        b=abOnpX0q1x9cSSt7f1zfLPdevg2Q0ZTBiRHJztS0MViB6Jg0ZN9qB9SLgGHFq1yCG
         fji4bXYXJc4ohioj3Ki784cpSzkeNJ8PH7L9CA2/G7Tqeo0yCZ1fsJ8AVOVVa2XIBG
         +TdsG2gGTLDc1MCxx8LyBq0TWmuGmQfC3kGfpw9c=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=BArZDd5mK4YBb39787wA:9
 a=QEXdDO2ut3YA:10 a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
Reply-To: phillip.wood@dunelm.org.uk
To:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Subject: Regression: rebase -C1 fails in master
Message-ID: <7c0f0b57-d303-d1fe-e551-c8783b5dbc17@talktalk.net>
Date:   Mon, 12 Nov 2018 18:33:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNdNJqlsG/S0tglr96pNDesPYZT2HDevgH9z2p3wZ7uqKhlWwg9fa4tdFKomqqmtHI7sgsWSboF0p8ddm0zbXTJZvbApSRt017IKS17UT9ppuPFJHv+s
 V/mW3MlOGZuPooWN7mlQXm802I5PkeXlNLNApnTtwh9AKOg2jZq+EVy8WgC2GNfqUMRbmdFej24pJ3l1Y2OO4v8Sch2URtDhgJ6mjpr99XjkqoTCID3Svvcx
 UjO5+qIQmLn0LKvy770PAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've just tried running

bin-wrappers/git rebase -C1 @^

and I get

error: unknown switch `1'
usage: git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>]
[<upstream>] [<branch>]
   or: git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>]
--root [<branch>]
   or: git rebase --continue | --abort | --skip | --edit-todo
...

bin-wrappers/git --version gives
git version 2.19.1.856.g8858448bb4

Unfortunately I've not got time it investigate properly at the moment.

Best Wishes

Phillip
