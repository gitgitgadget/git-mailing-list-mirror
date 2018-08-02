Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A7891F597
	for <e@80x24.org>; Thu,  2 Aug 2018 22:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeHCAcW (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 20:32:22 -0400
Received: from mout.web.de ([212.227.15.4]:33243 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbeHCAcW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 20:32:22 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lv7eE-1ftZOB1ojy-010I70; Fri, 03
 Aug 2018 00:38:53 +0200
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Alexander Shopov <ash@kambanaria.org>
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <87h8kdu3ay.fsf@evledraar.gmail.com>
 <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
 <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
 <20180802165457.GC15984@sigill.intra.peff.net>
 <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
 <xmqqzhy4zgfv.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ea253620-ed28-54a4-0e52-16cbf4ec8451@web.de>
Date:   Fri, 3 Aug 2018 00:38:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqzhy4zgfv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4AJdV+4JHi9ocgZNOV/EsYM7jxm58In5XjeQxnu6U9Yws+YbUA4
 U1T7tUjXComLZTcz485xWeflJvyMgkRt0oJF7ycdFdZ+l3yPm2hX/cZNzdNepCUVb7Db9Ku
 UqHu2Y41iByHZrhdI8EfzdkY32zR5awF20gqqn+xsQLpLb1h338iSTM+IWzoULzZe/puXM9
 3/eNpcfLcPBxAtM01qh3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XH5OGkZ4ReA=:SAD3fNya8f8wVXF6FO1TF4
 OaCrPu3spyR/GL1Y1LcCegVX6M+IVH3y0jw0hMPNnAfKuFVdCtHJWdoR8x4Xme5/MiTAYjEJK
 nHmcEJ65cxcox2EMylgiwU8WBbn8CrVL1AWr+AOylmfURz/LvcX2EUBLQSnVAengHgVq7V2Ql
 KoSb3FpCZhuFu/dg8Yf6zROsdrnNjAEZ3jEMBmF81693tkvu+7tfX7bMh+y1FTK5T2/xjx62r
 ZLbmvVmoAsj4dLST4opJZToLNptr6YnzM1o0CrFLFCVofN9UpnVAgcjGCx8lrOcmq29AX7qu+
 steu8Ql34nXUiizBcob76v2Np8Py1TiiCfH8F8y7744glBr6zk6MDuAH/z4Mgj8Os2yDk3sSj
 RQFbcuveYbR1tOlIhotlFwExsUH9IMr5wE+bYJtoU1wkS48vYoS9yDkOSReSUav7Gu7NLAkrs
 EAgshSQXxdHnEdkgY+167Ia20y/eOLCFgx+nBxTk+f4FXrFET+J6EhllzE6y7rmIWNBx5jGW/
 KEMvQOfXn/b1LqK3tuh9RNn2NzuzwHx56w0G+UE8drmEaaZhDYHcQqgXV4UJ6+IUQEFgU9bZh
 qEp2zt27hwnXZXXdLWZBgp5FVf0HoIhcAXYhXx9OTkTDu66zG/M+bCAWWesEkcQO3PyT1+bx0
 viqQ2nIDvawqQzYn3IRu3aL0WRjKSGufZdWeNp6cyKzWIjREHIhZ/WtrmvBVbGrIV/Pm4CgMO
 Z8z7AS9nEeQMFEDrM0B3wKyP/zbuZdk/ma3IGB2MY3K7WRn3/SZAnwIgOUMN3/YqgZrvBZqxy
 rGAqRM0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.2018 um 22:01 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Am 02.08.2018 um 18:54 schrieb Jeff King:
>>> PS I actually would have made the rule simply "does it begin with a
>>>      '<'", which seems simpler still. If people accidentally write "<foo",
>>>      forgetting to close their brackets, that is a bug under both the
>>>      old and new behavior (just with slightly different outcomes).
>>
>> Good point.
> 
> Straying sideways into a tangent, but do we know if any locale wants
> to use something other than "<>" as an enclosing braket around a
> placeholder?

Bulgarian seems to use capitals instead; here are some examples found
with git grep -A1 'msgid "<' po/:

po/bg.po:msgid "<remote>"
po/bg.po-msgstr "ОТДАЛЕЧЕНО_ХРАНИЛИЩЕ"
--
po/bg.po:msgid "<branch>"
po/bg.po-msgstr "КЛОН"
--
po/bg.po:msgid "<subdirectory>/"
po/bg.po-msgstr "ПОДДИРЕКТОРИЯ/"
--
po/bg.po:msgid "<n>[,<base>]"
po/bg.po-msgstr "БРОЙ[,БАЗА]"

>  This arg-help text, for example,
> 
> 	N_("refspec")			without LIT-ARG-HELP
> 
> would be irritating for such a locale's translator, who cannot
> defeat the "<>" that is hardcoded and not inside _()
> 
> 	s = literal ? "%s" : "<%s>";
>                          
> that appear in parse-options.c::usage_argh().
> 
> Perhaps we should do _("<%s>") here?  That way, the result would
> hopefully be made consistent with
> 
> 	N_("<refspec>[:<expect>]")	with LIT-ARG-HELP
> 
> which allows translator to use the bracket of the locale's choice.

@Alexander: Would that help you?

René
