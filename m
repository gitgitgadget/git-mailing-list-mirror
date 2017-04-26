Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4501207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 22:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754529AbdDZWJ1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 18:09:27 -0400
Received: from mout.web.de ([212.227.17.12]:62156 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754523AbdDZWJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 18:09:25 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGzjq-1dHGVp2ATK-00DsxX; Thu, 27
 Apr 2017 00:09:19 +0200
Subject: Re: [PATCH v5 0/8] Introduce timestamp_t for timestamps
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <cover.1492771484.git.johannes.schindelin@gmx.de>
 <cover.1493042239.git.johannes.schindelin@gmx.de>
 <7a2271ff-1386-18a6-5f6d-7eb13dc92509@web.de>
 <alpine.DEB.2.20.1704260005310.3480@virtualbox>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b6302244-7425-605e-8103-9aa845c03c3e@web.de>
Date:   Thu, 27 Apr 2017 00:09:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1704260005310.3480@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:0Ag9zWpgnXNX+qyNFmA0AlFM70HvFul1x10ObD/ZWLJ9UgnoBYG
 3SR32w69Qc/6Kr5g+PxVRn7o2C813jo4RNIck13PXQE23UiPAMA7oGVeDWpZIZvdG4x+D7l
 i+IcSGCjVxAP0433HvckvamniOJWUNRX02+lCUQ2bcU2sI9FQCtAVcR95q3msOQz//Cdc6S
 y0FZ6xkTjFRSsivo/nstQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xzD6r3eFcBQ=:z/ux3Q0PdCyoKfPIbZglVv
 zb0f4giQdtuCZwH3Brm2DuOhk//1tn2dDJO2e7/tnjYjzfkPbcUWIQxFcYAayXj5H989v2qkX
 vVnusyPIeBoKWISQ0nj0LUGFdNNmIw0ROh9qHg7VqvY0npD9+khKzJOE4P3Ij6p4qn0iWEmvX
 NvN1r4E7EQ4jkvEDYpmef83kMyRmjodcB4Yuo2++nSSIkfzTdG89+KzSy2L/20W23spa/Gbfz
 JxuZrFVOJ4qekG6srqORRFLGj/WhgwNiDV4uHXvqirTSn067wJngCPr8ckZYm7hxaTsBU06Ke
 05ZZEKNPrOgSw9G4UrU9fxZSM/qv/ToLbPhZMPnCxFRKY/S7qqHnVE0/Ka78+XfkpdeInqsWv
 rqPDTxwk2e0sGuXlrnW6f0IV9fmlv+2Me0qebmwyakBiC8ye6B0Yz6T37f8Hxz2e5OSeLaxtc
 k2VyektIc32KJr7sMXjgQDiXMu7y1HJ7zDSHdpV3cpv0cj54poq5UUKQZ6EPU4zB7IKXFY6Pl
 rq/tjQoA72MkUU/AXGYbb/3gL6G1xE4U/BEh/gpV9Rt2HvVIGcn6gtisxUgWESS6dm4gTAiZo
 RoxF1zGgVibatiAhPA/Rfajgs+Ye9rf2XwZe/ft8rkPyx2uFigrO95Po0nTLuKCE7pUt6E1ql
 GiWz5RxzdZavDJfKE8V5g3wets17wcOXg5YN3w1RK1fiDAV/huSlWIC4BJRZbz5enf7YzZ/4y
 dfR+Npybb3FSkyZjS9Wn/v1knsb0Cyc+LMMPxi8TJMj9Bi0stJ9eOKTCpFC+32WO0LqFzZzEd
 F7Gz/Ik
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Am 26.04.2017 um 00:22 schrieb Johannes Schindelin:
> On Tue, 25 Apr 2017, René Scharfe wrote:
>> Am 24.04.2017 um 15:57 schrieb Johannes Schindelin:
>> Can we leave time_t alone and just do the part where you replace
>> unsigned long with timestamp_t defined as uint64_t?  That should already
>> help on Windows, correct?  When/if timestamp_t is later changed to a
>> signed type then we could easily convert the time_t cases to timestamp_t
>> as well, or the other way around.
> 
> This patch series leaves time_t alone already, so your wish has been
> fulfilled preemptively.

Sounds good!  It does contain conversions from time_t to timestamp_t in
archive-zip.c, though.  I'll comment in reply to the relevant patch.

>>> It is arguably a bug to paper over too-large author/committer dates and
>>> to replace them with Jan 1 1970 without even telling the user that we do
>>> that, but this is the behavior that t4212 verifies, so I reinstated that
>>> behavior. The change in behavior was missed because of the missing
>>> unsigned_add_overflows() test.
>>
>> I can't think of many ways to get future time stamps (broken clock,
>> broken CMOS battery, bit rot, time travel), so I wouldn't expect a
>> change towards better error reporting to affect a lot of users.  (Not
>> necessarily as part of this series, of course.)
> 
> If you want to suggest that we should stop verifying overflows when a
> complex reasoning can prove that the overflow is not happening in a
> billion years, I disagree. Not only is it unnecessarily time-consuming to
> ask readers to perform the complex reasoning, and not only is there enough
> room for bugs to hide in plain sight (because of the complexity), it also
> makes the same code harder to reuse in other software where a different
> timestamp data type was chosen (or inherited from previous Git versions).
> 
> I'd much rather have easy-to-reason code that does not cause head
> scratching (like the "why do we ignore a too large timestamp?" triggering
> `if (date_overflows(date)) date = 0;`) than pretending to be smart and
> clever and make everybody else feel stupid by forcing them through hoops
> of thinking bubbles until they also reached the conclusion that this
> actually won't happen. Unless there is a bug in the code.

No, I meant that the presence of tests does not necessarily cast an
undesirable behavior into stone, especially if it's hard to trigger
in real life.  And that improvements thereof can be done later.  In
other words: It's OK to maintain the same behavior in this series,
but cheer up, we may be able to fix the issue eventually.

René
