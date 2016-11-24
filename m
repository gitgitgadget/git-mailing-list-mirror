Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787CD1FF76
	for <e@80x24.org>; Thu, 24 Nov 2016 17:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753737AbcKXRkj (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 12:40:39 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:17929 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752087AbcKXRki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 12:40:38 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tPmh45Dsgz5tlB;
        Thu, 24 Nov 2016 18:40:24 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0679F376;
        Thu, 24 Nov 2016 18:40:23 +0100 (CET)
Subject: Re: [ANNOUNCE] Git v2.11.0-rc3
To:     Marc Branchaud <marcnarc@xiplink.com>,
        Junio C Hamano <gitster@pobox.com>
References: <xmqqinrdlr3o.fsf@gitster.mtv.corp.google.com>
 <836824f5-79e5-fbbf-dfe0-78cc19af1fb2@xiplink.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e14747cd-f3ab-a840-f743-c72a15989aa1@kdbg.org>
Date:   Thu, 24 Nov 2016 18:40:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <836824f5-79e5-fbbf-dfe0-78cc19af1fb2@xiplink.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.11.2016 um 17:25 schrieb Marc Branchaud:
> On 2016-11-23 06:21 PM, Junio C Hamano wrote:
>>
>>  * The original command line syntax for "git merge", which was "git
>>    merge <msg> HEAD <parent>...", has been deprecated for quite some
>>    time, and "git gui" was the last in-tree user of the syntax.  This
>>    is finally fixed, so that we can move forward with the deprecation.
>
> Is this still true, given j6t's recent patch at
>
> http://public-inbox.org/git/e61cc267-a59b-3be1-29db-c49d56f521f7@kdbg.org/T/

It is still true. The git-gui shipped with 2.11 does not depend on the 
deprecated syntax. The deprecation can move forward.

In what ever way the regression will be fixed: we do not have to return 
to the deprecated syntax.

-- Hannes

