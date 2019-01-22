Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02EE91F453
	for <e@80x24.org>; Tue, 22 Jan 2019 14:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfAVOZ2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:25:28 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:56674 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728361AbfAVOZ2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 22 Jan 2019 09:25:28 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1glwzW-0004Xg-KB; Tue, 22 Jan 2019 15:25:26 +0100
Subject: Re: [PATCH v2 1/1] Use size_t instead of 'unsigned long' for data in
 memory
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
References: <20181117151139.22994-1-tboegi@web.de>
 <20181120050456.16715-1-tboegi@web.de>
 <5b9d020c-00cb-9340-b21f-f16f7fceb8cf@virtuell-zuhause.de>
 <b28d6db2-c2a7-67fe-ce56-12598efcca7c@web.de>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <df4deef6-20ad-707f-2ad9-3fbcb3a66973@virtuell-zuhause.de>
Date:   Tue, 22 Jan 2019 15:25:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b28d6db2-c2a7-67fe-ce56-12598efcca7c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1548167128;b5192e52;
X-HE-SMSGID: 1glwzW-0004Xg-KB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.01.2019 um 18:06 schrieb Torsten Bögershausen:
> On 16.01.19 22:46, Thomas Braun wrote:
>> Am 20.11.2018 um 06:04 schrieb tboegi@web.de:
>>
>> I'm interested in helping getting this forward!
>>
>>> What we really need for this patch to fly are this branches:
>>> mk/use-size-t-in-zlib
>>
>> In pu.
> 
> Junio, is that branch ready for master ?
> 
>>
>>> tb/print-size-t-with-uintmax-format
>>
>> in master.
>>
>>> And then it is rebased on top of all cooking stuff, too many branches
>>> to be mentioned here.
>>>
>>> It may be usefull to examine all "unsigned long" which are left after
>>> this patch and turn them into (what ? unsigned int? size_t? uint32_t ?).
>>> And once they are settled, re-do this patch with help of a coccinelle script.
>>> I don't know.
>>> I probably will rebase it until Junio says stop or someone else comes with
>>> a better solution.
>>
>> I could not spot this series in the cooking list so what is good way
>> forward?
>>
> 
> That patch never made it anywhere (yet)
> The last update on master, which I did so far, is here:
> <https://github.com/tboegi/git/pull/new/tb.190104_0635_convert_size_t_only_git_master_181124_mk_size_t>
> 
> Do you want to continue ?
> 

Yeah I'll give it a shot in the near future.

