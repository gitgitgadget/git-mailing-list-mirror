Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C35C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 16:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbiC2Qkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiC2Qkj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 12:40:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA14BF018
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 09:38:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70642194961;
        Tue, 29 Mar 2022 12:38:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R9LRu0cTJYbD6MNGoIbYaMDfWPeKgtixpy9WT+
        l1B/c=; b=hSKlu+DiufjKABVyInKOA4+oAVihYNaTjpKjc74EFCgD7Ah1oVaEGa
        jxFviMV5D8SI9SeA5CFBYxzocYY/b93rFBYHUSWUqFaajl2GrVdxotLRJZ8w98uo
        AgEmWKp0kyqhUnfGWLMRMDWIq5WPFiPfiQAsHySfAvZ3mNus4gVtU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68B34194960;
        Tue, 29 Mar 2022 12:38:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CEC2519495F;
        Tue, 29 Mar 2022 12:38:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com
Subject: Re: [PATCH v7 4/4] vimdiff: add description to already existing
 diff/merge tools
References: <20220328223019.271270-1-greenfoo@u92.eu>
        <20220328223019.271270-5-greenfoo@u92.eu>
Date:   Tue, 29 Mar 2022 09:38:51 -0700
In-Reply-To: <20220328223019.271270-5-greenfoo@u92.eu> (Fernando Ramos's
        message of "Tue, 29 Mar 2022 00:30:19 +0200")
Message-ID: <xmqqh77gww6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7F43CE6-AF7E-11EC-BF99-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

> ---

Missing log message and sign off.  "add description" tells us what
it did, which is easily visible in the patch text already.  The log
message should say why we are adding them, and the rationale has to
be better than "adding is better than not adding".  E.g. "in output
of X and Y, we only show the names without explanation on what they
are, which is not helpful enough" would be a helpful log message.

Doesn't the change in [3/4] to include these strings in generated
mergetools-*.txt file depend on this in place?

Thanks.
