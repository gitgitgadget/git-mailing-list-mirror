Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCDF82023D
	for <e@80x24.org>; Mon, 22 May 2017 16:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933891AbdEVQ2Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 12:28:25 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:34628 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932514AbdEVQ2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 12:28:25 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wWkc6587qz5tlB;
        Mon, 22 May 2017 18:28:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4BAAB4329;
        Mon, 22 May 2017 18:28:20 +0200 (CEST)
Subject: Re: [PATCH 0/2] Fix warnings on access of a remote with Windows paths
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        stefan.naewe@atlas-elektronik.com
Cc:     git@vger.kernel.org
References: <cover.1495261020.git.j6t@kdbg.org>
 <122838f4-5f6b-6921-9242-2724bb6d8c95@atlas-elektronik.com>
 <alpine.DEB.2.21.1.1705221600100.3610@virtualbox>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1542d54f-d530-b60d-3270-d9b4e94c814d@kdbg.org>
Date:   Mon, 22 May 2017 18:28:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1705221600100.3610@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.05.2017 um 16:01 schrieb Johannes Schindelin:
> On Mon, 22 May 2017, stefan.naewe@atlas-elektronik.com wrote:
>> Am 20.05.2017 um 08:28 schrieb Johannes Sixt:
>>> This small series fixes these warnings on Windows:
>>>
>>> C:\Temp\gittest>git fetch C:\Temp\gittest
>>> warning: unable to access '.git/remotes/C:\Temp\gittest': Invalid argument
>>> warning: unable to access '.git/branches/C:\Temp\gittest': Invalid argument
>>>  From C:\Temp\gittest
>>>   * branch            HEAD       -> FETCH_HEAD
>>
>> What is the exact precondition to get such a warning ?
>>
>> Just wondering, because I'm not able to reproduce that warning
>> (with Git4win version 2.13.0.windows.1).
> 
> I had tested this also, and came to the conclusion that only Hannes'
> MSys-based custom version is affected that is much closer to git.git's
> `master` than to Git for Windows' fork.

In this case, the warning occurs because I build with nd/fopen-errors.

Which explains why I observed it only recently even though I fetch from 
Windows paths regularly.

-- Hannes
