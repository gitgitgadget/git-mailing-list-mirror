Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7F3CD612F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378136AbjJIVHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjJIVHi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:07:38 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD50A3
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:07:37 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67F341BBE76;
        Mon,  9 Oct 2023 17:07:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Z7m+FWroq4cLojlPz+MDKsg4mKrrNp2mRDYJ81
        DzEXY=; b=WPu4wOGD3nd3IPLcAuts8K+YPJ3og+eYLSs2tQIBeaGle9zR3La7KD
        NMFDLhuFcOawwYKpIPZddxcNTTKU7c2BOMXUXbHXsVtjtlgEkRFzmo0IrpotkaF9
        Gnu7Bo1HABh70Ku2+TkERNJ6bPHOOPeKjbgN5wjOQowi7PLGt4ePA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E72A1BBE75;
        Mon,  9 Oct 2023 17:07:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA77D1BBE74;
        Mon,  9 Oct 2023 17:07:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #03; Fri, 6)
In-Reply-To: <ZSRC5IaKoXPpTFnq@nand.local> (Taylor Blau's message of "Mon, 9
        Oct 2023 14:13:56 -0400")
References: <xmqqh6n24zf1.fsf@gitster.g> <ZSQnVnK0k3bdk5zX@nand.local>
        <xmqqfs2j1xdo.fsf@gitster.g> <ZSRC5IaKoXPpTFnq@nand.local>
Date:   Mon, 09 Oct 2023 14:07:34 -0700
Message-ID: <xmqqedi3y06h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEEA435A-66E7-11EE-8144-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> > Thanks. On a semi-related note, did you want to pick up my patch in
>> >
>> >   https://lore.kernel.org/git/035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com/
>> >
>> > ? That should address a performance bug that occurs when a repository
>> > (incorrectly) chooses a cruft pack as its preferred pack source when
>> > writing a MIDX bitmap, significantly impeding the pack-reuse mechanism.
>>
>> Isn't that in the above list already as b3ca6df3b9^2?
>
> Oops, duh. I hadn't expected you to group that patch in with the rest of
> tb/repack-max-cruft-size.

Heh, as you said, isn't it at least semi-related ;-)?
