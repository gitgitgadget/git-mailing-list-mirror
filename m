Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21151F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 02:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfJWCOq (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 22:14:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55415 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfJWCOq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 22:14:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FBF5360DF;
        Tue, 22 Oct 2019 22:14:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dViT/TkkB3NZPsVdnvWxskH7U1g=; b=hs/QTO
        9Jsjac+NVAoBDf5QvzkKW8uCaTZpkIzjafsxjeHgBh1DfaO39kUUyWWlf7s1XroF
        +jzih2pXXkXk5hcXTJewPmZ8JM410Qn5byloCD0RHq+HTu8fJBjkIrghzu7vGT6C
        pqRmv2ITS2699O8RXySleUH6RrNbjh/FuT9vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DlIbfCh6ESzvrsjmo9BCTMuL4rqf7ITC
        wybOsStcYj5jU9Me613q4KecLM4swPnSDpm8tu3YHWWVUcZQOWBjQW9Q4aQGDY7Q
        OCqfqJepbf0D6daFeFpNw8Xp0KcfrAfK54iburW2s4BTEueUD7j8uiMcduTtD8Sc
        sZgFWt9uji0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7630B360DE;
        Tue, 22 Oct 2019 22:14:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB4A4360DD;
        Tue, 22 Oct 2019 22:14:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 1/1] config: move documentation to config.h
References: <pull.405.git.1571357219.gitgitgadget@gmail.com>
        <pull.405.v2.git.1571727906.gitgitgadget@gmail.com>
        <1a9aa33b4649e2b723a6107520c2b5ad70774714.1571727906.git.gitgitgadget@gmail.com>
        <20191022205941.GD9323@google.com>
Date:   Wed, 23 Oct 2019 11:14:42 +0900
In-Reply-To: <20191022205941.GD9323@google.com> (Emily Shaffer's message of
        "Tue, 22 Oct 2019 13:59:41 -0700")
Message-ID: <xmqq8spcjjhp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0AC94B8-F53A-11E9-AF53-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> ...
>> +/**
>> + * The config API gives callers a way to access Git configuration files
>> + * (and files which have the same syntax). See linkgit:git-config[1] for a
>
> Ah, here's another place where the Asciidoc link isn't going to do
> anything anymore.
>
> Otherwise I didn't still see anything jumping out. When the commit
> message is cleaned up I'm ready to add my Reviewed-by line.

Thanks.  Your review(s) have been quite sensible and helpful.


