Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AE6C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 23:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E8822285
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 23:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgLVXZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 18:25:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58893 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgLVXZR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 18:25:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D03C291A09;
        Tue, 22 Dec 2020 18:24:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=caG1ZxGkXQbd6PW3MuDCpF6kuqg=; b=sys47U
        BmLe6uniidimWqc1/m9rgCioFxGOuzIXisSY03KsiGuYb+3MXvcG9ZJ0qxgaWw2+
        Ngw/wtt5ykh9iEv00hm15IkGsy9Try4EuQa7b5kkr14QWpTkkxMVpYQSy6ewLfuC
        wPezIXcJ1iSOs+yKt3uic58Wn0uURRRF1ScDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DIuSThEcitpjToJm+oj3FKKNawaaoJAz
        Atd6QJD+8LsZo8EJ2WfLu103vtQNcFYA52KyPkKuq41MPTqVMT3ufxaXLQSIXNyq
        d8Gfu0FinjogxZ6OcAyhlBNbLcor4++l0tkYaJFIzzpJJIs/P5IsncM5zXIbsEt7
        b7ozXpkts3Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7CC391A08;
        Tue, 22 Dec 2020 18:24:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6092D91A07;
        Tue, 22 Dec 2020 18:24:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] core.abbrev <off|false|no> disables abbreviations
References: <20200901074355.GA4498@dcvr>
        <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com>
        <20200901144323.GA14554@dcvr>
        <xmqqbleliq58.fsf@gitster.c.googlers.com>
        <20201222231702.GA17661@dcvr>
Date:   Tue, 22 Dec 2020 15:24:33 -0800
In-Reply-To: <20201222231702.GA17661@dcvr> (Eric Wong's message of "Tue, 22
        Dec 2020 23:17:02 +0000")
Message-ID: <xmqqk0t9fmq6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9CD2DF2-44AC-11EB-A40B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Can somebody else take this over?  Sorry my brain isn't working
> well these months and I'm behind on other things :<

Surely and thanks for letting us know.  Take care and happy holidays
and new year to you.
