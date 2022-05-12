Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EBEC433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 20:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357549AbiELUik (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 16:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351994AbiELUii (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 16:38:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63F754BD7
        for <git@vger.kernel.org>; Thu, 12 May 2022 13:38:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EAADB19B5E2;
        Thu, 12 May 2022 16:38:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y6veSPy3OXT1C8WcVxTq85dxLuhjODchCuEKj7
        a2/kM=; b=s7ypliyWGnzvXEjr6REdytwHoBlnmK2QzRXE7KR6Q6UtSAHHUJQHpo
        uFKtpVlC1MseO6HERz7abKPmBfkbLhbMweNREpkyWdPFIwSfpshE+jC958OUZpjx
        49JJSObqcmrm3h84ZSyVF76phppqZerOk5IDK/t0QOHnoqysQhQck=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2FA919B5E1;
        Thu, 12 May 2022 16:38:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 92B0919B5E0;
        Thu, 12 May 2022 16:38:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3] pull: do not let submodule.recurse override
 fetch.recurseSubmodules
References: <pull.1262.v2.git.git.1652210747614.gitgitgadget@gmail.com>
        <pull.1262.v3.git.git.1652312560207.gitgitgadget@gmail.com>
Date:   Thu, 12 May 2022 13:38:32 -0700
In-Reply-To: <pull.1262.v3.git.git.1652312560207.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Wed, 11 May 2022 23:42:40 +0000")
Message-ID: <xmqqv8uaebav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DBA63D4-D233-11EC-A465-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>

Let's see if there are any more inputs and start merging down to
'next'.

Thanks.

