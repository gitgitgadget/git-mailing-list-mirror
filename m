Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA30C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 19:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKCTvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 15:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiKCTvA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 15:51:00 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D81FFA7
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 12:50:57 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oqgEq-0004sc-AA;
        Thu, 03 Nov 2022 19:50:56 +0000
Message-ID: <7d1a9294-2925-5bfc-31b2-9bfbdaac3e35@iee.email>
Date:   Thu, 3 Nov 2022 19:50:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC/PoC 5/5] docbundle: provide the git-log History
 Simplification example
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <20221102224843.2104-1-philipoakley@iee.email>
 <20221102224843.2104-6-philipoakley@iee.email>
 <221103.86r0yk1jld.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <221103.86r0yk1jld.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/11/2022 09:17, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Nov 02 2022, Philip Oakley wrote:
>
>> +note () {
>> +	git tag "$1"
>> +}
> Aren't you just...
>
>> +test_expect_success setup '
>> +	# get the structure set out, then the file contents
>> +	echo "asdf" >foo &&
>> +	echo "quux" >quux &&
>> +	git add foo quux &&
>> +	test_tick && git commit -m "I: Initial commit" &&
>> +	note I &&
> ...re-inventing "test_commit" here (including the "echo")?

Probably.

It was a bit of 'monkey coding' of an earlier test without any real
study.. As you can probably tell it is just getting the spirit of the
history simplification setup in place..

