Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE7CC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1052F61205
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhFRNLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:11:34 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:13962 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230430AbhFRNLd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 09:11:33 -0400
Received: from host-78-147-180-220.as13285.net ([78.147.180.220] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1luEFP-00071f-AY; Fri, 18 Jun 2021 14:09:23 +0100
Subject: Re: [PATCH v2 0/3] Make CMake work out of the box
To:     Junio C Hamano <gitster@pobox.com>,
        Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
 <pull.970.v2.git.1622980974.gitgitgadget@gmail.com>
 <xmqqpmwywl2z.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <232e8d37-dda9-d315-bfb9-4acd19ff1a41@iee.email>
Date:   Fri, 18 Jun 2021 14:09:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqpmwywl2z.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/06/2021 01:54, Junio C Hamano wrote:
> "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This pull request comes from our discussion here[1], and I think these
>> patches provide a good compromise around the concerns discussed there
>>
>> 1:
>> https://lore.kernel.org/git/CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKMRgi_oZAWw@mail.gmail.com/
>>
>> CCing the people involved in the original discussion. cc: Philip Oakley
>> philipoakley@iee.email cc: Sibi Siddharthan
>> sibisiddharthan.github@gmail.com, cc: Johannes Schindelin
>> johannes.schindelin@gmx.de, cc: Danh Doan congdanhqx@gmail.com
>>
>> Matthew Rogers (3):
>>   cmake: add knob to disable vcpkg
>>   cmake: create compile_commands.json by default
>>   cmake: add warning for ignored MSGFMT_EXE
> I am neither cmake nor windows person, so I'll queue this as-is and
> wait for the stakeholders to chime in.
>
> I did wonder if we want this to be applicable to the maintenance
> track for 2.31, though.  There is a textual conflict with the
> addition of SIMPLE_IPC that happened during 2.32 cycle, which is
> easily resolvable.
>
> I am tempted to queue a version of these three patches rebased on to
> 'maint' after making sure that the result of merging that into
> 'master' is byte-for-byte identical to applying these three patches
> directly on to 'master'.

Sorry for the delay - I've been off-line and I'm only now catching up.

Could we confirm that the CI actually tests the update. IIRC the yml
setup preloaded the vcpkg artefacts that this change looks to make work
'out of the box'.

Philip
