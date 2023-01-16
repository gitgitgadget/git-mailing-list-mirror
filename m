Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411CAC46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 17:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjAPROf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjAPRNM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 12:13:12 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054254B757
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 08:53:43 -0800 (PST)
Received: from 88-110-98-79.dynamic.dsl.as9105.com ([88.110.98.79] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pHSju-0001FY-6j;
        Mon, 16 Jan 2023 16:53:42 +0000
Message-ID: <b2eca967-4c52-3f8d-f3fe-b1ed41b06280@iee.email>
Date:   Mon, 16 Jan 2023 16:53:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/6] cache API: always have a "istate->repo"
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
 <xmqqtu0u2q9u.fsf@gitster.g> <230116.86a62izjg5.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <230116.86a62izjg5.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/01/2023 13:38, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Jan 13 2023, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> The "struct index_state" contains a "repo" member, which should be a
>>> pointer to the repository for that index, but which due to us
>>> constructing such structs on an ad-hoc basis in various places wasn't
>>> always available.
>> I'd exclude 6/6 for now, as it seems to depend on some changes only
>> in 'next'.  Feel free to resend only that step with reduced scope so
>> that it applies to 'master', and send in incremental updates when
>> each of these topics that are only in 'next' graduates.
> Okey, the 6/6 requires ds/omit-trailing-hash-in-index. As both it and
> the 1-5/6 of this are in "next" now I think it's best that I just submit
> the 6/6 stand-alone after both of those have graduated.
>
micro-nit: The commit message of 5/6 starts "As we'll see in a
subsequent commit..", which may need a slight tweak if 6/6 becomes 'far
away' in the commit tree.

--
Philip
