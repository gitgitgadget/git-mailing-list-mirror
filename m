Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6871F1F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 21:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbdIAVxJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 17:53:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64915 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752519AbdIAVxI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 17:53:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9300D9E9F8;
        Fri,  1 Sep 2017 17:53:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=bJy8FxW1fVF69lEqH9ezOWXXdOk=; b=NKU08ci/lVsdgnW0Wjul
        qz7xs/cIbW8+DwrYpDLlcwmTVYW5BwgBgxeho4RZo6Jh8TbaDi4BbzQzaQ9dHn+Q
        yfVuNl5fBsQrv6NDsuOwK40kmTn8/qR56wB9GzEzRBl9FdeLwMMmomQaRAYka+9+
        8eVP2Gz5SjtpAHwOlbsmiI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=aAuFt4QdZ6f/dk16ZJk6Avou3ucpFuMj8sVUGSQ95xbavF
        pOkqoORlM54SncvYEo8C/5FTWJVFi/Eavthh7oNWuzHBlRDENzGtLOorHnAYMgUJ
        TfJAxKvI0Gtu2cYUn2UPrPiLbcbFQDBjCNnCCxfkVG7LJFRq3GowJYVIwZoTQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89AAC9E9F7;
        Fri,  1 Sep 2017 17:53:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E59AB9E9F6;
        Fri,  1 Sep 2017 17:53:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 02/12] load_subtree(): remove unnecessary conditional
References: <cover.1503734566.git.mhagger@alum.mit.edu>
        <c21bedbee9487792f4a336a417aa9874578aaac2.1503734566.git.mhagger@alum.mit.edu>
        <xmqqh8wuqo6e.fsf@gitster.mtv.corp.google.com>
        <CAMy9T_HYV9=HvrAnAxHgzRvUy__3o99PxQSOe2iCE_swtk_8VQ@mail.gmail.com>
        <CAMy9T_Gt=p==jHmx5nf8GeZBULACkjqC2zZqU+F31yx1xVaPBw@mail.gmail.com>
Date:   Sat, 02 Sep 2017 06:53:05 +0900
Message-ID: <xmqqr2vqhyri.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0042B08-8F5F-11E7-908C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Junio, I'm surprised that you have merged the `mh/notes-cleanup`
> branch into `next` already. Was that intentional?

Yup, I was clearing the deck as much as possible before I go
offline, as there didn't seem to be any glaring problem that we do
not even want to see in the history of our codebase in the series,
and I thought it would be better to give wider exposure early, as
long as small improvements are done incrementally.

Thanks.

ps. I'll still be offline for a bit more, so please do not get
disappointed if your updates do not show up in my tree until I come
back.



