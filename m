Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF1AC3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 23:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC1920CC7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 23:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SETPJ2KR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgCCXM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:12:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56261 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbgCCXM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 18:12:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 031C243BDC;
        Tue,  3 Mar 2020 18:12:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/2VZoDpLBSI4edBpBPVSArdkn58=; b=SETPJ2
        KRYY8zzd+IBA09wToLHPEnOy+6vwWI1F1f93IuGH/NQczjjEH4GJsuQO8o+k02Wb
        /GLXoSwX7FebF8S2gncNlICMD0h9I1T0xsmF2k3fpyRMPLGGsbvnPui+SKM+kJr/
        wwVIXXCOM/AYVsFcGCmr51kUtdgp+xJ3JXoFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TCVN4NJ6RH9Flz40mMQsS2y2D28Z1lJk
        Ux7RuAgPvpP20QIzCzE58ZoQu3Ef9G1Qtd5xOI2MauzJZK6JrJIEijNjDlTkL+bJ
        XjUVWi1iSzRZFYDyvSfm+cVY6eckohhda9GTCvEb+NrY8Ocml7WzrtCNwVZirMy3
        7gA5l2JADek=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE25343BD9;
        Tue,  3 Mar 2020 18:12:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C7E743BD8;
        Tue,  3 Mar 2020 18:12:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2020, #01; Tue, 3)
References: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
        <20200303230554.GA11837@syl.local>
Date:   Tue, 03 Mar 2020 15:12:54 -0800
In-Reply-To: <20200303230554.GA11837@syl.local> (Taylor Blau's message of
        "Tue, 3 Mar 2020 15:05:54 -0800")
Message-ID: <xmqq1rq96nih.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84444FAE-5DA4-11EA-9E15-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> What's in 'v3' of that series [1] is ready to merge, in my opinion.

Alright.  Let's do so.

> [1]: https://lore.kernel.org/git/cover.1581486293.git.me@ttaylorr.com/#t

Thanks.
