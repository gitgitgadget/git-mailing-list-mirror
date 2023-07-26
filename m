Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADD0C001B0
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 16:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjGZQgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 12:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGZQgo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 12:36:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6E626AE
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 09:36:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7464B2625A;
        Wed, 26 Jul 2023 12:36:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W6RUy++c2EGoHWCD80BuObEKzWDZvw7OktybBN
        w9fT4=; b=dC7w1OxQaL4fp/hzmD3AMVdgPq3hCvpNe3DpcnokgtkVEzruTHwp+v
        OuRHfO0N17hqDxeySzQDlm7k4mY1oCavZrivIGTGgPsjzXUSWwHhWdgxGhF+Jomm
        +B/ZmAdV8adOmFY2IuN19f8sEWGxUud69aMe296dGH07Qg6cFLsb4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D30026259;
        Wed, 26 Jul 2023 12:36:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D983726255;
        Wed, 26 Jul 2023 12:36:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH v3 6/5] SubmittingPatches: choice of base for fixing an
 older maintenance track
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
        <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
        <xmqqh6prfe0u.fsf_-_@gitster.g>
        <CAPig+cSheNKUg7=v4i6Kr6zs8Jftooq4c_4gkGUcpMRDia-0oQ@mail.gmail.com>
Date:   Wed, 26 Jul 2023 09:36:38 -0700
In-Reply-To: <CAPig+cSheNKUg7=v4i6Kr6zs8Jftooq4c_4gkGUcpMRDia-0oQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 26 Jul 2023 01:40:43 -0400")
Message-ID: <xmqqlef2eijt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98A3BD18-2BD2-11EE-BD58-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +  `master` but were not available in the released version). If the bug
>> +  exists in an older version (e.g., commit `X` introduced the bug, and
>> +  `git describe --containx X` says `v2.30.0-rc2-gXXXXXX` has it), then
>
> s/containx/contains/

Thanks.
