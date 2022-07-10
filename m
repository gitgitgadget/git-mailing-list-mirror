Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9213C433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 15:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiGJPUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 11:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGJPUi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 11:20:38 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480FDBF62
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 08:20:35 -0700 (PDT)
Received: from host-78-147-178-211.as13285.net ([78.147.178.211] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oAYjZ-000AKm-Bj;
        Sun, 10 Jul 2022 16:20:33 +0100
Message-ID: <60285079-cb1d-56bf-b36b-e32b3f23158c@iee.email>
Date:   Sun, 10 Jul 2022 16:20:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] Add some Glossary terms, and extra renormalize
 information.
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <xmqqa69it1g9.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqa69it1g9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 09/07/2022 22:34, Junio C Hamano wrote:
>> The first patch [1/4] is to show OBD as an abbreviation to avoid a UNA [0]
> Avoiding unnecessary TLA is even better than avoiding.  As I didn't
> see in the other three patches that we need to use the OBD acronym,
> perhaps we can omit this step?
>
This came from seeing `ODB` in a couple of tech docs (commit-graph and
parallel-checkout) and an 'odb' option in pack-redundant, which I should
have noted in the commit message.

I'll update the commit message to clarify that we are using that TLA,
though we aren't always consistent in our distinctions between concepts
and implementation in many places (e.g. Object Store vs Repository;
Staging area..; etc.)

TLAs, UNAs, etc. have been a bug-bear of mine from doing large
engineering collaborations.

--
Philip

(for completeness;-)
ODB Object Data Base.
TLA Three Letter Abbreviation.
UNA Un-Named Abbreviation.
