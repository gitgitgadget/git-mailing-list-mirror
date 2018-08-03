Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D2D1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 04:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeHCGhF (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 02:37:05 -0400
Received: from mout.web.de ([217.72.192.78]:49583 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbeHCGhE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 02:37:04 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQedF-1fO1m13kWD-00U2Wr; Fri, 03
 Aug 2018 06:42:32 +0200
Subject: Re: Re* [PATCH] push: comment on a funny unbalanced option help
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <xmqq36vw4vu5.fsf_-_@gitster-ct.c.googlers.com>
 <b72e5848-a51d-a62d-2a3c-36ea6b8582d0@web.de>
 <xmqqtvoc3fgl.fsf@gitster-ct.c.googlers.com>
 <87effgtsnm.fsf@evledraar.gmail.com>
 <xmqqr2jgzess.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3120e9b3-f3e7-465c-63c3-084d3f010e1e@web.de>
Date:   Fri, 3 Aug 2018 06:42:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqr2jgzess.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tuwQaF2UohmWfE/DPcmspzBMEbToayBxwMDmSoq0vhKDWomnCek
 Mti33A/VizuTVM9wAeD6U86/gd7imMkWEZqm3fKXDbCtC6rmQpiSjPDU7G+bTVqNj6+C7kI
 56cvOmYlecaUatmJCkmaA6JTSk3STBsbICD0ieypizTL9BJvAr5EAlp93E18iRL3HiDSRp7
 S/a3pj5ngWTDYfnGZC0Zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+qViBeBREx4=:Nimc24z57ZFe4BwWUE5VDL
 YAsrx0pthXbCN9DRil44F8FwPomWUr+a/R6nzQaAw/miadFRnFnHxmSGHegWtPJ0OfvFlwvsw
 QdGLzrYY4LGIZX0+G00lI+RNk582IyUmAPZihaRR/nA1Yzn9Y8m4MHchaNniZaK5PWzgmbfv0
 E+oSHW9wTRMaAcGbCbl1gREcpG7gSAQDgNXqp149eLuJREqeBoQtSJCHR41jW81XGmDZt2G16
 xpVs0fy3CjGIBqPR3hVaZ5eef0ICCbX+hLvtlkXkyRdn1RBzy7Kou+SAtfC/8thQxppSp/ZU8
 MYxk7fm40m/cNxYsAPoWy4ILME9t58MUtebLkm8Y8wqadxb8LvrYvOkYdrz1qQoUeuhnj+CEF
 EZIr6gsY2oDG7fbz9tZolUwYw15saGj3zxh+K9R/ws9GsdVqR/jV03WVBu7cfMuNsCxWCAG2k
 fJgRS8NbUhjAqSxF/7vqeDnRS6S/g9rmc6rBVAi1v5unboGOmdm+AjBjNzOEJVyAr3wWGaUN5
 A2xiBT0YE8X2FBttvEoZHWgPrQAimvf+eN/GBbj88SGi2Zavkh12y8/oUKzfRqpm3VZNKO2hm
 jyNKhbXHEeSxNLUfYpfEEnMleNXl2aR1DXMhMl6K3jlyPh3rGsuW8MzCcj5lKRxrVYj9WZN7c
 KGiSg6z7KSE1Y2WtlsEBe7oz0UO+ct16x8f3kLucqQEXd3rKS3fJLd67bcU96a1lm9amvrQ2W
 mYyo64sOaw/wMIfsSC6aYJfX1AavzXK1tv0LMuKfOeJgM7yPtNj5Wh63Sqxm0hk6QHXXR1iPy
 r0zFnE5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.2018 um 22:36 schrieb Junio C Hamano:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>> Thanks, FWIW that's fine by me, and also if you want to drop this "fake"
>> patch of mine and replace it with something René came up with (I have
>> not yet read his 1-6 patches submitted on this topic, so maybe they're
>> not mutually exclusive).
> 
> I think the 6-patch series supersedes this one.  Thanks anyway.

Actually no, I specifically avoided touching builtin/push.c because this
patch already handled it; it should still be applied before patch 6 from
my series.

René
