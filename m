Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43901F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfKLKp5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:45:57 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:16080 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfKLKp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:45:57 -0500
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iUTgJ-0004xF-Br; Tue, 12 Nov 2019 10:45:56 +0000
Subject: Re: [PATCH v2 2/2] git-gui: revert untracked files by deleting them
To:     Jonathan Gilbert <logic@deltaq.org>
Cc:     "Pratyush Yadav me-at-yadavpratyush.com |GitHub Public/Example Allow|" 
        <172q77k4bxwj0zt@sneakemail.com>,
        Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
 <pull.436.v2.git.1573110335.gitgitgadget@gmail.com>
 <9469beb59937f87647190cf7f56544b8c27e20b6.1573110335.git.gitgitgadget@gmail.com>
 <20191111192526.crllpe3phitneu3p@yadavpratyush.com>
 <CAPSOpYv0NNihiWF2LL=czoP7N2CGNSkB8SBNTZ65iOZVOBPqbA@mail.gmail.com>
 <a1dd45d5-8dac-e86f-c964-957ff0b8dfb8@iee.email>
 <CAPSOpYsbBX3d_oWJHtKHD7b0cXcELF=t-zYNEVpU3sf8qzD4Ew@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <11812626-07f7-5610-cd13-ce4bdda4f674@iee.email>
Date:   Tue, 12 Nov 2019 10:45:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAPSOpYsbBX3d_oWJHtKHD7b0cXcELF=t-zYNEVpU3sf8qzD4Ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11/2019 04:49, Jonathan Gilbert wrote:
> On Mon, Nov 11, 2019 at 4:59 PM Philip Oakley <philipoakley@iee.email> wrote:
>> sounds like "Currying" a function but with the parameters taken in any
>> order, though, in a sense, perhaps not generating intermediate functions...
> It's like currying if you could pass g(x) = f(x, y) to one block of
> code and h(y) = f(x, y) to another block of code, so that each of g
> and h are each like curried versions of f that "bake in" one of the
> arguments, without having to know which one will get called first. :-)
>
> Jonathan Gilbert
So that would be called "Chording"...
(Is there a 'proper' technical term for that approach?)
P.
