Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202B21F859
	for <e@80x24.org>; Fri, 19 Aug 2016 18:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754083AbcHSSln (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 14:41:43 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:46946 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753616AbcHSSlm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 14:41:42 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3sGBdG2XV1z3hmqL;
        Fri, 19 Aug 2016 20:41:38 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3sGBdG25DtzvSfS;
        Fri, 19 Aug 2016 20:41:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id Nbqq_fD7cShP; Fri, 19 Aug 2016 20:41:37 +0200 (CEST)
X-Auth-Info: IhTQTZNMBy7cVyFgz4U9l7Ns5X6SbAkTbIXxhTxiKYT1dh5u7IHE9wtxpiLzTUlM
Received: from igel.home (ppp-88-217-14-93.dynamic.mnet-online.de [88.217.14.93])
        by mail.mnet-online.de (Postfix) with ESMTPA;
        Fri, 19 Aug 2016 20:41:37 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 0CF512C2DE3; Fri, 19 Aug 2016 20:41:37 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Olaf Hering" <olaf@aepfle.de>, <git@vger.kernel.org>
Subject: Re: git format-patch --break-rewrites broken in 2.9.3
References: <20160818144421.GA9062@aepfle.de>
        <04D3C5DBA44C4AC48D0D846B337D2EE0@PhilipOakley>
X-Yow:  Why is it that when you DIE, you can't take your
 HOME ENTERTAINMENT CENTER with you??
Date:   Fri, 19 Aug 2016 20:41:37 +0200
In-Reply-To: <04D3C5DBA44C4AC48D0D846B337D2EE0@PhilipOakley> (Philip Oakley's
        message of "Fri, 19 Aug 2016 19:04:50 +0100")
Message-ID: <87inuwiota.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Aug 19 2016, "Philip Oakley" <philipoakley@iee.org> wrote:

> On Thu, Aug 18, 2016 at 04:44:21PM +0200, Olaf Hering wrote:
>
>> This command used to create a diff which can be consumed by patch. But
>> at least with 2.9.3 it just gives a rename output:
>>
>>  git format-patch \
>>         --no-signature \
>>         --stdout \
>>         --break-rewrites \
>>         --keep-subject \
>>
>> 95fa0405c5991726e06c08ffcd8ff872f7fb4f2d^..95fa0405c5991726e06c08ffcd8ff872f7fb4f2d
>>
>>
>> What must be done now to get a usable patch?
>
> As an aside, the range can be shortened to
>
> 95fa0405c5991726e06c08ffcd8ff872f7fb4f2d^!

In the context of format-patch you can also use -1 to select the topmost
commit from the list.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
