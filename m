Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB947C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726E02075E
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x08mUr+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHUTLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:11:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57036 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgHUTLT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 15:11:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9843DE1909;
        Fri, 21 Aug 2020 15:11:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=x08mUr
        +BL78L+sBT25O2DNck589kAkuMWAysClHU2IQQpm/gHM4GxmnY2DYacRBNCFxx4m
        18SqF8L7g1CsshvsNhmABRcpsTtcm/rj3UnCdBarJBpoqYs64FNVZbQsDiE+csY+
        ZzDVZDu4LnoP64d9Hy52lqAzTahyBNNTLmLGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WXxCQaBxx3b18jIHa8/2aFeMot2p/x3o
        ZlX465aR//DbG4ChfuXVUBWcCfYQYiOxc1mbMXr85MydrI98kNlOLVs3Euu0qRzQ
        mUCpUleCT3IrQEQpliD9wZ+2r/+7RXeuEj1/VoYEv4Q+N2Nv7A/x8JkwEieTGXfP
        FncxhnkfT4A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D28CE1907;
        Fri, 21 Aug 2020 15:11:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A0580E1903;
        Fri, 21 Aug 2020 15:11:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Adrian via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Adrian <adrian@planetcoding.net>
Subject: Re: [PATCH v2] ci: fix inconsistent indentation
References: <pull.823.git.git.1597048659983.gitgitgadget@gmail.com>
        <pull.823.v2.git.git.1598002046754.gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 12:11:13 -0700
In-Reply-To: <pull.823.v2.git.git.1598002046754.gitgitgadget@gmail.com>
        (Adrian via GitGitGadget's message of "Fri, 21 Aug 2020 09:27:26
        +0000")
Message-ID: <xmqqimdb95m6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 153DF0A0-E3E2-11EA-80B1-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
