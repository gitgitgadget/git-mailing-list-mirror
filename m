Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571AFC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 01:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388C661164
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 01:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242042AbhGTAVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 20:21:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59823 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350237AbhGSX6M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 19:58:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F478136012;
        Mon, 19 Jul 2021 20:38:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ktQpFjc3+BeYhXPiPMWmlYohgO4HQVKQdf8as3
        cMsBY=; b=tNsIaVyCJVNj31nHSzD6qL6YGD4IMbKJ2X9A9aQQ5MU3diWRG+QBaB
        bgMYOvtlYYsZqMLP+O9mMVNfZwCPL+iAHvGggKnB1AFN4LA2AdMQz8nVD8/l46lU
        AS61cXocrs9NdGD477UEJNYogXe5YtrzgDTzyQ5kdv5MlqUCjDy24=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06815136011;
        Mon, 19 Jul 2021 20:38:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0102D13600F;
        Mon, 19 Jul 2021 20:38:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: Re: [PATCH v4 0/9] ssh signing: Add commit & tag
 signing/verification via SSH keys using ssh-keygen
References: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
        <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 17:38:45 -0700
In-Reply-To: <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com> (Fabian
        Stelzer via GitGitGadget's message of "Mon, 19 Jul 2021 13:33:07
        +0000")
Message-ID: <xmqqh7gpizu2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D819FF36-E8F2-11EB-8781-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  create mode 100755 t/t7031-verify-tag-signed-ssh.sh
>  create mode 100755 t/t7527-signed-commit-ssh.sh

As the number 7527 is already in use by another topic in 'seen',
this new one must be relocated to coexist with them.
