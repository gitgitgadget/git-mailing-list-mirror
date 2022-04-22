Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B64C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 06:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351970AbiDVGMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 02:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiDVGML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 02:12:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B3050463
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 23:09:19 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A56E019AF9B;
        Fri, 22 Apr 2022 02:09:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kpKwFi2rtBqfdDU8ydUbVLFzgeQhgyGuHHYM4Q
        DtRtU=; b=kbQp0q/eKvjEkPD9O8ms2arZWwmSG63wj/us2s1iaXlPQkaL/wqoFf
        uVy9SpLc4H6CDSW9uK/hdfEjz5K+iFqYhxlT0tcTcZxcppBolobks9g8V7QEWTay
        yi58nYW/QwF5rW+iNQu9qMvS5+plhab3wfDy4y39nK4VsHTMpMzNo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E07819AF9A;
        Fri, 22 Apr 2022 02:09:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2817C19AF99;
        Fri, 22 Apr 2022 02:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 4/9] git-sparse-checkout.txt: update docs for
 deprecation of 'init'
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <eb3b318b39ec3eed754eab7d2c9d20198117545b.1647054681.git.gitgitgadget@gmail.com>
        <xmqqwngwp87k.fsf@gitster.g>
        <CABPp-BEt0CzP7B_EvYXOhQoKqk+h=9OwXDmUDCYfB3fnHxv-uA@mail.gmail.com>
Date:   Thu, 21 Apr 2022 23:09:13 -0700
In-Reply-To: <CABPp-BEt0CzP7B_EvYXOhQoKqk+h=9OwXDmUDCYfB3fnHxv-uA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 21 Apr 2022 19:29:57 -0700")
Message-ID: <xmqqh76ld4za.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC9D40A8-C202-11EC-8B0F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> less than ideal.  As we present "core" first (because it is the
>> default), we should present "core" by itself, without requiring to
>> know what the other thing is.
>
> By '"core" section' do you mean the "cone pattern set" section?

s/core/cone mode/g, I guess (because it is so long ago I do not
offhand recall what I had in mind exactly back when I wrote it).
