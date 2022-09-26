Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25984C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 19:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiIZTKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIZTKp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 15:10:45 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB6765658
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:10:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EF571C6849;
        Mon, 26 Sep 2022 15:10:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=73ENk13mHK8e/d69C6PsX22fCxfi/PE++yT9go
        4QV+A=; b=kh3J8Egv6AkmqYef5e/2OcJMdB0FsOhsy9459oH0xi9H+/myKnuLqd
        JP040C2dIYDd+2TQm1U9rjNFyR+u45E7Od/zffZEGjcP1yLRCe6p1eTLh88GGM6H
        K8rJkDz8KlZyJSQDF+p8v6I63bEWOkpb7Oyp/pLLnoAO1TKdiUi90=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 870591C6848;
        Mon, 26 Sep 2022 15:10:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 966F91C6847;
        Mon, 26 Sep 2022 15:10:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v2 0/9] Bundle URIs III: Parse and download from bundle
 lists
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
        <f61e5940-41d0-39dd-39fa-048acccfe221@github.com>
Date:   Mon, 26 Sep 2022 12:10:38 -0700
In-Reply-To: <f61e5940-41d0-39dd-39fa-048acccfe221@github.com> (Derrick
        Stolee's message of "Mon, 26 Sep 2022 09:19:57 -0400")
Message-ID: <xmqqk05qne8h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8C8162E-3DCE-11ED-81E1-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> If some of the reviewers from v1 could check that I responded to their
> comments, then that would be a big help to getting this series moving
> again.

Thanks for a ping.  Also, if reviewers who missed v1 can take a look
and give fresh insights, that would also help polishing the series
further.

