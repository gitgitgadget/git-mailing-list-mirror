Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF1F1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 13:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfJaNpb (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 09:45:31 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:61445 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfJaNpb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 09:45:31 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iQAlV-0003TY-5S; Thu, 31 Oct 2019 13:45:29 +0000
Subject: Re: git branch --edit-description a custom file
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
 <20191030224328.GB44961@generichostname>
 <20191031061832.GA20830@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
 <8b9021fa-f60c-a2e0-1174-a2fc1f11c476@gmail.com>
 <nycvar.QRO.7.76.6.1910311229150.46@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <9aa1cefc-daeb-e702-95ba-1e83f8f7dcfe@iee.email>
Date:   Thu, 31 Oct 2019 13:45:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910311229150.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
On 31/10/2019 11:30, Johannes Schindelin wrote:
> And while we're dreaming: it would be nice to discern between "push
> upstreams" and "base upstreams". Example: when I work on the
> `fix-t5516-flakiness` branch, I target `upstream/master`, but I push to
> `dscho`, i.e. my "push upstream" is `dscho/fix-t5516-flakiness`.
>
> Ciao,
> Dscho
Yep, the triangular workflow of 'publish' v 'upstream' v 'local' is 
quite tricky. There is little user facing docs for that.

Many of my branches have the wrong "upstream" in the sense that it's the 
push-publish remote that holds copies of my work (i.e. I manually select 
the push-remote every time;-), even though the branches are set to track 
the original start point's upstream.

Philip
