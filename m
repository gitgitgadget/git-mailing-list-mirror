Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F759EE0200
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 18:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjIMSOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 14:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMSOe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 14:14:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B8019B6
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 11:14:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2E381A60CC;
        Wed, 13 Sep 2023 14:14:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=WQLsaSRHuXwR/vEmwMPh4g/8dWnUYF17mcz5TO
        scYig=; b=ZU7slh3GTLcGTlmkG0Lep44rxSE0jK2lKibBiDEe/FTIIAweTGDqWw
        PYMHUR4AzL0P1NVKozmqQLYnDr0sF6R15MKUgZEVemfHqm5c7Ar1fGNPS7qfPG3H
        8+pWq3YkVUgCCw14uRkdACBtIIsb4YUD3hS/pryR913VujYD9CqY8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA70F1A60CB;
        Wed, 13 Sep 2023 14:14:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BCA61A60CA;
        Wed, 13 Sep 2023 14:14:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, linusa@google.com, calvinwan@google.com,
        phillip.wood123@gmail.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v7 0/3] Add unit test framework and project plan
In-Reply-To: <ZOe5gtYeQaKqOJVm@google.com> (Josh Steadmon's message of "Thu,
        24 Aug 2023 13:11:46 -0700")
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
        <cover.1692297001.git.steadmon@google.com>
        <ZOe5gtYeQaKqOJVm@google.com>
Date:   Wed, 13 Sep 2023 11:14:25 -0700
Message-ID: <xmqqttrykkji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60193116-5261-11EE-8115-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> BTW, I'm going to be AFK for a couple weeks, so it will be a while
> before I'm able to address feedback on this series. Thanks in advance.

OK.  Enjoy your time off.
