Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B868C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6976134F
	for <git@archiver.kernel.org>; Mon,  3 May 2021 05:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhECFWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 01:22:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58105 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhECFWi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 01:22:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FF51C3D2C;
        Mon,  3 May 2021 01:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QxcA/CWTiFHmBnQRuFaARm+UR11DptJ6kcxZB7
        5EfsQ=; b=DckFNJb72ArUdp28vgo2bpS9iGGdFlO5l+CVPnBNoaHfPexbpObzxk
        oUZT0w7026W6JSsLEbF3LoxiGITzfsIThQbSnJdtFl5s8dy6isV2NbLIK5BnoXy2
        +hZdxaPTecBbNgWEzJLEwFKNxr9BQVWyrffVEyF00DDWMgxZ95wgk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86C23C3D2B;
        Mon,  3 May 2021 01:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15020C3D2A;
        Mon,  3 May 2021 01:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: explicitly allow "local" for test
 scripts
References: <xmqqfsz4a23x.fsf@gitster.g>
        <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
Date:   Mon, 03 May 2021 14:21:44 +0900
In-Reply-To: <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 3 May 2021 00:21:28 -0400")
Message-ID: <xmqqsg348k9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 739A88D8-ABCF-11EB-B43C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Double negative whammy. Should be either:
>
>     use a platform with a shell that lacks support
>
> or:
>
>     use a platform without a shell supporting "local"
>
> Or I'm confused and misunderstanding what was written.

No, I just wasn't paying much attention to what I was writing X-<.
Thanks for spotting.
