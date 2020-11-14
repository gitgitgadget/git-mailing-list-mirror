Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E35C5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 19:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D6722265
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 19:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgKNTbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 14:31:42 -0500
Received: from 1.mo51.mail-out.ovh.net ([178.32.121.110]:58146 "EHLO
        1.mo51.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgKNTbl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 14:31:41 -0500
X-Greylist: delayed 8399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Nov 2020 14:31:41 EST
Received: from mxplan1.mail.ovh.net (unknown [10.108.4.102])
        by mo51.mail-out.ovh.net (Postfix) with ESMTPS id 5FD70234D64;
        Sat, 14 Nov 2020 16:55:25 +0100 (CET)
Received: from greg0ire.fr (37.59.142.105) by DAG4EX2.mxp1.local (172.16.2.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Sat, 14 Nov
 2020 16:55:24 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-105G0067aade327-dacd-4b50-a17f-0d4f8f6c885c,
                    4C58B1D2F0141825396C827F322D1A475CF1342F) smtp.auth=postmaster@greg0ire.fr
Subject: Re: phpdoc diff in git -L is not the correct one
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
References: <348a2a4a-dfdb-190b-edac-01e9ad4c2d4d@greg0ire.fr>
 <CAN0heSrU5zzgR_FDZcEopPP2EmSQnraZXO4v8Smx8=fWcXa0uQ@mail.gmail.com>
From:   =?UTF-8?Q?Gr=c3=a9goire_PARIS?= <postmaster@greg0ire.fr>
Message-ID: <e666e806-d8c6-0b8d-c583-e4a8ee0ee806@greg0ire.fr>
Date:   Sat, 14 Nov 2020 16:55:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAN0heSrU5zzgR_FDZcEopPP2EmSQnraZXO4v8Smx8=fWcXa0uQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: CAS3.mxp1.local (172.16.1.3) To DAG4EX2.mxp1.local
 (172.16.2.8)
X-Ovh-Tracer-GUID: 6c028f97-4827-4bca-82e7-9dd3758d013f
X-Ovh-Tracer-Id: 18297280862585327002
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedruddvjedgkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpefirhorghhoihhrvggprfettffkufcuoehpohhsthhmrghsthgvrhesghhrvghgtdhirhgvrdhfrheqnecuggftrfgrthhtvghrnhepieeuieelheelhfdujeetteeuieejkeeivedtveffveevveegfeduleffhfehkedtnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnuddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehpohhsthhmrghsthgvrhesghhrvghgtdhirhgvrdhfrhdprhgtphhtthhopehmrghrthhinhdrrghgrhgvnhesghhmrghilhdrtghomh
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

thanks for your answer!

> In the end I think your best option right now is to give explicit line
> numbers for <end> and <start>.
That is indeed what I currently do, I plugged that to vim's visual 
selection with

   vnoremap <leader>l :<c-u>exe '!git log -L' 
line("'<").','.line("'>").':'.expand('%')<CR>

and it works great!

I was wondering if that was maybe an issue with the PHP regex, but with your
explanation I understand a bit more what the issue might be: The man 
page you
are quoting seems to say that the regex can only work on a single line as
opposed to a code block (for probably very good reasons), which means 
there is
no hope to include the phpdoc in the regex, or to fix this issue I suppose.

I also suppose the issue is the same for any other language that has 
documentation above function declarations.

Thanks for taking the time to answer my question.

--

greg0ire

