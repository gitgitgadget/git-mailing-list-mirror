Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155121F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 03:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfJ2D3f (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 23:29:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54692 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfJ2D3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 23:29:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2B0534E41;
        Mon, 28 Oct 2019 23:29:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VLUGeAxhK/BJ
        jOO6rURu9c02HQQ=; b=TYYy6gtZhhXkyCL0LKKM+0cqvkBzjsWF6UabVkAEwMqr
        kd9aaSA158sIbk7GMaEhc9hUd/SQ5axyqFX/3+xK+8R4jVPOFtudyodXQtU/tId7
        mC4Lgbz6UKLwwKp16B9CrpwtPQjFA82gEqBqDeNKcbeBvmMgggmXNvMk4GWzRqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XYUdXJ
        YL5E4OMPGzus18jv6jce0uhyKwMXD3mXpOaaMxcd3E8w2EYCDGRiF1JUT0GNE0nx
        /Den3igdoZqj9PpQWX0kJYyUlCeRX8mQRIKhUpftsoxUU6QSlbET7rsUqnYv0mwB
        L9xDcWqwqvSCbf3O8/G0DsLhZK6no4Jg2ACGE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E98F334E40;
        Mon, 28 Oct 2019 23:29:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 573CE34E3F;
        Mon, 28 Oct 2019 23:29:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/blame.c: remove '--indent-heuristic' from usage string
References: <20191028105242.19260-1-szeder.dev@gmail.com>
Date:   Tue, 29 Oct 2019 12:29:31 +0900
In-Reply-To: <20191028105242.19260-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 28 Oct 2019 11:52:41 +0100")
Message-ID: <xmqq36fc6xgk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 528F992A-F9FC-11E9-99BD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Astute readers may notice that this patch removes a comment mentioning
> "the following two options", but it only removes one option.  The
> reason is that the comment is outdated: that other options was
> '--compaction-heuristic', and it has already been removed in
> 3cde4e02ee (diff: retire "compaction" heuristics, 2016-12-23), but
> that commit forgot to update this comment.

Thanks.
