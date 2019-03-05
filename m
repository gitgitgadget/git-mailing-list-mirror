Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1650420248
	for <e@80x24.org>; Tue,  5 Mar 2019 13:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfCENR4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 5 Mar 2019 08:17:56 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:51478 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727620AbfCENRz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 08:17:55 -0500
Received: from [192.168.1.102] (unknown [120.244.114.139])
        by APP-01 (Coremail) with SMTP id qwCowACnGP31dn5csZkTIA--.4900S3;
        Tue, 05 Mar 2019 21:17:42 +0800 (CST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: How to determine the order of commit
From:   wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
In-Reply-To: <CAP8UFD21SaWUSqpKjTYVQkbQxLpFEhvjJW8019i6tAS9agnWGg@mail.gmail.com>
Date:   Tue, 5 Mar 2019 21:17:41 +0800
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <1AC99C35-03C0-4121-93B2-0D42F126106D@mails.ucas.ac.cn>
References: <40f11dda.1d424.1694d0cd42b.Coremail.wuzhouhui14@mails.ucas.ac.cn>
 <CAP8UFD21SaWUSqpKjTYVQkbQxLpFEhvjJW8019i6tAS9agnWGg@mail.gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-CM-TRANSID: qwCowACnGP31dn5csZkTIA--.4900S3
X-Coremail-Antispam: 1UD129KBjvdXoWrAFy5WFyrZF1xGF4xJFy7Wrg_yoWxGFcEvr
        ykWFZakrWkJFy7Za1DKFW09FnFy34rJF4fKr95trnIva4xXF9xCrWvqFZakF4rC34ktrsx
        GFs0q3W2yrW2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
        0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
        Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8gAw3UUUUU==
X-Originating-IP: [120.244.114.139]
X-CM-SenderInfo: xzx2x05xkxxi2u6ptx1ovo3u1dvotugofq/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Mar 5, 2019, at 8:39 PM, Christian Couder <christian.couder@gmail.com> wrote:
> 
> Hi,
> 
> On Tue, Mar 5, 2019 at 10:00 AM wuzhouhui <wuzhouhui14@mails.ucas.ac.cn> wrote:
>> 
>> Suppose I have "git format-patch" two commit from a repository like
>> following:
>> 
>>  git format-patch -1 cf1c9ccba730
>>  git format-patch -1 d1a2930d8a99
>> 
>> Now, how to determine the commit order of these two patch in repository?
> 
> Do you mean something like:
> 
> $ git merge-base --is-ancestor cf1c9ccba730 d1a2930d8a99
> 
> and:
> 
> $ git merge-base --is-ancestor d1a2930d8a99 cf1c9ccba730
> 
Yep, that's what I want. Thanks!
> ?

