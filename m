Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D749FE82CC0
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 21:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjI0VjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0VjH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 17:39:07 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E111D
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 14:39:06 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECCBF19D0F1;
        Wed, 27 Sep 2023 17:39:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=x4NC5e9XyZHsbHx5h7eCmfuLk5ZvdYi8s1IxBU
        BUiWc=; b=Nj6m78Qijl0LaM84PSI0Ucep9rX3H654XthAYpSawS/BrCDzR1nQVU
        6qhyEuwtTq2Lfxx7FFby2TSmtYrTYgbYPZjA2Bi8/QZCtDYRhwNIlveR1UQLp5l8
        +6NJ3oFAYEjklS3nGrjcd9bAEdzjuxaYxfZcFMgNJK5rTGX+soVVc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6FFC19D0F0;
        Wed, 27 Sep 2023 17:39:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18C5319D0EE;
        Wed, 27 Sep 2023 17:39:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 21/30] repository: Implement extensions.compatObjectFormat
In-Reply-To: <20230927195537.1682-21-ebiederm@gmail.com> (Eric W. Biederman's
        message of "Wed, 27 Sep 2023 14:55:28 -0500")
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
        <20230927195537.1682-21-ebiederm@gmail.com>
Date:   Wed, 27 Sep 2023 14:39:01 -0700
Message-ID: <xmqqfs2zl2iy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46E0B872-5D7E-11EE-B4C8-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> diff --git a/setup.c b/setup.c
> index deb5a33fe9e1..87b40472dbc5 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -598,6 +598,25 @@ static enum extension_result handle_extension(const char *var,
>  		}

This line in the pre-context needed fuzzing, but otherwise the
series applied cleanly on top of v2.42.0.

> Subject: Re: [PATCH 21/30] repository: Implement extensions.compatObjectFormat

"Implement" -> "implement" (many other patches share the same
problem, none of which I fixed while queueing).

