Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661C91F731
	for <e@80x24.org>; Fri,  2 Aug 2019 11:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbfHBLoG (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 07:44:06 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:45415 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfHBLoG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 07:44:06 -0400
Received: from [87.165.18.83] (helo=[192.168.2.6])
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1htVyc-0000kL-Ks; Fri, 02 Aug 2019 13:44:02 +0200
Subject: Re: Support for --stdin-paths in commit, add, etc
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
 <066cfd61-9700-e154-042f-fc9cffbd6346@web.de>
 <xmqqef24op5q.fsf@gitster-ct.c.googlers.com>
 <a6610e94-6318-b962-5dd0-ca379def3bba@syntevo.com>
 <xmqqimrgmx6k.fsf@gitster-ct.c.googlers.com>
 <f35fe280-2e26-f719-4030-faf261bc9a22@syntevo.com>
 <nycvar.QRO.7.76.6.1908021335250.46@tvgsbejvaqbjf.bet>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <7edb3b11-054c-81a9-d88e-7e2325ad813f@syntevo.com>
Date:   Fri, 2 Aug 2019 13:44:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1908021335250.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

@Johannes, thanks a lot for your tips!

On 02.08.2019 13:40, Johannes Schindelin wrote:
>  From past experience, I find that it is important to also implement the
> `-z` option (which traditionally means: accept items via the command
> line that are delimited by NULs).
> 
> And you might find inspiration in my patch to read the paths passed to
> `git reset` from stdin:
> https://github.com/gitgitgadget/git/pull/133/commits/1db4ef0ec1ec
> 
> I guess you could use a similar approach just after the
> `parse_pathspec()` call in `prepare_index()`:
> https://github.com/gitgitgadget/git/blob/1db4ef0ec1ec/builtin/commit.c#L339-L342


