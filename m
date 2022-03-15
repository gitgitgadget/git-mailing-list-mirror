Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE8BC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 17:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiCOR6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiCOR6k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 13:58:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8AF522C5
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 10:57:27 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 94650185CB5;
        Tue, 15 Mar 2022 13:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r5qBnsCvVmiZpzP6NWgJ8b7lT9r8YOo2+LaGtA
        1lwDE=; b=BXJORKVUo8p2TjdIbNkH+VkgRkzptR9GgzQp5x13AW+9oNmvkuWKZG
        4PSRQ8Db7N4X1G4EEgb26SDvHu31bnBWgYXIlbBN70gkauFR3s3I02/lDTayu8+t
        pFzrjLsoaIQpi5P7Uep/CiJOg4blNfQpsfnvzUFaeLzRILGd4SjrA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DD87185CB4;
        Tue, 15 Mar 2022 13:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 19049185CB3;
        Tue, 15 Mar 2022 13:57:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] maintenance: fix synopsis in documentation
References: <pull.1178.git.1647366104967.gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 10:57:23 -0700
In-Reply-To: <pull.1178.git.1647366104967.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 15 Mar 2022 17:41:44
        +0000")
Message-ID: <xmqqmthrdrp8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E4C6394-A489-11EC-AF12-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The synopsis for 'git maintenance' did not include the commands other
> than the 'run' command. Update this to include the others. The 'start'
> command is the only one of these that parses additional options, and
> then only the --scheduler option.
>
> Also move the 'register' command down after 'stop' and before
> 'unregister' for a logical grouping of the commands instead of an
> alphabetical one. The diff makes it look as three other commands are
> moved up.

Will queue.  Thanks.
