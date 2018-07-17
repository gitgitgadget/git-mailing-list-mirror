Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5DF61F597
	for <e@80x24.org>; Tue, 17 Jul 2018 21:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbeGQWX6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 18:23:58 -0400
Received: from s019.cyon.net ([149.126.4.28]:56492 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729754AbeGQWX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 18:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ouAUvmjL+HROXFT9RZnbY6dCeJ03glTpjLGXRdwMSpg=; b=BmSA3Fb7o8IcY84NPsw65i4QnL
        0kuzEsOZRSXh38RQwRBXQ5fe7Ncwo+LhJ4KJNdVVMiGpskGWbJyVZ337zflSCaumcr9ETDab4LJK6
        cTxe6KLUe08M2owJVozN39dcQpWuZB2iESNA9xkxZZ1Xc7zlvibreIok7Q37d4ZwUrlH7lZscxvLM
        EjrWlzBfrKR0YvWhROSHywZ6EVHAlYlYfB98OsQf6hYvYvOo+0+xHTbexJuzZZQlzTnNumftG79M8
        9CcoXdKYbh8mk/4LaoJ9tMevf4RYMOWCU7cWAcIkIiNbNqmTuvahro7H665LYHbjLBXag+ctymsK9
        Jgyc9Vuw==;
Received: from [10.20.10.233] (port=41108 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1ffXqO-00FLM0-Lr; Tue, 17 Jul 2018 23:49:18 +0200
Subject: Re: [PATCH v3 4/4] builtin/rebase: support running "git rebase
 <upstream>"
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com, gitster@pobox.com
Newsgroups: gmane.comp.version-control.git
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180706120815.17851-1-predatoramigo@gmail.com>
 <20180706120815.17851-5-predatoramigo@gmail.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <ae561025-3e99-0e4a-569a-c1ff1f2a2e58@drbeat.li>
Date:   Tue, 17 Jul 2018 23:49:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180706120815.17851-5-predatoramigo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.07.18 14:08, Pratik Karki wrote:
> +static GIT_PATH_FUNC(apply_dir, "rebase-apply");
> +static GIT_PATH_FUNC(merge_dir, "rebase-merge");

Maybe fix this up with

-static GIT_PATH_FUNC(apply_dir, "rebase-apply");
-static GIT_PATH_FUNC(merge_dir, "rebase-merge");
+static GIT_PATH_FUNC(apply_dir, "rebase-apply")
+static GIT_PATH_FUNC(merge_dir, "rebase-merge")

?

(See
https://public-inbox.org/git/20180709192537.18564-5-dev+git@drbeat.li/#t)

Cheers, Beat
