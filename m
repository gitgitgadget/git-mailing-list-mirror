Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399B020A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 19:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeLMTiR (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:38:17 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:59009 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbeLMTiR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:38:17 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43G3r62TlVz5tlD;
        Thu, 13 Dec 2018 20:38:14 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0D8FD100;
        Thu, 13 Dec 2018 20:38:14 +0100 (CET)
Subject: Re: [PATCH 2/2] mingw: allow absolute paths without drive prefix
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.96.git.gitgitgadget@gmail.com>
 <50ac31ef7f4380f37a0e2d3b75e82b324afee9e3.1544467631.git.gitgitgadget@gmail.com>
 <11b17e5d-e843-463b-77da-263e8e3b7598@kdbg.org>
 <nycvar.QRO.7.76.6.1812111134250.43@tvgsbejvaqbjf.bet>
 <8a484f86-1d43-fc0a-22b4-39c770cda6cb@kdbg.org>
 <xmqqmupagn0y.fsf@gitster-ct.c.googlers.com>
 <8efe7938-12a9-7db3-8f95-825ee2e32247@kdbg.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <70faf8fb-5e98-9247-9955-71b8fc983567@kdbg.org>
Date:   Thu, 13 Dec 2018 20:38:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <8efe7938-12a9-7db3-8f95-825ee2e32247@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.12.18 um 07:25 schrieb Johannes Sixt:
> Am 13.12.18 um 03:48 schrieb Junio C Hamano:
>> So,... what's the conclusion?  The patch in the context of my tree
>> would be a no-op, and we'd need a prerequisite change to the support
>> function to accompany this patch to be effective?
> 
> Correct, that is my conclusion.

Moreover, there is no problem with your tree to begin with. I cloned 
into a destination without a drive letter:

C:\>git clone R:\j6t\expat.git \Temp\expat
Cloning into '\Temp\expat'...
done.

and it works fine. If I understood the description in patch 1/2 
correctly, this should have failed.

-- Hannes
