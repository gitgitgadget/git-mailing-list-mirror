Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F2BC433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 00:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B254D23603
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 00:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbhAHAml (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 19:42:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62572 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbhAHAmk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 19:42:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C69F011F20E;
        Thu,  7 Jan 2021 19:41:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4UxDyJu/BzEGzyUqyAPlSlm2RKw=; b=th10V+
        gOYuYlMjfn4IJ+1N3SKRMaS12Rci9troikPw12+hP6ED86Hz0YCkigUj+vV5nOh+
        zQPDCVauBbBU350KnZWEO5pFPK8OvqLCA4c13xVNUu2mwvi3j/3xbX710dqjfrLq
        SK/kgap13YxSTs2PTR1G1aOQ7oXph2RPm4mDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QVMdrqhoVkhU8mKEp3GbaARQJyUDte+t
        oMfFFYyBST7Xc8FojJiCI7wgNNdx/YaJVpkXQPDqsK46eLpjpu67jcXKS0WyBBr0
        +2LDdJJ1KVD23UtxakUwVFqn5pgc2Z9O+7cK60sJmUwHz9ep50G4SkbZB+rMQcbk
        y5/eE0w3I2o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BEF6011F20C;
        Thu,  7 Jan 2021 19:41:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0BD8311F209;
        Thu,  7 Jan 2021 19:41:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v2 2/2] CoC: update to version 2.0 + local changes
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
        <20201228171734.30038-3-avarab@gmail.com>
        <xmqqmtxxedwd.fsf@gitster.c.googlers.com>
        <xmqqft3g463x.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2101080028150.2213@tvgsbejvaqbjf.bet>
Date:   Thu, 07 Jan 2021 16:41:54 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101080028150.2213@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 8 Jan 2021 00:28:49 +0100
        (CET)")
Message-ID: <xmqqa6tkjm3x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F0D5822-514A-11EB-A7F7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks, amended in.
