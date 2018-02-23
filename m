Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48BD81F404
	for <e@80x24.org>; Fri, 23 Feb 2018 13:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeBWNGC (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 08:06:02 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:31913 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeBWNGB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 08:06:01 -0500
Received: from [192.168.2.201] ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id pD31eFNdg5UYopD31e0TaK; Fri, 23 Feb 2018 13:05:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519391159;
        bh=W0RCv0n+RCvBamX3HjkLmUqUTo0BU1Oymlm8C370NEQ=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=U/iMLuDQMqL1DWnaIHqchaQmsFT1kciZUUzLXdoxQ+BYJfIVSMbFfd56aBczKKtm6
         Ko5m+CCQb5MQsVAURqiHLiJ68lrIcNynzbaC3dF93YPFh8K8eEbsj+RkVlKar+DRfh
         U6RtiRMrSV8cpq4rl1/TFy3UuARAKDyPhOULnZZM=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=aOKAkf1m c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=IkcTkHD0fZMA:10 a=KLLeP0ENma1DjwGkVn0A:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Feb 2018, #03; Wed, 21)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <f3c34fa9-e8b3-a523-7247-93c4ff2a536d@talktalk.net>
Date:   Fri, 23 Feb 2018 13:05:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFfKNF4nLUEwbS0BSyP/vKTR2+iSgEm9AODGSOnv4o3CGLPvkNh2kADcTEg7ru4E0RzsKsPfm8U8QH0LCEzcIek9MClO5mJPM0WCiqmCnQNMbsnRi0sj
 Gb9LlgD3QnEbyX7mQzNL9jLe2GY181Ku1E9yC1vFjfjYAJCHMG106VNoK4aaT6q9hPEdAy7nCW8WzmbxMHjrO6ZQbalNnl/lQMU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/02/18 00:31, Junio C Hamano wrote:
> * pw/add-p-recount (2018-02-20) 9 commits
>  - add -p: don't rely on apply's '--recount' option
>  - add -p: fix counting when splitting and coalescing
>  - add -p: calculate offset delta for edited patches
>  - add -p: adjust offsets of subsequent hunks when one is skipped
>  - t3701: add failing test for pathological context lines
>  - t3701: don't hard code sha1 hash values
>  - t3701: use test_write_lines and write_script
>  - t3701: indent here documents
>  - add -i: add function to format hunk header
> 
>  "git add -p" has been lazy in coalescing split patches before
>  passing the result to underlying "git apply", leading to corner
>  case bugs; the logic to prepare the patch to be applied after hunk
>  selections has been tightened.
> 
>  Will merge to 'next'.
> 

Could you hold off on this one please, I do a reroll next week with a
couple of clean-ups for the tests.

Thanks

Phillip
