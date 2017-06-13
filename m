Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1748D20401
	for <e@80x24.org>; Tue, 13 Jun 2017 02:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbdFMCKK (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 22:10:10 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:50522 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbdFMCKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 22:10:09 -0400
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v5D29hcP018269
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2017 02:09:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id v5D29hbm027909
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2017 02:09:43 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v5D29fcG011977;
        Tue, 13 Jun 2017 02:09:42 GMT
Received: from oracle.com (/24.246.5.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Jun 2017 19:09:41 -0700
Date:   Mon, 12 Jun 2017 22:09:39 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     ?var Arnfj?r? Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Kebe <michael.kebe@gmail.com>
Subject: Re: [PATCH 0/3] update sha1dc
Message-ID: <20170613020939.gemh3m5z6czgwmzp@oracle.com>
References: <20170606124323.GD25777@dinwoodie.org>
 <20170606151231.25172-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606151231.25172-1-avarab@gmail.com>
User-Agent: NeoMutt/20161126 (1.7.1)
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* ?var Arnfj?r? Bjarmason <avarab@gmail.com> [170606 11:12]:
> This updates sha1dc fixing the issue on Cygwin introduced in 2.13.1,
> and hopefully not regressing elsewhere. Liam, it would be much
> appreciated if you could test this on SPARC.

Tested and confirmed this works for SPARC with no build flags.

Sorry for the delay, I was away last week.

Thanks,
Liam

