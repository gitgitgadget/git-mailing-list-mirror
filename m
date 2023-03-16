Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A7DC6FD19
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 14:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjCPOTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 10:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCPOSp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 10:18:45 -0400
X-Greylist: delayed 423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 07:18:30 PDT
Received: from mail32c60.megamailservers.eu (mail32c60.megamailservers.eu [91.136.22.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F302D7C23
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 07:18:30 -0700 (PDT)
X-Authenticated-User: joak-pet@online.no
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=online.no; s=hmail;
        t=1678975878; bh=mzXoR3sR1XW7GZcugB1OZH7caWgDT9w6Qa5CTsSCLTY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dkn2pvLQJrwjOGJihsQl1TQjdCpLwtB2nO/2KnQqZRdAWZwc0+4T2TtOEnmOw6WGu
         G42/UFTbNMZaSVtOzjh6OkrZX22lQ/+IZJWW/1Axv+nQerec6GfS75jlir5UoRQ0zk
         jIfdh3PEpb/aWPAoZOrt3hPI29PSN4YtP9PbB6HLGtIRmF4q7Ir/MysJW+1Y2BTPyc
         3++po4ayZhyvbJwzkhgzue6uTC3rGBctIdPMDq3NawHG6vXAyadTnkcOGKBtFQj0Bd
         l/d/5OUS6XELrknqD0IFy+wbbGTeBSbel/GR75x2dnz1sO3Euu1T1NGxLSoattLE51
         zqtJSAGnJCL0A==
Feedback-ID: joak-pet@online
Received: from [192.168.0.111] ([188.113.111.111])
        (authenticated bits=0)
        by mail32c60.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 32GEB6j9084400
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 16 Mar 2023 14:11:18 +0000
Message-ID: <9e317aa7-0037-7076-e159-3a70c581ebc1@online.no>
Date:   Thu, 16 Mar 2023 15:11:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH try2] completion: prompt: use generic colors
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>
References: <20230228145934.4182166-1-felipe.contreras@gmail.com>
 <xmqq4jr4nu3u.fsf@gitster.g>
 <CAMP44s23cvp-YWDN7vzsKQCcWoc43PgURq+J6pwtx0rxOpZLBg@mail.gmail.com>
Content-Language: en-GB
From:   Joakim Petersen <joak-pet@online.no>
In-Reply-To: <CAMP44s23cvp-YWDN7vzsKQCcWoc43PgURq+J6pwtx0rxOpZLBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-VADE-SPAMSTATE: clean
X-VADE-SPAMSCORE: -100
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffquffvqffrkfetpdfqfgfvpdfgpfggqdeviedtnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheplfhorghkihhmucfrvghtvghrshgvnhcuoehjohgrkhdqphgvthesohhnlhhinhgvrdhnoheqnecuggftrfgrthhtvghrnhepgeekjeejjefhueeiteefteejkeekieefgedthfelieeifeevveelgfevleegvdegnecukfhppedukeekrdduudefrdduuddurdduuddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudekkedruddufedrudduuddrudduuddphhgvlhhopegludelvddrudeikedrtddrudduudgnpdhmrghilhhfrhhomhepjhhorghkqdhpvghtsehonhhlihhnvgdrnhhopdhnsggprhgtphhtthhopeegpdhrtghpthhtohepfhgvlhhiphgvrdgtohhnthhrvghrrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhushhtihhnrhguohhnnhgvlhhlhiesghhmrghilhdrtghomh
X-Origin-Country: NO
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03/2023 21:27, Felipe Contreras wrote:
>>> We don't need bash to do this conversion, we can use \001 \002
>>> ourselves, and then the prompt command mode is not necessary to display
>>> colors.
> 
>> Comments from those who use colored prompt and who are familiar with
>> the mechansim used to implement this?  As I do not use the feature
>> at all and haven't been following it, seeing independent support
>> would help the topic.
> 
> At least in try1 Justin Donnelly reported success [1].

I've played around a bit with this patch, and it seems to work as 
advertised.

