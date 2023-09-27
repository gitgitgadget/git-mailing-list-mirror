Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20A6E7F14F
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 21:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjI0Vbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjI0Vbq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 17:31:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890D7D6
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 14:31:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1394519CEF8;
        Wed, 27 Sep 2023 17:31:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=H4eW4/9TEGJO3DryrfSJkHxHhfTzC3rYLLLKsu
        2IF6g=; b=MhlTUpVRWS8JOuhXW+pAa8igMAvMVMy+h2DQuzMWVwWQCLCzpcn5IQ
        0Vmf5hSakjYAsIfQHT225sA5GzFcNFgBiVkLGQsUxkTMOnEYs08xuHER+otqmsjz
        AWRj5eYA98Rewz1znwzURHKFE98L8W2/ORG3a9y8+A5qtGF+04xqg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B88D19CEF5;
        Wed, 27 Sep 2023 17:31:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6EA9619CEF4;
        Wed, 27 Sep 2023 17:31:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 00/30] Initial support for multiple hash functions
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 27 Sep 2023 14:49:57 -0500")
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
Date:   Wed, 27 Sep 2023 14:31:38 -0700
Message-ID: <xmqqjzsbl2v9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E6CF88C-5D7D-11EE-972C-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> I have been going over and over this patchset trying to figure
> out if it is ready to be merged.  I don't know of any deficiencies
> so it is at a point it could benefit from a set of eyes that
> are not mine.
>
> I had planned to wait a little bit longer but there are some on-going
> conversations that could benefit from people seeing what it means for a
> repository to support two hash functions at the same time.

Thanks.  On top of what commit are these patches expected to be applied?
