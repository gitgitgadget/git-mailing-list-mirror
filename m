Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C25C433EF
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 02:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiCSCDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 22:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiCSCDM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 22:03:12 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DE5E2DF3C6
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 19:01:50 -0700 (PDT)
Received: from [10.0.20.65] (unknown [106.120.127.5])
        by APP-05 (Coremail) with SMTP id zQCowAA3GfKKOTViM_QtBA--.49232S2;
        Sat, 19 Mar 2022 10:01:47 +0800 (CST)
Message-ID: <550558de-7847-ee2e-171b-1e03f2daf570@mails.ucas.ac.cn>
Date:   Sat, 19 Mar 2022 10:01:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: how to automatically open conflicted files when "git rebase"
 encounter conflict
Content-Language: en-US
To:     git@vger.kernel.org
References: <bc7b04de-17be-df86-1c93-792903eeec9b@mails.ucas.ac.cn>
 <xmqqtubvc32q.fsf@gitster.g>
From:   wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
In-Reply-To: <xmqqtubvc32q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: zQCowAA3GfKKOTViM_QtBA--.49232S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYf7k0a2IF6w1UM7kC6x804xWl14x267AK
        xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
        6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
        1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC
        4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1j6r15MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8m9aPUUUUU==
X-Originating-IP: [106.120.127.5]
X-CM-SenderInfo: xzx2x05xkxxi2u6ptx1ovo3u1dvotugofq/1tbiCwoKAVz4k5kQ9gABsD
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/18/22 12:11, Junio C Hamano wrote:
> wuzhouhui <wuzhouhui14@mails.ucas.ac.cn> writes:
>
>> Hi
>>
>> When "git rebase" stopped due to conflict, I have to manually open
>> conflicted
>> file one by one and resolve conflict, and the typing file path is too
>> boring.
>> So, how to automatically open (e.g. use Vim) conflicted files?
>>
>> Thanks.
> Perhaps take "git jump" from contrib/ and do
>
>      $ GIT_EDITOR=vi git jump merge
Thanks everyone, The "git jump merge" satisfies my needs.

