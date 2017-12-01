Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AF6F20954
	for <e@80x24.org>; Fri,  1 Dec 2017 16:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbdLAQtF (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 11:49:05 -0500
Received: from siwi.pair.com ([209.68.5.199]:32965 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750994AbdLAQtE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 11:49:04 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E555A84556;
        Fri,  1 Dec 2017 11:49:03 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C829E844BB;
        Fri,  1 Dec 2017 11:49:03 -0500 (EST)
Subject: Re: What's cooking in git.git (Nov 2017, #08; Tue, 28)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <787549da-b6ea-2c26-037c-bd4d86d316ad@jeffhostetler.com>
Date:   Fri, 1 Dec 2017 11:49:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/28/2017 8:17 PM, Junio C Hamano wrote:
> [Cooking]
> 
> 
> * jh/object-filtering (2017-11-22) 6 commits
>    (merged to 'next' on 2017-11-27 at e5008c3b28)
>   + pack-objects: add list-objects filtering
>   + rev-list: add list-objects filtering support
>   + list-objects: filter objects in traverse_commit_list
>   + oidset: add iterator methods to oidset
>   + oidmap: add oidmap iterator methods
>   + dir: allow exclusions from blob in addition to file
>   (this branch is used by jh/fsck-promisors and jh/partial-clone.)
> 
>   In preparation for implementing narrow/partial clone, the object
>   walking machinery has been taught a way to tell it to "filter" some
>   objects from enumeration.
> 
>   Will merge to 'master'.

Could we wait on this.  I'd like to send up a V6 that
addresses the assert() questions raised.  And Jonathan
Nieder had a few suggestions that I want to address.

Thanks.
Jeff

