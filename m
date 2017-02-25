Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD1A201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 12:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdBYMVG (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 07:21:06 -0500
Received: from userp1050.oracle.com ([156.151.31.82]:41763 "EHLO
        userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbdBYMVG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 07:21:06 -0500
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
        by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v1PC81G8003030
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 12:08:01 GMT
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v1PC6qsM019630
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 25 Feb 2017 12:06:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.13.8/8.14.4) with ESMTP id v1PC6qRu016628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 25 Feb 2017 12:06:52 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v1PC6ndw024217;
        Sat, 25 Feb 2017 12:06:50 GMT
Received: from [10.175.206.239] (/10.175.206.239)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 25 Feb 2017 04:06:49 -0800
Subject: Re: [PATCH 1/2] apply: guard against renames of non-existant empty
 files
To:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
 <E14B054C79E1450F8B41E6477D1D7CD1@PhilipOakley>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <0cdd4304-7b71-c38d-21ab-b4e997242bd4@oracle.com>
Date:   Sat, 25 Feb 2017 13:06:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <E14B054C79E1450F8B41E6477D1D7CD1@PhilipOakley>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: userp1040.oracle.com [156.151.31.81]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/02/2017 12:59, Philip Oakley wrote:
> From: "Vegard Nossum" <vegard.nossum@oracle.com>
>> If we have a patch like the one in the new test-case, then we will
>
> "the one in the new test-case" needs a clearer reference to the
> particular case so that future readers will know what it refers to.
> Noticed while browsing the commit message..

There is only one testcase added by this patch, so how is it possibly
unclear? In what situation would you read a commit message and not even
think to glance at the patch for more details?


Vegard
