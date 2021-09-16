Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99FAC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DFD61130
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbhIPWcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:32:22 -0400
Received: from lxh-heta-043.node.capitar.com ([159.69.137.90]:61412 "EHLO
        lxh-heta-043.node.capitar.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241081AbhIPWcR (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Sep 2021 18:32:17 -0400
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 97C5E1B13F;
        Fri, 17 Sep 2021 00:30:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 9ACDA1B3AE;
        Fri, 17 Sep 2021 00:30:52 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P9EuX93OsgLz; Fri, 17 Sep 2021 00:30:52 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.145.201])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id ACABA1B2CA;
        Fri, 17 Sep 2021 00:30:50 +0200 (CEST)
Subject: Re: Possible git bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
References: <c7949156-a7e5-085f-4779-82d0538a4d72@schwengle.net>
 <20210916124709.2824551-1-wesley@schwengle.net> <xmqqzgsctu10.fsf@gitster.g>
 <3b4270f9-6139-7007-301b-8a084f4336cf@schwengle.net>
 <xmqqmtocrxwq.fsf@gitster.g>
From:   Wesley Schwengle <wesley@schwengle.net>
Message-ID: <4d17d26a-d945-3875-beed-e23ae6281f54@schwengle.net>
Date:   Thu, 16 Sep 2021 18:30:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqmtocrxwq.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=LbpCFQXi c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=NgX6OPfPqt74TpVTvcPRng==:17
        a=IkcTkHD0fZMA:10 a=7QKq2e-ADPsA:10 a=-POwkhUqAAAA:8
        a=vmGHGI2Ywfn13iqCYa0A:9 a=QEXdDO2ut3YA:10 a=5NxO59_FqQjEf5CpAN6O:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/16/21 5:52 PM, Junio C Hamano wrote:
> Wesley Schwengle <wesley@schwengle.net> writes:

>> As for the patch. The reason why --fork-point is default I do not
>> know, but how to disable it isn't documented and I think it should. It
>> is hidden in the source code and the release notes of 2.31.0. It
>> should be more visible. Which is the reason I submitted the patch.
> 
> Certainly.
> 
 > In any case, updating the documentation to refer to the configuraion
 > variable that tweaks the default for --fork-point would be a good
 > near-term thing to do, but in the longer term, I think it may make
 > sense to fix this "surprise" and transition the default over time,
 > i.e.
 >
 > "git config --help" is the only end-user facing place the reference
 > from the configuration variable to the command line option is found.
 > We should also have a backreference from the command line option to
 > the configuration variable.

A simple reference in the documentation would be a good first step and 
the change of the default can than happen over multiple iterations/versions.

Cheers,
Wesley

-- 
Wesley Schwengle
E: wesley@schwengle.net
