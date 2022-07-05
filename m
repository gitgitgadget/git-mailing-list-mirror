Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B577AC43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 09:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiGEJg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 05:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGEJg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 05:36:56 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 874A1CEA
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 02:36:54 -0700 (PDT)
Received: from [10.0.20.65] (unknown [106.120.127.5])
        by APP-05 (Coremail) with SMTP id zQCowAA3WX40BsRiHIalCg--.64490S2;
        Tue, 05 Jul 2022 17:36:52 +0800 (CST)
Message-ID: <a1e53e52-cb08-bbff-f58a-391932707fb7@mails.ucas.ac.cn>
Date:   Tue, 5 Jul 2022 17:36:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: How to display "HEAD~*" in "git log"
Content-Language: en-US
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     git@vger.kernel.org
References: <17411d88-b27a-2d20-623d-85c49dc7754e@mails.ucas.ac.cn>
 <20220705092514.hsm7cou5bqvajvgq@carbon>
 <20220705093057.5ewqobdjrqr3ul2k@carbon>
From:   wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
In-Reply-To: <20220705093057.5ewqobdjrqr3ul2k@carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: zQCowAA3WX40BsRiHIalCg--.64490S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw47Cr45ArWxGr1fKF4fuFg_yoW3uFcEk3
        yqqr9FyrsrZa4fWayvkr48ZFyDWr1jqF1kX34kJwsak343Ga9FyFW3uFZrAFZ5t39rZFZI
        9rs0gryIgF1I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
        cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
        0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0S
        jxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
        ZFpf9x07jOa9-UUUUU=
X-Originating-IP: [106.120.127.5]
X-CM-SenderInfo: xzx2x05xkxxi2u6ptx1ovo3u1dvotugofq/1tbiCQwSAWKY1l8UdAAAsF
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 7/5/22 17:30, Konstantin Khomoutov wrote:
> On Tue, Jul 05, 2022 at 12:25:14PM +0300, Konstantin Khomoutov wrote:
>
> [...]
>> This is admittedly not convenient so it makes sense to turn into an alias:
>>
>>   [alias]
>>     relog = "!relog() { git log --oneline \"$@\" | { n=0; while read line; do printf 'HEAD~%d\t%s\n' $n \"$line\"; n=$((n+1)); done; }; }; relog"
> [...]
>
> An alternative to an alias it creating a specially named script file which
> must be executable and located in a directorly listed in the environment
> variable PATH.
> For instance, if you have ~/bin listed in your PATH, you can create a file
> named "git-relog" containing the encantation from my first mail in this
> thread, then call
>
>    $ git relog
>
> and that script will be found and executed.
Thanks for your reply, it does solve my problems.

