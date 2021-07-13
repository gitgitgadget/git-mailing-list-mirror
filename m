Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81DCC07E9A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 00:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916D2611CC
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 00:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhGMAUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 20:20:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55004 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhGMAUG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 20:20:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 724E9CE9CB;
        Mon, 12 Jul 2021 20:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=4klrOGtKOoih5E7qdazyml23TWB4+Um+E//TxtjWjo0=; b=tH5o
        oH8FB6Wg80B74FNgG1Iz9sWRnKV85auQ18YEzLJg7YpJxY170muu6XkLzSQhgMPv
        7aOj0LDxFFNLCY/N0tCRKjzZtEmG1Xaea0Wsyv2Q7Ir1lOt4yA9dn+k006XZ+nsT
        fGViwO5youq7hk++ehar8qU/rN/gVcZ6IjsO1Fc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AA87CE9CA;
        Mon, 12 Jul 2021 20:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8717CE9C9;
        Mon, 12 Jul 2021 20:17:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Luke Shumaker <lukeshu@lukeshu.com>
Subject: Re: [PATCH v2 0/2] extra: new concept of extra components
References: <20210710234629.17197-1-felipe.contreras@gmail.com>
        <c530dedb-8cad-2a73-5b56-a32173046382@gmail.com>
Date:   Mon, 12 Jul 2021 17:17:16 -0700
Message-ID: <xmqq5yxf2hkj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE46F034-E36F-11EB-BFBA-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> in a worktree created by 'git-new-workdir'. I do not think this enough justification
> to include 'git new-workdir' in 'extra/', since 'git worktree add' does the same thing
> and is a builtin command.

"git worktree" was invented primarily to properly solve what
new-workdir wanted to, so I agree that all efforts to promote,
upkeep and extend the latter should be spent to improve the former.


