Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C13EE4993
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 16:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbjHUQVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 12:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjHUQVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 12:21:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF266195
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 09:20:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E89FD1BA81D;
        Mon, 21 Aug 2023 12:19:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=lrBBuAH+VictWxE1m0R93wkEFw0H4nCrdOcB9zYA28E=; b=SLYg
        v7tqeS8gsytS593GKMii/+nSgm9RiSkVJhHsDpz/D0TyfS7otBpigDcv57b2Vavp
        XpGTQYmQqas0rMDH85F1Qlu1t91nXyWfVG9ONl4P0C3Bn6Br+QBsd/EkWEDWuvrI
        CSU00+nrq8qzq8k1cbD+ip8uJPA+hx7ZsyPZkbw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E19931BA81C;
        Mon, 21 Aug 2023 12:19:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36A4C1BA81B;
        Mon, 21 Aug 2023 12:19:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Osipov, Michael (IN IT IN)" <michael.osipov@siemens.com>
Cc:     git@vger.kernel.org
Subject: Re: [REGRESSION] cache.h in 2.41.0 uses undefined macros DT_*
References: <627378df-4655-4a8a-abcb-c15ab6602101@siemens.com>
Date:   Mon, 21 Aug 2023 09:19:58 -0700
Message-ID: <xmqqmsykqsep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92EF5186-403E-11EE-9452-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think [*1*] on June 6th fixed it, and the fix has been in 'master'
for the last 2 months, and has been in the release candidate releases
for 2.42 that have been issued in the past weeks.

Thanks.

[Reference]

*1* https://lore.kernel.org/git/20230606205935.3183276-1-asedeno@google.com
