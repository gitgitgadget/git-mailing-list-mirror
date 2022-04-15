Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15B7C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 22:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355209AbiDOWWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 18:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiDOWWt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 18:22:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E45424A8
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 15:20:20 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2739318BB18;
        Fri, 15 Apr 2022 18:20:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yY0pzYVEKBkV4Ckiju78+rUmpL2UXbN60yDouC
        111lA=; b=wn3YWASu1ztRYRM0rXuK43W5WUc1MwP83JiN4/kN6OFsPHlStFezgG
        xzMzntBhJes7so3rYf9puXPKa1WFsJFEVfccFiBpmrlQDs85EISdXbd7ZaaORPWJ
        CD1cls0YDRbsoH8uo4HKIRVWJ6qztSuto6lAl5sBchiRsKffboUJ0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FFE218BB17;
        Fri, 15 Apr 2022 18:20:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6BD0B18BB16;
        Fri, 15 Apr 2022 18:20:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] ci: lock "pedantic" job into fedora 35 and other cleanup
References: <20220415123922.30926-1-carenas@gmail.com>
        <xmqqwnfqci6f.fsf@gitster.g>
        <CAPUEspgsfn71JEM5mdG2u9vO6YgEhvdZqtixW9kVyOetqz8RWQ@mail.gmail.com>
Date:   Fri, 15 Apr 2022 15:20:15 -0700
In-Reply-To: <CAPUEspgsfn71JEM5mdG2u9vO6YgEhvdZqtixW9kVyOetqz8RWQ@mail.gmail.com>
        (Carlo Arenas's message of "Fri, 15 Apr 2022 14:03:16 -0700")
Message-ID: <xmqqee1yat0g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A2678E4-BD0A-11EC-8AB5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> Would that be reasonable, eventhough it is so late in the RC cycle?

I do not think we will take anything like to the release next week;
it is way way too late for that.  But if it can preview sooner in
'seen' to help review by others, that would still be good thing to
aim for, I would think.

Thanks.
