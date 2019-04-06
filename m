Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8AF20248
	for <e@80x24.org>; Sat,  6 Apr 2019 20:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDFU1n (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 16:27:43 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:42500 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbfDFU1n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 16:27:43 -0400
Received: from [192.168.1.12] ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id CrufhvZcBnuQZCrufhhfMR; Sat, 06 Apr 2019 21:27:41 +0100
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=jbzaY6LxoT-qgLRWNyMA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22
Subject: Re: git glossary --help ?
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
References: <05e6a0ad-36ea-e594-f253-ded3e5392375@iee.org>
 <87v9zr57kl.fsf@igel.home>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <0bbe60e7-15ce-775c-bfcb-d2c660361e80@iee.org>
Date:   Sat, 6 Apr 2019 21:27:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87v9zr57kl.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfM2DdvBmO4uDqF2AutUicBM+JiE+54ZGPJVN/p7NVsua6tClEY/MKadB9RDaJ6TygShk8y+peO2ZPgh+JSP5bGdlEoy0ViX9wm4Wit9faFjQk9vwfdbz
 9QH8iUjgiy/H5aQPKgPq99UdeE6oHNQsrD767Xt8dfiJ7Sg3/zy4BjKDucAHHnEIOr+42cW0+/Wchba4YJ9QD8sReyuQiSaQ67rIboUcJQsI5YAyOPn9dNlM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andreas,

On 06/04/2019 19:09, Andreas Schwab wrote:
> On Apr 06 2019, Philip Oakley <philipoakley@iee.org> wrote:
>
>> Following the discussions about the tag peeling issue, I thought to have a
>> look at what the git glossary says.
>>
>> I had it in my head that when the git guides were linked to the help
>> system, that the --help option provided a short circuit direct to help
>> item. However this did not happen.
> $ git help glossary
>
> Andreas.
>
Thanks. I was aware of that form, but as I remember it, as part of the 
'git' command processing, there was an immediate shortcut if --help was 
an option, that would essentially re-write the cli as 'git help 
command', such that 'git foo --help' would become 'git help foo' and the 
help system would then provide the right long form help, including the 
guides and <concepts> docs (excepting the user-manual, which is 
unfortunate, but ..)

My question was whether the older systems did that re-write as 
described, should someone have one immediately to hand.
Philip
