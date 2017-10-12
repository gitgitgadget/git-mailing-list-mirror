Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 346C020467
	for <e@80x24.org>; Thu, 12 Oct 2017 12:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbdJLMVT (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 08:21:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56251 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751576AbdJLMVS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 08:21:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9C5B98EC0;
        Thu, 12 Oct 2017 08:21:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=anKhpWDWQ9Xw7SS9zjoITztS9I8=; b=sHXG6J
        DR54IGU3RuITDvXaiUyYnlQ/CDNqjycdPg86NoDB2DnXUxvgzhT1XuOlPatWZffU
        FFa/L1DYqmAItkkav2v6HsuYjc88EFsp6fcDQx6zzXgXKk+oeS9imqQOvZPF9+zI
        4PFjKbsB5dSakxeC+FYsT9mLWdU4E+w5piWvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xY1rCChGiJk/PZdgiOy5/5jhvi3QOJFU
        R1uqUtt1pbZ7pryRj1p8yRx+c7De/GpkldspwIaO1Nx/ATVGApYAW40Hj3qntVUQ
        iFrs8IPjXyJ1mVICdWVkt3GrB6REmvFrTvfaQLf0+T/AEuKd/hpwu7qbu9B7o9Uq
        w9Hd69s7eiI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E20B698EBF;
        Thu, 12 Oct 2017 08:21:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54D1B98EBC;
        Thu, 12 Oct 2017 08:21:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v5 0/4] Improve abbreviation disambiguation
References: <61168095-d392-39d2-ba65-823525239b5c@gmail.com>
        <20171012120220.226427-1-dstolee@microsoft.com>
        <3261c086-01d9-42aa-5e82-002a4da37275@gmail.com>
Date:   Thu, 12 Oct 2017 21:21:15 +0900
In-Reply-To: <3261c086-01d9-42aa-5e82-002a4da37275@gmail.com> (Derrick
        Stolee's message of "Thu, 12 Oct 2017 08:04:28 -0400")
Message-ID: <xmqqr2u8y2tg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D83F275E-AF47-11E7-BE3A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 10/12/2017 8:02 AM, Derrick Stolee wrote:
>> Changes since previous version:
>>
>> * Make 'pos' unsigned in get_hex_char_from_oid()
>>
>> * Check response from open_pack_index()
>>
>> * Small typos in commit messages
>>
>> Thanks,
>>   Stolee
>>
> I forgot to mention that I rebased on master this morning to be sure
> this doesn't conflict with the binary-search patch that was queued
> this week.

Thanks for being extra careful.  

I've re-applied minor style fix s/(void\*)/(void \*)/ to 2/4 and 4/4
but other than that, the difference between this round and what has
been queued looked all reasonable.

Will replace.

