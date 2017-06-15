Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A749B1FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 08:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751016AbdFOIqj (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 04:46:39 -0400
Received: from mout.web.de ([212.227.15.3]:51115 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbdFOIqh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 04:46:37 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5Oql-1dkX0n3AaN-00zY5a; Thu, 15
 Jun 2017 10:46:02 +0200
Subject: Re: rs/strbuf-addftime-zZ, was Re: What's cooking in git.git (Jun
 2017, #04; Tue, 13)
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706141245520.171564@virtualbox>
 <20170614111043.xlfsgclbyrqektb3@sigill.intra.peff.net>
 <e9260c40-c49f-d7f6-70c2-a28c1b3104a2@web.de>
 <alpine.DEB.2.21.1.1706142303510.171564@virtualbox>
 <f80aa20c-dd7e-41e6-f35f-5c633c169732@web.de>
 <20170615054209.yfucmiq3pghxu76j@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8fc457ea-393b-37fe-c033-beec4128e781@web.de>
Date:   Thu, 15 Jun 2017 10:46:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170615054209.yfucmiq3pghxu76j@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:1RpcKghZJxWXudaA6XkFdK9UW/2C6yjIr7WYqtDCmwCqLmymw5S
 QjnqP9Vbvt+33ET0oepsfPPOJe7MdQQOY8H2/7DQeNgD6L5MVq0NRnvWfxM5/dDkEh4pU6o
 fpy+YvFaXL9pobcvy065K3fNvw3e7bf3V2u6iTeT+GtI7871nIehMTI03txubexMPIWmTzD
 1lps8Mjk2nPAyqExPBh+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FirCnX+HVQ4=:5LJ/OzK0Uzar60W8y6cOag
 qbdokD+xczltoRzsl0zrEA/DKD88SUKsVs9kEz/cE+pc1v5QYUHVPi/emfXMY7DjUMBowWyNk
 +oryltLq/fWNyAvoRuHIpRwwU2VWSsP6YEH+PdKJW7ZN1bojwK2wYhD9gCI2aWE2B0dW9/1WG
 YBvwO4MA2A8mfyjvxUZneYPURehaarYAJUV/e0F6AEBNE0nM/nasLt/DGdU9WoCw+mjF5vQzr
 io4UPE9vhKyBrBEGF11iXC5xHC8vCd7nvDgZsfgCLTNpEkTd67jlPfJBMnst4AIaHTFAfWYJs
 KLX7dDUtMmVBEM7+YeArwM+FA2Z7gzUKRY0w6uZ4RXkRV5MdznuYoPBPSAKusmHLvpphDuFiE
 Da8tgdK2Et1jINlnc02i1PEPYmSUoo7/o960CNLWd9xiBhKWiOReVPBMhlhTA1vEtChh9iH2C
 aU0NOXrO1wH2C4YHJCQD4Nufs6TjSoRfWlQKUgmEaycLFh5teeKPy3DlmkZ1teEBR8ea7hqEY
 V5o547+Cm6T8jL8qXuUimZ0guvKCvZXevx8tdSO+RFsPNnKPc6s3yFJUQN7WScqX4MXdTVas7
 tBW5SHxgP3OzYPpQMVEfKja05lAhBwIHZT3L+q1GJtjtbWtCblj1uar/O2GFEYjMP2uACKQqU
 aUvKA47xMvOuT99HxsvbYIUEkN5RqNW8/wkUvOLIyJIw7+2nZ93R40yk1IiFF+PuuyD0C5GMv
 N0c5RO95EIBBIYT8UWc22wxFYWI1zBFvhLqEDVdL2ghGypsbHlBJUiDvtGPTMlaZY9kz9cTwI
 3B/CSO/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.2017 um 07:42 schrieb Jeff King:
> On Thu, Jun 15, 2017 at 01:03:29AM +0200, René Scharfe wrote:
>> But there's more.  strftime on Windows doesn't support common POSIX-
>> defined tokens like %F (%Y-%m-%d) and %T (%H:%M:%S). We could handle
>> them as well.  Do we want that?  At least we'd have to update the
>> added test that uses them..
>>
>> Here's the full list of tokens in POSIX [1], but not supported by
>> Windows [2]: %C, %D, %F, %G, %R, %T, %V, %e, %g, %h, %n, %r, %t, %u
>> plus the modifiers %E and %O.
> 
> I don't have a real opinion on that. The point of adding strftime was
> always to give the user access to whatever their system supports. In
> particular "%c" which we cannot emulate ourselves.
> 
> If people want support for those other things on platforms that don't
> have it, I have no real objection. But I also don't know that it's worth
> spending time on if nobody is asking for it.

Agreed; let's make the tests more focused (i.e. not exercise %F and %T
needlessly).

René
