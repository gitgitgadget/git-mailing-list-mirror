Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD891F406
	for <e@80x24.org>; Wed, 16 May 2018 21:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeEPVCl (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 17:02:41 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:54980 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751013AbeEPVCk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 17:02:40 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40mRhv1zftz5tl9;
        Wed, 16 May 2018 23:02:39 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id EA50B108;
        Wed, 16 May 2018 23:02:37 +0200 (CEST)
Subject: Re: Git log range reverse bug
To:     Mehdi Zeinali <zeinali8@gmail.com>
References: <CAJeoX+5ZGFS0yhXwaESzx4kTHn9AOLVF5d2MBU-Sr8JeQRBSxA@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <29bf5b72-8156-5098-ee56-b7c4fea1343c@kdbg.org>
Date:   Wed, 16 May 2018 23:02:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJeoX+5ZGFS0yhXwaESzx4kTHn9AOLVF5d2MBU-Sr8JeQRBSxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.05.2018 um 20:19 schrieb Mehdi Zeinali:
> Git Version: Version: 2.14.2
> 
> When reversing a range in git log, it does not start from the expected commit:

--reverse does not change the meaning A..B to B..A or something. For a 
particular A..B specification, the set of commits selected when 
--reverse is given remains the same. Only the order in which they are 
listed is reversed.

-- Hannes
