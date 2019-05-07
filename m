Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99241F45F
	for <e@80x24.org>; Tue,  7 May 2019 01:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfEGBST (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 21:18:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60612 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfEGBST (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 21:18:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6925D610D2;
        Mon,  6 May 2019 21:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+TzpEg2zE4PiLv61FuarRzs+xOU=; b=YcSa/K
        J+qqSz7ZYglaD9vhsjUCJeVhztpIdy0+IHirWZ05gnumU0GdCWcG2ORBF6ldGNAy
        w9cxPX0tU2eARn/77JVchfUy08T0j0jr+5uJqjFaqrMHfyidlgUe5xGYAm779Y0b
        mR+PX3lkV40UOx6OcU4ISSE7Wi7hEn/S8CuM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uzz5rFBv/p9OyKIptA9mZsxmVj/Uvp66
        T8LaB8RzLxL0eGUt7sfgDq4kjb6xYPdJxCgKTCjpvvb659PzqqTVVnAdspyVoXCI
        ayQcFriWJxLsL3OPT7mBRLztj8e70bL0+tW+/Mqe7ooZcykc2BWAm56Ylz861DT3
        7KYvCwUUPnk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6160D610D1;
        Mon,  6 May 2019 21:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8FD57610D0;
        Mon,  6 May 2019 21:18:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com
Subject: Re: [PATCH v5 00/11] trace2: load trace2 settings from system config
References: <pull.169.v4.git.gitgitgadget@gmail.com>
        <pull.169.v5.git.gitgitgadget@gmail.com>
        <da481a55-a363-9eb9-6cde-59468f18947d@jeffhostetler.com>
Date:   Tue, 07 May 2019 10:18:10 +0900
In-Reply-To: <da481a55-a363-9eb9-6cde-59468f18947d@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 29 Apr 2019 16:21:59 -0400")
Message-ID: <xmqqftprrrjh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB906B24-7065-11E9-9F46-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I forgot to update the cover letter for V5.
> V5 adds a commit to fix the permission problem in /etc/gitconfig
> reported by SZEDER.
>
> This commit could/should be squashed into commit 5 if wanted.
> I left it on top for review purposes.

I think v4 has been in 'next' for several days already, so an
incremental update like PATCH 11/11 is good.  The first 10 patches
are identical to the previous round, so all is good ;-)
